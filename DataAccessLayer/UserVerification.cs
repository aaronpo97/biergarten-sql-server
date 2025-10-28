using System;
using System.Collections.Generic;

namespace DataAccessLayer;

public partial class UserVerification
{
    public Guid UserVerificationID { get; set; }

    public Guid UserAccountID { get; set; }

    public DateTime VerificationDateTime { get; set; }

    public virtual UserAccount UserAccount { get; set; } = null!;
}
