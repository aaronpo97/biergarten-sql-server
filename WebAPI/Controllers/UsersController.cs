using DataAccessLayer;
using DataAccessLayer.Entities;
using Microsoft.AspNetCore.Mvc;

namespace WebAPI.Controllers
{
    [ApiController]
    [Route("api/users")]
    public class UsersController : ControllerBase
    {
        private readonly IUserAccountRepository _userAccountRepository;

        public UsersController()
        {
            _userAccountRepository = new UserAccountRepository();
        }

        // all users
        [HttpGet]
        [HttpGet("users")]
        public IActionResult GetAllUsers()
        {
            var users = _userAccountRepository.GetAll();
            return Ok(users);
        }

        [HttpGet("{id:guid}")]
        public IActionResult GetUserById(Guid id)
        {
            var user = _userAccountRepository.GetById(id);
            return user is null ? NotFound() : Ok(user);
        }

        [HttpGet("by-username/{username}")]
        public IActionResult GetUserByUsername(string username)
        {
            var user = _userAccountRepository.GetByUsername(username);
            return user is null ? NotFound() : Ok(user);
        }

        [HttpGet("by-email/{email}")]
        public IActionResult GetUserByEmail(string email)
        {
            var user = _userAccountRepository.GetByEmail(email);
            return user is null ? NotFound() : Ok(user);
        }

        [HttpPost]
        public IActionResult CreateUser([FromBody] UserAccount userAccount)
        {
            if (userAccount.UserAccountID == Guid.Empty)
            {
                userAccount.UserAccountID = Guid.NewGuid();
            }

            _userAccountRepository.Add(userAccount);
            return CreatedAtAction(
                nameof(GetUserById),
                new { id = userAccount.UserAccountID },
                userAccount
            );
        }

        [HttpPut("{id:guid}")]
        public IActionResult UpdateUser(Guid id, [FromBody] UserAccount userAccount)
        {
            if (userAccount.UserAccountID != Guid.Empty && userAccount.UserAccountID != id)
            {
                return BadRequest("UserAccountID does not match route id.");
            }

            userAccount.UserAccountID = id;
            _userAccountRepository.Update(userAccount);
            return NoContent();
        }

        [HttpDelete("{id:guid}")]
        public IActionResult DeleteUser(Guid id)
        {
            _userAccountRepository.Delete(id);
            return NoContent();
        }
    }
}
