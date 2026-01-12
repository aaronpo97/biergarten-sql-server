using System;
using System.Data;
using Microsoft.Data.SqlClient;

namespace DataAccessLayer.Sql
{
    public class DatabaseHelper
    {
        private readonly string _connectionString;

        public DatabaseHelper(string connectionString)
        {
            _connectionString = connectionString;
        }

        public void ExecuteRawSql(string query)
        {
            try
            {
                using (
                    SqlConnection connection = new SqlConnection(
                        _connectionString
                    )
                )
                {
                    connection.Open();

                    using (
                        SqlCommand command = new SqlCommand(query, connection)
                    )
                    {
                        command.CommandType = CommandType.Text;

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                for (int i = 0; i < reader.FieldCount; i++)
                                {
                                    Console.WriteLine(
                                        $"{reader.GetName(i)}: {reader.GetValue(i)}"
                                    );
                                }
                            }
                        }
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
