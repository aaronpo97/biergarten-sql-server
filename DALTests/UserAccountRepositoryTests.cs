using System;
using System.Collections.Generic;
using System.Linq;
using DataAccessLayer;
using DataAccessLayer.Entities;
using Xunit;

namespace DALTests
{
    public class UserAccountRepositoryTests
    {
        private readonly IUserAccountRepository _repository;

        public UserAccountRepositoryTests()
        {
            _repository = new UserAccountRepository();
        }

        [Fact]
        public void Add_ShouldInsertUserAccount()
        {
            
            // Arrange
            var userAccount = new UserAccount
            {
                UserAccountID = Guid.NewGuid(),
                Username = "testuser",
                FirstName = "Test",
                LastName = "User",
                Email = "testuser@example.com",
                CreatedAt = DateTime.UtcNow,
                DateOfBirth = new DateTime(1990, 1, 1),
            };

            // Act
            _repository.Add(userAccount);
            var retrievedUser = _repository.GetById(userAccount.UserAccountID);

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
                UserAccountID = userId,
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
            Assert.Equal(userId, retrievedUser.UserAccountID);
        }

        [Fact]
        public void Update_ShouldModifyUserAccount()
        {
            // Arrange
            var userAccount = new UserAccount
            {
                UserAccountID = Guid.NewGuid(),
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
            var updatedUser = _repository.GetById(userAccount.UserAccountID);

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
                UserAccountID = Guid.NewGuid(),
                Username = "deletableuser",
                FirstName = "Deletable",
                LastName = "User",
                Email = "deletableuser@example.com",
                CreatedAt = DateTime.UtcNow,
                DateOfBirth = new DateTime(1995, 7, 20),
            };
            _repository.Add(userAccount);

            // Act
            _repository.Delete(userAccount.UserAccountID);
            var deletedUser = _repository.GetById(userAccount.UserAccountID);

            // Assert
            Assert.Null(deletedUser);
        }

        [Fact]
        public void GetAll_ShouldReturnAllUserAccounts()
        {
            // Arrange
            var user1 = new UserAccount
            {
                UserAccountID = Guid.NewGuid(),
                Username = "user1",
                FirstName = "User",
                LastName = "One",
                Email = "user1@example.com",
                CreatedAt = DateTime.UtcNow,
                DateOfBirth = new DateTime(1990, 1, 1),
            };
            var user2 = new UserAccount
            {
                UserAccountID = Guid.NewGuid(),
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
            var allUsers = _repository.GetAll();

            // Assert
            Assert.NotNull(allUsers);
            Assert.True(allUsers.Count() >= 2);
        }
    }
}
