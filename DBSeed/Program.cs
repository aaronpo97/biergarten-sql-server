using DBSeed;
using Microsoft.Data.SqlClient;

try
{
    var connectionString = Environment.GetEnvironmentVariable(
        "DB_CONNECTION_STRING"
    );
    if (string.IsNullOrWhiteSpace(connectionString))
        throw new InvalidOperationException(
            "Environment variable DB_CONNECTION_STRING is not set or is empty."
        );

    await using var connection = new SqlConnection(connectionString);
    await connection.OpenAsync();

    Console.WriteLine("Connected to database.");

    await LocationSeeder.SeedAsync(connection);
    Console.WriteLine("Seeded locations.");

    await UserSeeder.SeedAsync(connection);
    Console.WriteLine("Seeded users.");

    Console.WriteLine("Seed completed successfully.");
    return 0;
}
catch (Exception ex)
{
    Console.Error.WriteLine("Seed failed:");
    Console.Error.WriteLine(ex);
    return 1;
}
