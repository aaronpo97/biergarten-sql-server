using System;
using System.Collections.Generic;
using DataAccessLayer.Entities;

namespace DataAccessLayer
{
    public interface IUserAccountRepository : IRepository<UserAccount>
    {
        IEnumerable<UserAccount> GetAll();
        UserAccount? GetByUsername(string username);
        UserAccount? GetByEmail(string email);
    }
}
