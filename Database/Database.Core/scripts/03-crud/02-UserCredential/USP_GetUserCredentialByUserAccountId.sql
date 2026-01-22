CREATE OR ALTER PROCEDURE dbo.USP_GetUserCredentialByUserAccountId(
    @UserAccountId UNIQUEIDENTIFIER
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    SELECT 
        UserCredentialId,
        UserAccountId,
        Hash,
        IsRevoked,
        CreatedAt,
        RevokedAt
    FROM dbo.UserCredential
    WHERE UserAccountId = @UserAccountId AND IsRevoked = 0;
END;