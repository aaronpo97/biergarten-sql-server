using System;
using System.Collections.Generic;

namespace DataAccessLayer;

public partial class UserFollow
{
    public Guid UserFollowID { get; set; }

    public Guid UserAccountID { get; set; }

    public Guid FollowingID { get; set; }

    public DateTime CreatedAt { get; set; }

    public virtual UserAccount Following { get; set; } = null!;

    public virtual UserAccount UserAccount { get; set; } = null!;
}
