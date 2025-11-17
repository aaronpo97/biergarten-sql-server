namespace DataAccessLayer.Entities;

public class UserVerification
{
    public Guid UserVerificationID { get; set; }
    public Guid UserAccountID { get; set; }
    public DateTime VerificationDateTime { get; set; }
    public byte[]? Timer { get; set; }
}
