namespace DataAccessLayer.Repositories.UserCredential;

public interface IUserCredentialRepository
{
    Task Add(Entities.UserCredential credential);
    Task<Entities.UserCredential?> GetById(Guid userCredentialId);
    Task<Entities.UserCredential?> GetByUserAccountId(Guid userAccountId);
    Task<IEnumerable<Entities.UserCredential>> GetAll(int? limit, int? offset);
    Task Update(Entities.UserCredential credential);
    Task Delete(Guid userCredentialId);
}