using System;
using System.Collections.Generic;

namespace DataAccessLayer;

public partial class BeerStyle
{
    public Guid BeerStyleID { get; set; }

    public string StyleName { get; set; } = null!;

    public string? Description { get; set; }

    public virtual ICollection<BeerPost> BeerPosts { get; set; } = new List<BeerPost>();
}
