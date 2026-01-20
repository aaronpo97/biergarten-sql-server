

namespace DataAccessLayer.Repositories.UserAccount
{
    public interface IUserAccountRepository
    {
        Task Add(Entities.UserAccount userAccount);
        Task<Entities.UserAccount?> GetById(Guid id);
        Task<IEnumerable<Entities.UserAccount>> GetAll(int? limit, int? offset);
        Task Update(Entities.UserAccount userAccount);
        Task Delete(Guid id);
        Task<Entities.UserAccount?> GetByUsername(string username);
        Task<Entities.UserAccount?> GetByEmail(string email);
    }
}
