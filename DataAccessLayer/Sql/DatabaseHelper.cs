using System;
using System.Data;
using Microsoft.Data.SqlClient;

namespace DataAccessLayer.Sql
{
    public class DatabaseHelper(string connectionString)
    {
        public void ExecuteRawSql(string query)
        {
            try
            {
                using var connection = new SqlConnection(
                    connectionString
                );
                
                connection.Open();

                using var command = new SqlCommand(query, connection);
                
                command.CommandType = CommandType.Text;

                using var reader = command.ExecuteReader();
                
                while (reader.Read())
                {
                    for (var i = 0; i < reader.FieldCount; i++)
                    {
                        Console.WriteLine(
                            $"{reader.GetName(i)}: {reader.GetValue(i)}"
                        );
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"An error occurred: {ex.Message}");
            }
        }
    }
}
