using System;
using System.Collections.Generic;

namespace DataAccessLayer;

public partial class BreweryPost
{
    public Guid BreweryPostID { get; set; }

    public Guid PostedByID { get; set; }

    public string Description { get; set; } = null!;

    public DateTime CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual ICollection<BeerPost> BeerPosts { get; set; } = new List<BeerPost>();

    public virtual ICollection<BreweryPostPhoto> BreweryPostPhotos { get; set; } = new List<BreweryPostPhoto>();

    public virtual UserAccount PostedBy { get; set; } = null!;
}
