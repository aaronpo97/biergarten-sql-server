using DataAccessLayer.Entities;

namespace DataAccessLayer.Repositories
{
    public interface IUserAccountRepository : IRepository<UserAccount>
    {
        UserAccount? GetByUsername(string username);
        UserAccount? GetByEmail(string email);
    }
}
