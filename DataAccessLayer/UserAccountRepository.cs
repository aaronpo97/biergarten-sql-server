using System;
using System.Collections.Generic;
using System.Data;
using DataAccessLayer.Entities;
using Microsoft.Data.SqlClient;

namespace DataAccessLayer
{
    public class UserAccountRepository : IRepository<UserAccount>
    {
        private readonly string _connectionString;

        public UserAccountRepository()
        {
            // Retrieve the connection string from environment variables
            _connectionString =
                Environment.GetEnvironmentVariable("DB_CONNECTION_STRING")
                ?? throw new InvalidOperationException(
                    "The connection string is not set in the environment variables."
                );

           
        }
        
        public void Add(UserAccount userAccount)
        {
            const string query =
                @"INSERT INTO UserAccount (UserAccountID, Username, FirstName, LastName, Email, CreatedAt, UpdatedAt, DateOfBirth, Timer) 
                  VALUES (@UserAccountID, @Username, @FirstName, @LastName, @Email, @CreatedAt, @UpdatedAt, @DateOfBirth, @Timer);";

            using (var connection = new SqlConnection(_connectionString))
            using (var command = new SqlCommand(query, connection))
            {
                _ = command.Parameters.AddWithValue(
                    "@UserAccountID",
                    userAccount.UserAccountID
                );
                _ = command.Parameters.AddWithValue(
                    "@Username",
                    userAccount.Username
                );
                _ = command.Parameters.AddWithValue(
                    "@FirstName",
                    userAccount.FirstName
                );
                _ = command.Parameters.AddWithValue(
                    "@LastName",
                    userAccount.LastName
                );
                _ = command.Parameters.AddWithValue(
                    "@Email",
                    userAccount.Email
                );
                _ = command.Parameters.AddWithValue(
                    "@CreatedAt",
                    userAccount.CreatedAt
                );
                _ = command.Parameters.AddWithValue(
                    "@UpdatedAt",
                    userAccount.UpdatedAt ?? (object)DBNull.Value
                );
                _ = command.Parameters.AddWithValue(
                    "@DateOfBirth",
                    userAccount.DateOfBirth
                );
                _ = command.Parameters.AddWithValue(
                    "@Timer",
                    userAccount.Timer ?? (object)DBNull.Value
                );

                connection.Open();
                _ = command.ExecuteNonQuery();
            }
        }

        public UserAccount? GetById(Guid id)
        {
            const string query =
                "SELECT * FROM UserAccount WHERE UserAccountID = @UserAccountID;";

            using (var connection = new SqlConnection(_connectionString))
            using (var command = new SqlCommand(query, connection))
            {
                _ = command.Parameters.AddWithValue("@UserAccountID", id);

                connection.Open();
                using (var reader = command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        return new UserAccount
                        {
                            UserAccountID = reader.GetGuid(
                                reader.GetOrdinal("UserAccountID")
                            ),
                            Username = reader.GetString(
                                reader.GetOrdinal("Username")
                            ),
                            FirstName = reader.GetString(
                                reader.GetOrdinal("FirstName")
                            ),
                            LastName = reader.GetString(
                                reader.GetOrdinal("LastName")
                            ),
                            Email = reader.GetString(
                                reader.GetOrdinal("Email")
                            ),
                            CreatedAt = reader.GetDateTime(
                                reader.GetOrdinal("CreatedAt")
                            ),
                            UpdatedAt = reader.IsDBNull(
                                reader.GetOrdinal("UpdatedAt")
                            )
                                ? null
                                : reader.GetDateTime(
                                    reader.GetOrdinal("UpdatedAt")
                                ),
                            DateOfBirth = reader.GetDateTime(
                                reader.GetOrdinal("DateOfBirth")
                            ),
                            Timer = reader.IsDBNull(reader.GetOrdinal("Timer"))
                                ? null
                                : (byte[])reader["Timer"],
                        };
                    }
                }
            }

            return null;
        }

        public void Update(UserAccount userAccount)
        {
            const string query =
                @"UPDATE UserAccount 
                  SET Username = @Username, FirstName = @FirstName, LastName = @LastName, Email = @Email, CreatedAt = @CreatedAt, UpdatedAt = @UpdatedAt, DateOfBirth = @DateOfBirth, Timer = @Timer 
                  WHERE UserAccountID = @UserAccountID;";

            using (var connection = new SqlConnection(_connectionString))
            using (var command = new SqlCommand(query, connection))
            {
                _ = command.Parameters.AddWithValue(
                    "@UserAccountID",
                    userAccount.UserAccountID
                );
                _ = command.Parameters.AddWithValue(
                    "@Username",
                    userAccount.Username
                );
                _ = command.Parameters.AddWithValue(
                    "@FirstName",
                    userAccount.FirstName
                );
                _ = command.Parameters.AddWithValue(
                    "@LastName",
                    userAccount.LastName
                );
                _ = command.Parameters.AddWithValue(
                    "@Email",
                    userAccount.Email
                );
                _ = command.Parameters.AddWithValue(
                    "@CreatedAt",
                    userAccount.CreatedAt
                );
                _ = command.Parameters.AddWithValue(
                    "@UpdatedAt",
                    userAccount.UpdatedAt ?? (object)DBNull.Value
                );
                _ = command.Parameters.AddWithValue(
                    "@DateOfBirth",
                    userAccount.DateOfBirth
                );
                _ = command.Parameters.AddWithValue(
                    "@Timer",
                    userAccount.Timer ?? (object)DBNull.Value
                );

                connection.Open();
                _ = command.ExecuteNonQuery();
            }
        }

        public void Delete(Guid id)
        {
            const string query =
                "DELETE FROM UserAccount WHERE UserAccountID = @UserAccountID;";

            using (var connection = new SqlConnection(_connectionString))
            using (var command = new SqlCommand(query, connection))
            {
                _ = command.Parameters.AddWithValue("@UserAccountID", id);

                connection.Open();
                _ = command.ExecuteNonQuery();
            }
        }

        public IEnumerable<UserAccount> GetAll()
        {
            const string query = "SELECT * FROM UserAccount;";

            var userAccounts = new List<UserAccount>();

            using (var connection = new SqlConnection(_connectionString))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        var userAccount = new UserAccount
                        {
                            UserAccountID = reader.GetGuid(
                                reader.GetOrdinal("UserAccountID")
                            ),
                            Username = reader.GetString(
                                reader.GetOrdinal("Username")
                            ),
                            FirstName = reader.GetString(
                                reader.GetOrdinal("FirstName")
                            ),
                            LastName = reader.GetString(
                                reader.GetOrdinal("LastName")
                            ),
                            Email = reader.GetString(
                                reader.GetOrdinal("Email")
                            ),
                            CreatedAt = reader.GetDateTime(
                                reader.GetOrdinal("CreatedAt")
                            ),
                            UpdatedAt = reader.IsDBNull(
                                reader.GetOrdinal("UpdatedAt")
                            )
                                ? null
                                : reader.GetDateTime(
                                    reader.GetOrdinal("UpdatedAt")
                                ),
                            DateOfBirth = reader.GetDateTime(
                                reader.GetOrdinal("DateOfBirth")
                            ),
                            Timer = reader.IsDBNull(reader.GetOrdinal("Timer"))
                                ? null
                                : (byte[])reader["Timer"],
                        };

                        userAccounts.Add(userAccount);
                    }
                }
            }

            return userAccounts;
        }
    }
}
