using System.Data;
using System.Security.Cryptography;
using System.Text;
using idunno.Password;
using Konscious.Security.Cryptography;
using Microsoft.Data.SqlClient;

/// <summary>
/// Executes USP_AddUserCredentials to add missing user credentials using a table-valued parameter
/// consisting of the user account id and a generated Argon2 hash.
/// </summary>
/// <param name="connection">An open SQL connection.</param>
/// <param name="credentialTable">A table-valued parameter payload containing user IDs and hashes.</param>
static async Task ExecuteCredentialProcedureAsync(SqlConnection connection, DataTable credentialTable)
{
    await using var command = new SqlCommand("dbo.USP_AddUserCredentials", connection)
    {
        CommandType = CommandType.StoredProcedure
    };

    // Must match your stored proc parameter name:
    var tvpParameter = command.Parameters.Add("@Hash", SqlDbType.Structured);
    tvpParameter.TypeName = "dbo.TblUserHashes";
    tvpParameter.Value = credentialTable;

    await command.ExecuteNonQueryAsync();
}

/// <summary>
/// Builds a DataTable of user account IDs and generated Argon2 password hashes for users that do not yet
/// have credentials.
/// </summary>
/// <param name="connection">An open SQL connection.</param>
/// <returns>A DataTable matching dbo.TblUserHashes with user IDs and hashes.</returns>
static async Task<DataTable> BuildCredentialTableAsync(SqlConnection connection)
{
    const string sql = """
SELECT ua.UserAccountID
FROM dbo.UserAccount AS ua
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.UserCredential AS uc
    WHERE uc.UserAccountID = ua.UserAccountID
);
""";

    await using var command = new SqlCommand(sql, connection);
    await using var reader = await command.ExecuteReaderAsync();

    // IMPORTANT: column names/types/order should match dbo.TblUserHashes
    var table = new DataTable();
    table.Columns.Add("UserAccountID", typeof(Guid));
    table.Columns.Add("Hash", typeof(string));

    var generator = new PasswordGenerator();

    while (await reader.ReadAsync())
    {
        Guid userId = reader.GetGuid(0);

        // idunno.Password PasswordGenerator signature:
        // Generate(length, numberOfDigits, numberOfSymbols, noUpper, allowRepeat)
        string pwd = generator.Generate(
            length: 64,
            numberOfDigits: 10,
            numberOfSymbols: 10
        );

        string hash = GeneratePasswordHash(pwd);

        var row = table.NewRow();
        row["UserAccountID"] = userId;
        row["Hash"] = hash;
        table.Rows.Add(row);
    }

    return table;
}

/// <summary>
/// Generates an Argon2id hash for the given password.
/// </summary>
/// <param name="pwd">The plaintext password.</param>
/// <returns>A string in the format "base64(salt):base64(hash)".</returns>
static string GeneratePasswordHash(string pwd)
{
    byte[] salt = RandomNumberGenerator.GetBytes(16);

    var argon2 = new Argon2id(Encoding.UTF8.GetBytes(pwd))
    {
        Salt = salt,
        DegreeOfParallelism = Math.Max(Environment.ProcessorCount, 1),
        MemorySize = 65536,
        Iterations = 4,
    };

    byte[] hash = argon2.GetBytes(32);
    return $"{Convert.ToBase64String(salt)}:{Convert.ToBase64String(hash)}";
}

/// <summary>
/// Runs the seed process to add test users and generate missing credentials.
/// </summary>
/// <param name="connection">An open SQL connection.</param>
static async Task RunSeedAsync(SqlConnection connection)
{
    //run add test users
    await using var insertCommand = new SqlCommand("dbo.USP_SeedTestUsers", connection)
    {
        CommandType = CommandType.StoredProcedure
    };
    await insertCommand.ExecuteNonQueryAsync();

    Console.WriteLine("Inserted or refreshed test users.");

    DataTable credentialRows = await BuildCredentialTableAsync(connection);
    if (credentialRows.Rows.Count == 0)
    {
        Console.WriteLine("No new credentials required.");
        return;
    }

    await ExecuteCredentialProcedureAsync(connection, credentialRows);
    Console.WriteLine($"Generated {credentialRows.Rows.Count} credential hashes.");
}
