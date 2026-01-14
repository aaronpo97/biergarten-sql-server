using Microsoft.Data.SqlClient;

interface ISeeder
{
    Task SeedAsync(SqlConnection connection);
}