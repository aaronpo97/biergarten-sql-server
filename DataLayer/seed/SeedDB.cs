using System.Data;
using System.Security.Cryptography;
using System.Text;
using Konscious.Security.Cryptography;
using Microsoft.Data.SqlClient;


string ConnectionString = Environment.GetEnvironmentVariable(
    "DB_CONNECTION_STRING"
)!;

static async Task BuildSchema(SqlConnection connection)
{
    string sql = await File.ReadAllTextAsync(GetScriptPath("schema.sql"));
    await ExecuteScriptAsync(connection, sql);
    Console.WriteLine("Database schema created or updated successfully.");
}

static async Task AddStoredProcsAndFunctions(SqlConnection connection)
{
    string projectRoot = Path.GetFullPath(
        Path.Combine(AppContext.BaseDirectory, "..", "..", "..")
    );

    string functionsDir = Path.Combine(projectRoot, "seed", "functions");
    string proceduresDir = Path.Combine(projectRoot, "seed", "procedures");
    string crudDir = Path.GetFullPath(
        Path.Combine(projectRoot, "..", "DataAccessLayer", "Sql", "crud")
    );

    if (Directory.Exists(functionsDir))
    {
        foreach (
            string file in Directory
                .EnumerateFiles(
                    functionsDir,
                    "*.sql",
                    SearchOption.TopDirectoryOnly
                )
                .OrderBy(f => f, StringComparer.OrdinalIgnoreCase)
        )
        {
            string sql = await File.ReadAllTextAsync(file);
            await ExecuteScriptAsync(connection, sql);
            Console.WriteLine(
                $"Executed function script: {Path.GetFileName(file)}"
            );
        }
    }

    if (Directory.Exists(proceduresDir))
    {
        foreach (
            string file in Directory
                .EnumerateFiles(
                    proceduresDir,
                    "*.sql",
                    SearchOption.TopDirectoryOnly
                )
                .OrderBy(f => f, StringComparer.OrdinalIgnoreCase)
        )
        {
            string sql = await File.ReadAllTextAsync(file);
            await ExecuteScriptAsync(connection, sql);
            Console.WriteLine(
                $"Executed procedure script: {Path.GetFileName(file)}"
            );
        }
    }

    if (Directory.Exists(crudDir))
    {
        foreach (
            string file in Directory
                .EnumerateFiles(
                    crudDir,
                    "*.sql",
                    SearchOption.TopDirectoryOnly
                )
                .OrderBy(f => f, StringComparer.OrdinalIgnoreCase)
        )
        {
            string sql = await File.ReadAllTextAsync(file);
            await ExecuteScriptAsync(connection, sql);
            Console.WriteLine(
                $"Executed CRUD script: {Path.GetFileName(file)}"
            );
        }
    }

    Console.WriteLine(
        "Functions and stored procedures added or updated successfully."
    );
    return;
}

static async Task RunSeedAsync(SqlConnection connection)
{
    await ExecuteStoredProcedureAsync(connection, "dbo.USP_AddTestUsers");
    Console.WriteLine("Inserted or refreshed test users.");

    DataTable credentialRows = await BuildCredentialTableAsync(connection);
    if (credentialRows.Rows.Count > 0)
    {
        await ExecuteCredentialProcedureAsync(connection, credentialRows);
        Console.WriteLine(
            $"Generated {credentialRows.Rows.Count} credential hashes."
        );
    }
    else
    {
        Console.WriteLine("No new credentials required.");
    }

    await ExecuteStoredProcedureAsync(
        connection,
        "dbo.USP_CreateUserVerification"
    );
    Console.WriteLine("Ensured verification rows exist for all users.");
}

static async Task ExecuteStoredProcedureAsync(
    SqlConnection connection,
    string storedProcedureName
)
{
    await using SqlCommand command = new SqlCommand(
        storedProcedureName,
        connection
    );
    command.CommandType = CommandType.StoredProcedure;
    await command.ExecuteNonQueryAsync();
}

static async Task ExecuteCredentialProcedureAsync(
    SqlConnection connection,
    DataTable credentialTable
)
{
    await using SqlCommand command = new SqlCommand(
        "dbo.USP_AddUserCredentials",
        connection
    );
    command.CommandType = CommandType.StoredProcedure;

    SqlParameter tvpParameter = command.Parameters.Add(
        "@Hash",
        SqlDbType.Structured
    );
    tvpParameter.TypeName = "dbo.TblUserHashes";
    tvpParameter.Value = credentialTable;

    await command.ExecuteNonQueryAsync();
}

static async Task<DataTable> BuildCredentialTableAsync(SqlConnection connection)
{
    const string sql = """
SELECT ua.UserAccountID,
       ua.Username
FROM dbo.UserAccount AS ua
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.UserCredential AS uc
    WHERE uc.UserAccountID = ua.UserAccountID);
""";

    await using SqlCommand command = new(sql, connection);
    await using SqlDataReader reader = await command.ExecuteReaderAsync();

    DataTable table = new();
    table.Columns.Add("UserAccountId", typeof(Guid));
    table.Columns.Add("Hash", typeof(string));

    while (await reader.ReadAsync())
    {
        Guid userId = reader.GetGuid(0);
        string username = reader.GetString(1);

        string password = CreatePlainTextPassword(username);
        string hash = GeneratePasswordHash(password);

        DataRow row = table.NewRow();
        row["UserAccountId"] = userId;
        row["Hash"] = hash;
        table.Rows.Add(row);
    }

    return table;
}

static string CreatePlainTextPassword(string username) => $"{username}#2025!";

static string GeneratePasswordHash(string password)
{
    byte[] salt = RandomNumberGenerator.GetBytes(16);

    var argon2 = new Argon2id(Encoding.UTF8.GetBytes(password))
    {
        Salt = salt,
        DegreeOfParallelism = Math.Max(Environment.ProcessorCount, 1),
        MemorySize = 65536,
        Iterations = 4,
    };

    byte[] hash = argon2.GetBytes(32);
    string saltBase64 = Convert.ToBase64String(salt);
    string hashBase64 = Convert.ToBase64String(hash);

    // Store salt and hash together so verification can rebuild the key material.
    return $"{saltBase64}:{hashBase64}";
}

static async Task ExecuteScriptAsync(SqlConnection connection, string sql)
{
    foreach (string batch in SplitSqlBatches(sql))
    {
        if (string.IsNullOrWhiteSpace(batch))
        {
            continue;
        }

        await using SqlCommand command = new(batch, connection);
        await command.ExecuteNonQueryAsync();
    }
}

static IEnumerable<string> SplitSqlBatches(string sql)
{
    using StringReader reader = new(sql);
    StringBuilder buffer = new();

    string? line;
    while ((line = reader.ReadLine()) is not null)
    {
        if (line.Trim().Equals("GO", StringComparison.OrdinalIgnoreCase))
        {
            yield return buffer.ToString();
            buffer.Clear();
            continue;
        }

        buffer.AppendLine(line);
    }

    if (buffer.Length > 0)
    {
        yield return buffer.ToString();
    }
}

static string GetScriptPath(string fileName)
{
    string projectRoot = Path.GetFullPath(
        Path.Combine(AppContext.BaseDirectory, "..", "..", "..")
    );
    string candidate = Path.Combine(projectRoot, fileName);

    if (File.Exists(candidate))
    {
        return candidate;
    }

    throw new FileNotFoundException(
        $"SQL script '{fileName}' was not found.",
        candidate
    );
}

try
{
    await using SqlConnection connection = new(ConnectionString);
    await connection.OpenAsync();
    Console.WriteLine("Connection to database established successfully.");

    await BuildSchema(connection);
    await AddStoredProcsAndFunctions(connection);
    await RunSeedAsync(connection);
    Console.WriteLine("Seeding complete.");
}
catch (Exception ex)
{
    Console.Error.WriteLine($"Seeding failed: {ex.Message}");
    Environment.ExitCode = 1;
}
