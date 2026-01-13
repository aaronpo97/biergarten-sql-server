
CREATE TYPE dbo.TblUserHashes AS TABLE
          (
    UserAccountId UNIQUEIDENTIFIER NOT NULL,
    Hash NVARCHAR(MAX) NOT NULL
          );