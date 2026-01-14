using System.Data;
using System.Security.Cryptography;
using System.Text;
using idunno.Password;
using Konscious.Security.Cryptography;
using Microsoft.Data.SqlClient;

namespace DBSeed;

class UserSeeder : ISeeder
{
    private static readonly IReadOnlyList<(
        string FirstName,
        string LastName
    )> SeedNames =
    [
        ("Aarya", "Mathews"),
        ("Aiden", "Wells"),
        ("Aleena", "Gonzalez"),
        ("Alessandra", "Nelson"),
        ("Amari", "Tucker"),
        ("Ameer", "Huff"),
        ("Amirah", "Hicks"),
        ("Analia", "Dominguez"),
        ("Anne", "Jenkins"),
        ("Apollo", "Davis"),
        ("Arianna", "White"),
        ("Aubree", "Moore"),
        ("Aubrielle", "Raymond"),
        ("Aydin", "Odom"),
        ("Bowen", "Casey"),
        ("Brock", "Huber"),
        ("Caiden", "Strong"),
        ("Cecilia", "Rosales"),
        ("Celeste", "Barber"),
        ("Chance", "Small"),
        ("Clara", "Roberts"),
        ("Collins", "Brandt"),
        ("Damir", "Wallace"),
        ("Declan", "Crawford"),
        ("Dennis", "Decker"),
        ("Dylan", "Lang"),
        ("Eliza", "Kane"),
        ("Elle", "Poole"),
        ("Elliott", "Miles"),
        ("Emelia", "Lucas"),
        ("Emilia", "Simpson"),
        ("Emmett", "Lugo"),
        ("Ethan", "Stephens"),
        ("Etta", "Woods"),
        ("Gael", "Moran"),
        ("Grant", "Benson"),
        ("Gwen", "James"),
        ("Huxley", "Chen"),
        ("Isabella", "Fisher"),
        ("Ivan", "Mathis"),
        ("Jamir", "McMillan"),
        ("Jaxson", "Shields"),
        ("Jimmy", "Richmond"),
        ("Josiah", "Flores"),
        ("Kaden", "Enriquez"),
        ("Kai", "Lawson"),
        ("Karsyn", "Adkins"),
        ("Karsyn", "Proctor"),
        ("Kayden", "Henson"),
        ("Kaylie", "Spears"),
        ("Kinslee", "Jones"),
        ("Kora", "Guerra"),
        ("Lane", "Skinner"),
        ("Laylani", "Christian"),
        ("Ledger", "Carroll"),
        ("Leilany", "Small"),
        ("Leland", "McCall"),
        ("Leonard", "Calhoun"),
        ("Levi", "Ochoa"),
        ("Lillie", "Vang"),
        ("Lola", "Sheppard"),
        ("Luciana", "Poole"),
        ("Maddox", "Hughes"),
        ("Mara", "Blackwell"),
        ("Marcellus", "Bartlett"),
        ("Margo", "Koch"),
        ("Maurice", "Gibson"),
        ("Maxton", "Dodson"),
        ("Mia", "Parrish"),
        ("Millie", "Fuentes"),
        ("Nellie", "Villanueva"),
        ("Nicolas", "Mata"),
        ("Nicolas", "Miller"),
        ("Oakleigh", "Foster"),
        ("Octavia", "Pierce"),
        ("Paisley", "Allison"),
        ("Quincy", "Andersen"),
        ("Quincy", "Frazier"),
        ("Raiden", "Roberts"),
        ("Raquel", "Lara"),
        ("Rudy", "McIntosh"),
        ("Salvador", "Stein"),
        ("Samantha", "Dickson"),
        ("Solomon", "Richards"),
        ("Sylvia", "Hanna"),
        ("Talia", "Trujillo"),
        ("Thalia", "Farrell"),
        ("Trent", "Mayo"),
        ("Trinity", "Cummings"),
        ("Ty", "Perry"),
        ("Tyler", "Romero"),
        ("Valeria", "Pierce"),
        ("Vance", "Neal"),
        ("Whitney", "Bell"),
        ("Wilder", "Graves"),
        ("William", "Logan"),
        ("Zara", "Wilkinson"),
        ("Zaria", "Gibson"),
        ("Zion", "Watkins"),
        ("Zoie", "Armstrong"),
    ];

    public async Task SeedAsync(SqlConnection connection)
    {
        var generator = new PasswordGenerator();
        var random = new Random();
        int createdUsers = 0;
        int createdCredentials = 0;
        int createdVerifications = 0;

        foreach (var (firstName, lastName) in SeedNames)
        {
            string username = BuildUsername(firstName, lastName);
            string email = BuildEmail(firstName, lastName);
            Guid? existingId =
                await GetUserAccountIdByUsernameAsync(connection, username)
                ?? await GetUserAccountIdByEmailAsync(connection, email);

            Guid userAccountId;
            if (existingId.HasValue)
            {
                userAccountId = existingId.Value;
            }
            else
            {
                userAccountId = Guid.NewGuid();
                DateTime dateOfBirth = GenerateDateOfBirth(random);
                await CreateUserAccountAsync(
                    connection,
                    userAccountId,
                    username,
                    firstName,
                    lastName,
                    email,
                    dateOfBirth
                );
                createdUsers++;
            }

            if (!await HasUserCredentialAsync(connection, userAccountId))
            {
                string pwd = generator.Generate(
                    length: 64,
                    numberOfDigits: 10,
                    numberOfSymbols: 10
                );
                string hash = GeneratePasswordHash(pwd);
                await AddUserCredentialAsync(connection, userAccountId, hash);
                createdCredentials++;
            }

            if (!await HasUserVerificationAsync(connection, userAccountId))
            {
                await AddUserVerificationAsync(connection, userAccountId);
                createdVerifications++;
            }
        }

        Console.WriteLine($"Created {createdUsers} user accounts.");
        Console.WriteLine($"Added {createdCredentials} user credentials.");
        Console.WriteLine($"Added {createdVerifications} user verifications.");
    }

    private static string GeneratePasswordHash(string pwd)
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

    private static async Task<Guid?> GetUserAccountIdByUsernameAsync(
        SqlConnection connection,
        string username
    )
    {
        await using var command = new SqlCommand(
            "usp_GetUserAccountByUsername",
            connection
        );
        command.CommandType = CommandType.StoredProcedure;
        command.Parameters.AddWithValue("@Username", username);

        await using var reader = await command.ExecuteReaderAsync();
        return await reader.ReadAsync() ? reader.GetGuid(0) : null;
    }

    private static async Task<Guid?> GetUserAccountIdByEmailAsync(
        SqlConnection connection,
        string email
    )
    {
        await using var command = new SqlCommand(
            "usp_GetUserAccountByEmail",
            connection
        );
        command.CommandType = CommandType.StoredProcedure;
        command.Parameters.AddWithValue("@Email", email);

        await using var reader = await command.ExecuteReaderAsync();
        return await reader.ReadAsync() ? reader.GetGuid(0) : null;
    }

    private static async Task CreateUserAccountAsync(
        SqlConnection connection,
        Guid userAccountId,
        string username,
        string firstName,
        string lastName,
        string email,
        DateTime dateOfBirth
    )
    {
        await using var command = new SqlCommand(
            "usp_CreateUserAccount",
            connection
        );
        command.CommandType = CommandType.StoredProcedure;
        command.Parameters.AddWithValue("@UserAccountId", userAccountId);
        command.Parameters.AddWithValue("@Username", username);
        command.Parameters.AddWithValue("@FirstName", firstName);
        command.Parameters.AddWithValue("@LastName", lastName);
        command.Parameters.AddWithValue("@DateOfBirth", dateOfBirth);
        command.Parameters.AddWithValue("@Email", email);

        await command.ExecuteNonQueryAsync();
    }

    private static async Task<bool> HasUserCredentialAsync(
        SqlConnection connection,
        Guid userAccountId
    )
    {
        const string sql = """
SELECT 1
FROM dbo.UserCredential
WHERE UserAccountId = @UserAccountId;
""";
        await using var command = new SqlCommand(sql, connection);
        command.Parameters.AddWithValue("@UserAccountId", userAccountId);
        object? result = await command.ExecuteScalarAsync();
        return result is not null;
    }

    private static async Task AddUserCredentialAsync(
        SqlConnection connection,
        Guid userAccountId,
        string hash
    )
    {
        await using var command = new SqlCommand(
            "dbo.USP_AddUserCredential",
            connection
        );
        command.CommandType = CommandType.StoredProcedure;
        command.Parameters.AddWithValue("@UserAccountId", userAccountId);
        command.Parameters.AddWithValue("@Hash", hash);

        await command.ExecuteNonQueryAsync();
    }

    private static async Task<bool> HasUserVerificationAsync(
        SqlConnection connection,
        Guid userAccountId
    )
    {
        const string sql = """
SELECT 1
FROM dbo.UserVerification
WHERE UserAccountId = @UserAccountId;
""";
        await using var command = new SqlCommand(sql, connection);
        command.Parameters.AddWithValue("@UserAccountId", userAccountId);
        object? result = await command.ExecuteScalarAsync();
        return result is not null;
    }

    private static async Task AddUserVerificationAsync(
        SqlConnection connection,
        Guid userAccountId
    )
    {
        await using var command = new SqlCommand(
            "dbo.USP_CreateUserVerification",
            connection
        );
        command.CommandType = CommandType.StoredProcedure;
        command.Parameters.AddWithValue("@UserAccountID", userAccountId);

        await command.ExecuteNonQueryAsync();
    }

    private static string BuildUsername(string firstName, string lastName)
    {
        string username = $"{firstName}.{lastName}".ToLowerInvariant();
        return username.Length <= 64 ? username : username[..64];
    }

    private static string BuildEmail(string firstName, string lastName)
    {
        string email = $"{firstName}.{lastName}@example.com".ToLowerInvariant();
        return email.Length <= 128 ? email : email[..128];
    }

    private static DateTime GenerateDateOfBirth(Random random)
    {
        int age = 19 + random.Next(0, 30);
        DateTime baseDate = DateTime.UtcNow.Date.AddYears(-age);
        int offsetDays = random.Next(0, 365);
        return baseDate.AddDays(-offsetDays);
    }
}
