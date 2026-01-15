using DataAccessLayer.Entities;
using Microsoft.Data.SqlClient;

namespace DataAccessLayer.Repositories
{
    public class UserAccountRepository : IUserAccountRepository
    {
        private readonly string _connectionString = Environment.GetEnvironmentVariable("DB_CONNECTION_STRING")
                                                    ?? throw new InvalidOperationException(
                                                        "The connection string is not set in the environment variables."
                                                    );

        public void Add(UserAccount userAccount)
        {
            using SqlConnection connection = new(_connectionString);
            using SqlCommand command = new("usp_CreateUserAccount", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            
            command.Parameters.AddWithValue(
                "@UserAccountId",
                userAccount.UserAccountId
            );
            command.Parameters.AddWithValue("@Username", userAccount.Username);
            command.Parameters.AddWithValue(
                "@FirstName",
                userAccount.FirstName
            );
            command.Parameters.AddWithValue("@LastName", userAccount.LastName);
            command.Parameters.AddWithValue("@Email", userAccount.Email);
            command.Parameters.AddWithValue(
                "@DateOfBirth",
                userAccount.DateOfBirth
            );
            connection.Open();
            command.ExecuteNonQuery();
        }

        public UserAccount? GetById(Guid id)
        {
            using SqlConnection connection = new(_connectionString);
            using SqlCommand command = new(
                "usp_GetUserAccountById",
                connection
            );
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@UserAccountId", id);
            connection.Open();

            using SqlDataReader reader = command.ExecuteReader();
            return reader.Read() ? MapToEntity(reader) : null;
        }

        public void Update(UserAccount userAccount)
        {
            using SqlConnection connection = new(_connectionString);
            using SqlCommand command = new("usp_UpdateUserAccount", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue(
                "@UserAccountId",
                userAccount.UserAccountId
            );
            command.Parameters.AddWithValue("@Username", userAccount.Username);
            command.Parameters.AddWithValue(
                "@FirstName",
                userAccount.FirstName
            );
            command.Parameters.AddWithValue("@LastName", userAccount.LastName);
            command.Parameters.AddWithValue("@Email", userAccount.Email);
            command.Parameters.AddWithValue(
                "@DateOfBirth",
                userAccount.DateOfBirth
            );
            command.Parameters.AddWithValue(
                "@UserAccountId",
                userAccount.UserAccountId
            );
            connection.Open();
            command.ExecuteNonQuery();
        }

        public void Delete(Guid id)
        {
            using SqlConnection connection = new(_connectionString);
            using SqlCommand command = new("usp_DeleteUserAccount", connection);
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@UserAccountId", id);
            connection.Open();
            command.ExecuteNonQuery();
        }

      
        public IEnumerable<UserAccount> GetAll(int? limit, int? offset)
        {
            if (limit is <= 0)
            {
                throw new ArgumentOutOfRangeException(
                    nameof(limit),
                    "Limit must be greater than zero."
                );
            }

            if (offset < 0)
            {
                throw new ArgumentOutOfRangeException(
                    nameof(offset),
                    "Offset cannot be negative."
                );
            }

            if (offset.HasValue && !limit.HasValue)
            {
                throw new ArgumentOutOfRangeException(
                    nameof(offset),
                    "Offset cannot be provided without a limit."
                );
            }

            using SqlConnection connection = new(_connectionString);
            using SqlCommand command = new(
                "usp_GetAllUserAccounts",
                connection
            );
            command.CommandType = System.Data.CommandType.StoredProcedure;
            if (limit.HasValue)
            {
                command.Parameters.AddWithValue("@Limit", limit.Value);
            }
            if (offset.HasValue)
            {
                command.Parameters.AddWithValue("@Offset", offset.Value);
            }
            connection.Open();

            using SqlDataReader reader = command.ExecuteReader();
            List<UserAccount> users = new();
            while (reader.Read())
            {
                users.Add(MapToEntity(reader));
            }

            return users;
        }

        public UserAccount? GetByUsername(string username)
        {
            using SqlConnection connection = new(_connectionString);
            using SqlCommand command = new(
                "usp_GetUserAccountByUsername",
                connection
            );
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@Username", username);
            connection.Open();

            using SqlDataReader? reader = command.ExecuteReader();
            return reader.Read() ? MapToEntity(reader) : null;
        }

        public UserAccount? GetByEmail(string email)
        {
            using SqlConnection connection = new(_connectionString);
            using SqlCommand command = new(
                "usp_GetUserAccountByEmail",
                connection
            );
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@Email", email);
            connection.Open();

            using SqlDataReader reader = command.ExecuteReader();
            return reader.Read() ? MapToEntity(reader) : null;
        }

        public UserAccount MapToEntity(SqlDataReader reader)
        {
            return new UserAccount
            {
                UserAccountId = reader.GetGuid(0),
                Username = reader.GetString(1),
                FirstName = reader.GetString(2),
                LastName = reader.GetString(3),
                Email = reader.GetString(4),
                CreatedAt = reader.GetDateTime(5),
                UpdatedAt = reader.IsDBNull(6) ? null : reader.GetDateTime(6),
                DateOfBirth = reader.GetDateTime(7),
                Timer = reader.IsDBNull(8) ? null : (byte[])reader[8],
            };
        }
    }
}
