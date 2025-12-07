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
            
        }

        public UserAccount? GetById(Guid id)
        {
            
            return null;
        }

        public void Update(UserAccount userAccount)
        {

        }

        public void Delete(Guid id)
        {
            
        }

        public IEnumerable<UserAccount> GetAll()
        {
          return new List<UserAccount>
          {
          };
        }
    }
}
