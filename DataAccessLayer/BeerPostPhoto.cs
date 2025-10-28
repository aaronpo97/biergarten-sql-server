using System;
using System.Collections.Generic;

namespace DataAccessLayer;

public partial class BeerPostPhoto
{
    public Guid BeerPostPhotoID { get; set; }

    public Guid BeerPostID { get; set; }

    public Guid PhotoID { get; set; }

    public DateTime LinkedAt { get; set; }

    public virtual BeerPost BeerPost { get; set; } = null!;

    public virtual Photo Photo { get; set; } = null!;
}
