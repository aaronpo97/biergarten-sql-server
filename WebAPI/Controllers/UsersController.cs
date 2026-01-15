using BusinessLayer.Services;
using DataAccessLayer.Entities;
using Microsoft.AspNetCore.Mvc;

namespace WebAPI.Controllers
{
    [ApiController]
    [Route("api/users")]
    public class UsersController : ControllerBase
    {
        private readonly IUserService _userService;

        public UsersController(IUserService userService)
        {
            _userService = userService;
        }

        // all users
        [HttpGet]
        public IActionResult GetAllUsers(
            [FromQuery] int? limit,
            [FromQuery] int? offset
        )
        {
            if (offset.HasValue && !limit.HasValue)
            {
                return BadRequest("Limit is required when offset is provided.");
            }

            if (limit.HasValue && limit <= 0)
            {
                return BadRequest("Limit must be greater than zero.");
            }

            if (offset.HasValue && offset < 0)
            {
                return BadRequest("Offset cannot be negative.");
            }

            var users = _userService.GetAll(limit, offset);
            return Ok(users);
        }

        [HttpGet("{id:guid}")]
        public IActionResult GetUserById(Guid id)
        {
            var user = _userService.GetById(id);
            return user is null ? NotFound() : Ok(user);
        }

        [HttpGet("username/{username}")]
        public IActionResult GetUserByUsername(string username)
        {
            var user = _userService.GetByUsername(username);
            return user is null ? NotFound() : Ok(user);
        }

        [HttpGet("email/{email}")]
        public IActionResult GetUserByEmail(string email)
        {
            var user = _userService.GetByEmail(email);
            return user is null ? NotFound() : Ok(user);
        }

        [HttpPost]
        public IActionResult CreateUser([FromBody] UserAccount userAccount)
        {
            if (userAccount.UserAccountId == Guid.Empty)
            {
                userAccount.UserAccountId = Guid.NewGuid();
            }

            _userService.Add(userAccount);
            return CreatedAtAction(
                nameof(GetUserById),
                new { id = userAccount.UserAccountId },
                userAccount
            );
        }

        [HttpPut("{id:guid}")]
        public IActionResult UpdateUser(
            Guid id,
            [FromBody] UserAccount userAccount
        )
        {
            if (
                userAccount.UserAccountId != Guid.Empty
                && userAccount.UserAccountId != id
            )
            {
                return BadRequest("UserAccountID does not match route id.");
            }

            userAccount.UserAccountId = id;
            _userService.Update(userAccount);
            return NoContent();
        }

        [HttpDelete("{id:guid}")]
        public IActionResult DeleteUser(Guid id)
        {
            _userService.Delete(id);
            return NoContent();
        }
    }
}
