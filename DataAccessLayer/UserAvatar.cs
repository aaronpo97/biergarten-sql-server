using System;
using System.Collections.Generic;

namespace DataAccessLayer;

public partial class UserAvatar
{
    public Guid UserAvatarID { get; set; }

    public Guid UserAccountID { get; set; }

    public Guid PhotoID { get; set; }

    public virtual Photo Photo { get; set; } = null!;

    public virtual UserAccount UserAccount { get; set; } = null!;
}
