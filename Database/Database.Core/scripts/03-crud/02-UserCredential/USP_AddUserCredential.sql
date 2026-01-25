CREATE OR ALTER PROCEDURE dbo.USP_RotateUserCredential(
    @UserAccountId UNIQUEIDENTIFIER,
    @Hash NVARCHAR(MAX)
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRANSACTION;

    IF NOT EXISTS (SELECT 1
                   FROM dbo.UserAccount
                   WHERE UserAccountID = @UserAccountId)
        BEGIN
            ROLLBACK TRANSACTION;
        END

    -- invalidate all other credentials -- set them to revoked
    UPDATE dbo.UserCredential
    SET IsRevoked = 1,
        RevokedAt = GETDATE()
    WHERE UserAccountId = @UserAccountId;

    INSERT INTO dbo.UserCredential
        (UserAccountId, Hash)
    VALUES (@UserAccountId, @Hash);

    COMMIT TRANSACTION;
END;