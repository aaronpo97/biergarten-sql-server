using DataAccessLayer.Entities;

namespace BusinessLayer.Services
{
    public interface IUserService : IService<UserAccount>
    {
        UserAccount? GetByUsername(string username);
        UserAccount? GetByEmail(string email);
    }
}
