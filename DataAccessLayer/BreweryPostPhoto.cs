using System;
using System.Collections.Generic;

namespace DataAccessLayer;

public partial class BreweryPostPhoto
{
    public Guid BreweryPostPhotoID { get; set; }

    public Guid BreweryPostID { get; set; }

    public Guid PhotoID { get; set; }

    public DateTime LinkedAt { get; set; }

    public virtual BreweryPost BreweryPost { get; set; } = null!;

    public virtual Photo Photo { get; set; } = null!;
}
