using System;
using System.Collections.Generic;

namespace DataAccessLayer;

public partial class Photo
{
    public Guid PhotoID { get; set; }

    public string? Hyperlink { get; set; }

    public Guid UploadedByID { get; set; }

    public DateTime UploadedAt { get; set; }

    public virtual ICollection<BeerPostPhoto> BeerPostPhotos { get; set; } = new List<BeerPostPhoto>();

    public virtual ICollection<BreweryPostPhoto> BreweryPostPhotos { get; set; } = new List<BreweryPostPhoto>();

    public virtual UserAccount UploadedBy { get; set; } = null!;

    public virtual ICollection<UserAvatar> UserAvatars { get; set; } = new List<UserAvatar>();
}
