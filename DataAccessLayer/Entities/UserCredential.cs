namespace DataAccessLayer.Entities;

public class UserCredential
{
    public Guid UserCredentialID { get; set; }
    public Guid UserAccountID { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime Expiry { get; set; }
    public string Hash { get; set; } = string.Empty;
    public byte[]? Timer { get; set; }
}
