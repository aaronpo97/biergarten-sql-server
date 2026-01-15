using DataAccessLayer.Sql;
using Microsoft.Data.SqlClient;

namespace WebAPI.Infrastructure
{
    public class DefaultSqlConnectionFactory : ISqlConnectionFactory
    {
        private readonly string _connectionString;

        public DefaultSqlConnectionFactory(IConfiguration configuration)
        {
            _connectionString =
                Environment.GetEnvironmentVariable("DB_CONNECTION_STRING")
                ?? configuration.GetConnectionString("Default")
                ?? throw new InvalidOperationException(
                    "Database connection string not configured. Set DB_CONNECTION_STRING env var or ConnectionStrings:Default."
                );
        }

        public SqlConnection CreateConnection()
        {
            return new SqlConnection(_connectionString);
        }
    }
}
