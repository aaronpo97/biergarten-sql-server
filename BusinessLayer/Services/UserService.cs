using DataAccessLayer;
using DataAccessLayer.Entities;
using DataAccessLayer.Repositories;

namespace BusinessLayer.Services
{
    public class UserService : IUserService
    {
        private readonly IUserAccountRepository _userAccountRepository;

        public UserService(IUserAccountRepository userAccountRepository)
        {
            _userAccountRepository = userAccountRepository;
        }

        public IEnumerable<UserAccount> GetAll(int? limit, int? offset)
        {
            return _userAccountRepository.GetAll(limit, offset);
        }

        public UserAccount? GetById(Guid id)
        {
            return _userAccountRepository.GetById(id);
        }

        public UserAccount? GetByUsername(string username)
        {
            return _userAccountRepository.GetByUsername(username);
        }

        public UserAccount? GetByEmail(string email)
        {
            return _userAccountRepository.GetByEmail(email);
        }

        public void Add(UserAccount userAccount)
        {
            _userAccountRepository.Add(userAccount);
        }

        public void Update(UserAccount userAccount)
        {
            _userAccountRepository.Update(userAccount);
        }

        public void Delete(Guid id)
        {
            _userAccountRepository.Delete(id);
        }
    }
}
