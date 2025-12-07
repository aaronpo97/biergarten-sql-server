using Microsoft.AspNetCore.Mvc;

namespace WebAPI.Controllers
{
    [ApiController]
    [Route("api/breweries")]
    public class BreweriesController : ControllerBase
    {
        [HttpGet]
        public IActionResult GetBreweries([FromQuery] int page_num, [FromQuery] int page_size)
        {
            return Ok();
        }

        [HttpGet("map")]
        public IActionResult GetBreweriesMap([FromQuery] int page_num, [FromQuery] int page_size)
        {
            return Ok();
        }

        [HttpPut("{postId}")]
        public IActionResult EditBrewery(string postId, [FromBody] BreweryEditRequest request)
        {
            return Ok();
        }

        [HttpDelete("{postId}")]
        public IActionResult DeleteBrewery(string postId)
        {
            return Ok();
        }

        [HttpPost("{postId}/comments")]
        public IActionResult AddBreweryComment(string postId, [FromBody] BreweryCommentRequest request)
        {
            return Ok();
        }

        [HttpGet("{postId}/comments")]
        public IActionResult GetBreweryComments([FromQuery] int page_num, [FromQuery] int page_size, string postId)
        {
            return Ok();
        }

        [HttpPut("{postId}/comments/{commentId}")]
        public IActionResult EditBreweryComment(string postId, string commentId, [FromBody] BreweryCommentRequest request)
        {
            return Ok();
        }

        [HttpDelete("{postId}/comments/{commentId}")]
        public IActionResult DeleteBreweryComment(string postId, string commentId)
        {
            return Ok();
        }
    }
}