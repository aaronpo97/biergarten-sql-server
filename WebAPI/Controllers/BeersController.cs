using Microsoft.AspNetCore.Mvc;

namespace WebAPI.Controllers
{
    [ApiController]
    [Route("api/beers")]
    public class BeersController : ControllerBase
    {
        [HttpGet]
        public IActionResult GetBeers([FromQuery] int page_num, [FromQuery] int page_size)
        {
            return Ok();
        }

        [HttpGet("search")]
        public IActionResult SearchBeers([FromQuery] string search)
        {
            return Ok();
        }

        [HttpGet("styles")]
        public IActionResult GetBeerStyles([FromQuery] int page_num, [FromQuery] int page_size)
        {
            return Ok();
        }

        [HttpPost("styles/create")]
        public IActionResult CreateBeerStyle([FromBody] BeerStyleCreateRequest request)
        {
            return Ok();
        }

        [HttpPut("{postId}")]
        public IActionResult EditBeer(string postId, [FromBody] BeerEditRequest request)
        {
            return Ok();
        }

        [HttpDelete("{postId}")]
        public IActionResult DeleteBeer(string postId)
        {
            return Ok();
        }

        [HttpGet("{postId}/recommendations")]
        public IActionResult GetBeerRecommendations([FromQuery] int page_num, [FromQuery] int page_size, string postId)
        {
            return Ok();
        }

        [HttpPost("{postId}/comments")]
        public IActionResult AddBeerComment(string postId, [FromBody] BeerCommentRequest request)
        {
            return Ok();
        }

        [HttpGet("{postId}/comments")]
        public IActionResult GetBeerComments([FromQuery] int page_num, [FromQuery] int page_size, string postId)
        {
            return Ok();
        }

        [HttpPut("{postId}/comments/{commentId}")]
        public IActionResult EditBeerComment(string postId, string commentId, [FromBody] BeerCommentRequest request)
        {
            return Ok();
        }

        [HttpDelete("{postId}/comments/{commentId}")]
        public IActionResult DeleteBeerComment(string postId, string commentId)
        {
            return Ok();
        }
    }
}