using System;
using System.Collections.Generic;

namespace DataAccessLayer;

public partial class UserCredential
{
    public Guid UserCredentialID { get; set; }

    public Guid UserAccountID { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime Expiry { get; set; }

    public string Hash { get; set; } = null!;

    public virtual UserAccount UserAccount { get; set; } = null!;
}
