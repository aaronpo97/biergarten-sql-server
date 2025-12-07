using Microsoft.AspNetCore.Mvc;
using DataAccessLayer;

namespace WebAPI.Controllers
{
    [ApiController]
    [Route("api/users")]
    public class UsersController : ControllerBase
    {
        private readonly UserAccountRepository _userAccountRepository;

        public UsersController()
        {
            _userAccountRepository = new UserAccountRepository();
        }

        // all users
        [HttpGet("users")]
        public IActionResult GetAllUsers()
        {
            var users = _userAccountRepository.GetAll();
            return Ok(users);
        }

    }
}