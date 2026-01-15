using DataAccessLayer;
using DataAccessLayer.Entities;
using DataAccessLayer.Repositories;

namespace DALTests
{
    public class UserAccountRepositoryTests
    {
        private readonly IUserAccountRepository _repository = new UserAccountRepository();

        [Fact]
        public void Add_ShouldInsertUserAccount()
        {
            // Arrange
            var userAccount = new UserAccount
            {
                UserAccountId = Guid.NewGuid(),
                Username = "testuser",
                FirstName = "Test",
                LastName = "User",
                Email = "testuser@example.com",
                CreatedAt = DateTime.UtcNow,
                DateOfBirth = new DateTime(1990, 1, 1),
            };

            // Act
            _repository.Add(userAccount);
            var retrievedUser = _repository.GetById(userAccount.UserAccountId);

            // Assert
            Assert.NotNull(retrievedUser);
            Assert.Equal(userAccount.Username, retrievedUser.Username);
        }

        [Fact]
        public void GetById_ShouldReturnUserAccount()
        {
            // Arrange
            var userId = Guid.NewGuid();
            var userAccount = new UserAccount
            {
                UserAccountId = userId,
                Username = "existinguser",
                FirstName = "Existing",
                LastName = "User",
                Email = "existinguser@example.com",
                CreatedAt = DateTime.UtcNow,
                DateOfBirth = new DateTime(1985, 5, 15),
            };
            _repository.Add(userAccount);

            // Act
            var retrievedUser = _repository.GetById(userId);

            // Assert
            Assert.NotNull(retrievedUser);
            Assert.Equal(userId, retrievedUser.UserAccountId);
        }

        [Fact]
        public void Update_ShouldModifyUserAccount()
        {
            // Arrange
            var userAccount = new UserAccount
            {
                UserAccountId = Guid.NewGuid(),
                Username = "updatableuser",
                FirstName = "Updatable",
                LastName = "User",
                Email = "updatableuser@example.com",
                CreatedAt = DateTime.UtcNow,
                DateOfBirth = new DateTime(1992, 3, 10),
            };
            _repository.Add(userAccount);

            // Act
            userAccount.FirstName = "Updated";
            _repository.Update(userAccount);
            var updatedUser = _repository.GetById(userAccount.UserAccountId);

            // Assert
            Assert.NotNull(updatedUser);
            Assert.Equal("Updated", updatedUser.FirstName);
        }

        [Fact]
        public void Delete_ShouldRemoveUserAccount()
        {
            // Arrange
            var userAccount = new UserAccount
            {
                UserAccountId = Guid.NewGuid(),
                Username = "deletableuser",
                FirstName = "Deletable",
                LastName = "User",
                Email = "deletableuser@example.com",
                CreatedAt = DateTime.UtcNow,
                DateOfBirth = new DateTime(1995, 7, 20),
            };
            _repository.Add(userAccount);

            // Act
            _repository.Delete(userAccount.UserAccountId);
            var deletedUser = _repository.GetById(userAccount.UserAccountId);

            // Assert
            Assert.Null(deletedUser);
        }

        [Fact]
        public void GetAll_ShouldReturnAllUserAccounts()
        {
            // Arrange
            var user1 = new UserAccount
            {
                UserAccountId = Guid.NewGuid(),
                Username = "user1",
                FirstName = "User",
                LastName = "One",
                Email = "user1@example.com",
                CreatedAt = DateTime.UtcNow,
                DateOfBirth = new DateTime(1990, 1, 1),
            };
            var user2 = new UserAccount
            {
                UserAccountId = Guid.NewGuid(),
                Username = "user2",
                FirstName = "User",
                LastName = "Two",
                Email = "user2@example.com",
                CreatedAt = DateTime.UtcNow,
                DateOfBirth = new DateTime(1992, 2, 2),
            };
            _repository.Add(user1);
            _repository.Add(user2);

            // Act
            var allUsers = _repository.GetAll(null, null);

            // Assert
            Assert.NotNull(allUsers);
            Assert.True(allUsers.Count() >= 2);
        }

        [Fact]
        public void GetAll_WithPagination_ShouldRespectLimit()
        {
            // Arrange
            var users = new List<UserAccount>
            {
                new UserAccount
                {
                    UserAccountId = Guid.NewGuid(),
                    Username = $"pageuser_{Guid.NewGuid():N}",
                    FirstName = "Page",
                    LastName = "User",
                    Email = $"pageuser_{Guid.NewGuid():N}@example.com",
                    CreatedAt = DateTime.UtcNow,
                    DateOfBirth = new DateTime(1991, 4, 4),
                },
                new UserAccount
                {
                    UserAccountId = Guid.NewGuid(),
                    Username = $"pageuser_{Guid.NewGuid():N}",
                    FirstName = "Page",
                    LastName = "User",
                    Email = $"pageuser_{Guid.NewGuid():N}@example.com",
                    CreatedAt = DateTime.UtcNow,
                    DateOfBirth = new DateTime(1992, 5, 5),
                },
                new UserAccount
                {
                    UserAccountId = Guid.NewGuid(),
                    Username = $"pageuser_{Guid.NewGuid():N}",
                    FirstName = "Page",
                    LastName = "User",
                    Email = $"pageuser_{Guid.NewGuid():N}@example.com",
                    CreatedAt = DateTime.UtcNow,
                    DateOfBirth = new DateTime(1993, 6, 6),
                },
            };

            foreach (var user in users)
            {
                _repository.Add(user);
            }

            // Act
            var page = _repository.GetAll(2, 0).ToList();

            // Assert
            Assert.Equal(2, page.Count);
        }

        [Fact]
        public void GetAll_WithPagination_ShouldValidateArguments()
        {
            Assert.Throws<ArgumentOutOfRangeException>(() =>
                _repository.GetAll(0, 0).ToList()
            );
            Assert.Throws<ArgumentOutOfRangeException>(() =>
                _repository.GetAll(1, -1).ToList()
            );
        }
    }
}
