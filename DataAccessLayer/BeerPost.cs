using System;
using System.Collections.Generic;

namespace DataAccessLayer;

public partial class BeerPost
{
    public Guid BeerPostID { get; set; }

    public string Name { get; set; } = null!;

    public string Description { get; set; } = null!;

    public decimal ABV { get; set; }

    public int IBU { get; set; }

    public Guid PostedByID { get; set; }

    public Guid BeerStyleID { get; set; }

    public Guid BrewedByID { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual ICollection<BeerPostPhoto> BeerPostPhotos { get; set; } = new List<BeerPostPhoto>();

    public virtual BeerStyle BeerStyle { get; set; } = null!;

    public virtual BreweryPost BrewedBy { get; set; } = null!;

    public virtual UserAccount PostedBy { get; set; } = null!;
}
