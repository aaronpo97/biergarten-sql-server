using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace DataAccessLayer;

public partial class BiergartenContext : DbContext
{
    public BiergartenContext()
    {
    }

    public BiergartenContext(DbContextOptions<BiergartenContext> options)
        : base(options)
    {
    }

    public virtual DbSet<BeerPost> BeerPosts { get; set; }

    public virtual DbSet<BeerPostPhoto> BeerPostPhotos { get; set; }

    public virtual DbSet<BeerStyle> BeerStyles { get; set; }

    public virtual DbSet<BreweryPost> BreweryPosts { get; set; }

    public virtual DbSet<BreweryPostPhoto> BreweryPostPhotos { get; set; }

    public virtual DbSet<Comment> Comments { get; set; }

    public virtual DbSet<Photo> Photos { get; set; }

    public virtual DbSet<UserAccount> UserAccounts { get; set; }

    public virtual DbSet<UserAvatar> UserAvatars { get; set; }

    public virtual DbSet<UserCredential> UserCredentials { get; set; }

    public virtual DbSet<UserFollow> UserFollows { get; set; }

    public virtual DbSet<UserVerification> UserVerifications { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=(localdb)\\ProjectModels;Database=Biergarten;Trusted_Connection=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<BeerPost>(entity =>
        {
            entity.ToTable("BeerPost");

            entity.HasIndex(e => e.BeerStyleID, "IX_BeerPost_BeerStyle");

            entity.HasIndex(e => e.BrewedByID, "IX_BeerPost_BrewedBy");

            entity.HasIndex(e => e.PostedByID, "IX_BeerPost_PostedBy");

            entity.Property(e => e.BeerPostID).HasDefaultValueSql("(newid())");
            entity.Property(e => e.ABV).HasColumnType("decimal(4, 2)");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Name).HasMaxLength(100);
            entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

            entity.HasOne(d => d.BeerStyle).WithMany(p => p.BeerPosts)
                .HasForeignKey(d => d.BeerStyleID)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_BeerPost_BeerStyle");

            entity.HasOne(d => d.BrewedBy).WithMany(p => p.BeerPosts)
                .HasForeignKey(d => d.BrewedByID)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_BeerPost_Brewery");

            entity.HasOne(d => d.PostedBy).WithMany(p => p.BeerPosts)
                .HasForeignKey(d => d.PostedByID)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_BeerPost_PostedBy");
        });

        modelBuilder.Entity<BeerPostPhoto>(entity =>
        {
            entity.ToTable("BeerPostPhoto");

            entity.HasIndex(e => new { e.BeerPostID, e.PhotoID }, "IX_BeerPostPhoto_BeerPost_Photo");

            entity.HasIndex(e => new { e.PhotoID, e.BeerPostID }, "IX_BeerPostPhoto_Photo_BeerPost");

            entity.Property(e => e.BeerPostPhotoID).HasDefaultValueSql("(newid())");
            entity.Property(e => e.LinkedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");

            entity.HasOne(d => d.BeerPost).WithMany(p => p.BeerPostPhotos)
                .HasForeignKey(d => d.BeerPostID)
                .HasConstraintName("FK_BeerPostPhoto_BeerPost");

            entity.HasOne(d => d.Photo).WithMany(p => p.BeerPostPhotos)
                .HasForeignKey(d => d.PhotoID)
                .HasConstraintName("FK_BeerPostPhoto_Photo");
        });

        modelBuilder.Entity<BeerStyle>(entity =>
        {
            entity.ToTable("BeerStyle");

            entity.HasIndex(e => e.StyleName, "AK_BeerStyle_StyleName").IsUnique();

            entity.Property(e => e.BeerStyleID).HasDefaultValueSql("(newid())");
            entity.Property(e => e.StyleName).HasMaxLength(100);
        });

        modelBuilder.Entity<BreweryPost>(entity =>
        {
            entity.ToTable("BreweryPost");

            entity.HasIndex(e => e.PostedByID, "IX_BreweryPost_PostedByID");

            entity.Property(e => e.BreweryPostID).HasDefaultValueSql("(newid())");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Description).HasMaxLength(512);
            entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

            entity.HasOne(d => d.PostedBy).WithMany(p => p.BreweryPosts)
                .HasForeignKey(d => d.PostedByID)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_BreweryPost_UserAccount");
        });

        modelBuilder.Entity<BreweryPostPhoto>(entity =>
        {
            entity.ToTable("BreweryPostPhoto");

            entity.HasIndex(e => new { e.BreweryPostID, e.PhotoID }, "IX_BreweryPostPhoto_BreweryPost_Photo");

            entity.HasIndex(e => new { e.PhotoID, e.BreweryPostID }, "IX_BreweryPostPhoto_Photo_BreweryPost");

            entity.Property(e => e.BreweryPostPhotoID).HasDefaultValueSql("(newid())");
            entity.Property(e => e.LinkedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");

            entity.HasOne(d => d.BreweryPost).WithMany(p => p.BreweryPostPhotos)
                .HasForeignKey(d => d.BreweryPostID)
                .HasConstraintName("FK_BreweryPostPhoto_BreweryPost");

            entity.HasOne(d => d.Photo).WithMany(p => p.BreweryPostPhotos)
                .HasForeignKey(d => d.PhotoID)
                .HasConstraintName("FK_BreweryPostPhoto_Photo");
        });

        modelBuilder.Entity<Comment>(entity =>
        {
            entity.HasKey(e => e.CommentID).HasName("PK_CommentID");

            entity.ToTable("Comment");

            entity.HasIndex(e => e.PostedByID, "IX_Comment_PostedByID");

            entity.Property(e => e.CommentID).HasDefaultValueSql("(newid())");
            entity.Property(e => e.CommentText).HasMaxLength(512);

            entity.HasOne(d => d.PostedBy).WithMany(p => p.Comments)
                .HasForeignKey(d => d.PostedByID)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_PostedByID");
        });

        modelBuilder.Entity<Photo>(entity =>
        {
            entity.ToTable("Photo");

            entity.HasIndex(e => e.UploadedByID, "IX_Photo_UploadedByID");

            entity.Property(e => e.PhotoID).HasDefaultValueSql("(newid())");
            entity.Property(e => e.Hyperlink).HasMaxLength(256);
            entity.Property(e => e.UploadedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");

            entity.HasOne(d => d.UploadedBy).WithMany(p => p.Photos)
                .HasForeignKey(d => d.UploadedByID)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Photo_UploadedBy");
        });

        modelBuilder.Entity<UserAccount>(entity =>
        {
            entity.ToTable("UserAccount");

            entity.HasIndex(e => e.Email, "AK_Email").IsUnique();

            entity.HasIndex(e => e.Username, "AK_Username").IsUnique();

            entity.Property(e => e.UserAccountID).HasDefaultValueSql("(newid())");
            entity.Property(e => e.CreatedAt).HasColumnType("datetime");
            entity.Property(e => e.DateOfBirth).HasColumnType("datetime");
            entity.Property(e => e.Email)
                .HasMaxLength(128)
                .IsUnicode(false);
            entity.Property(e => e.FirstName).HasMaxLength(128);
            entity.Property(e => e.LastName).HasMaxLength(128);
            entity.Property(e => e.UpdatedAt).HasColumnType("datetime");
            entity.Property(e => e.Username)
                .HasMaxLength(64)
                .IsUnicode(false);
        });

        modelBuilder.Entity<UserAvatar>(entity =>
        {
            entity.ToTable("UserAvatar");

            entity.HasIndex(e => e.UserAccountID, "AK_UserAvatar_UserAccountID").IsUnique();

            entity.HasIndex(e => e.UserAccountID, "IX_UserAvatar_UserAccount");

            entity.Property(e => e.UserAvatarID).HasDefaultValueSql("(newid())");

            entity.HasOne(d => d.Photo).WithMany(p => p.UserAvatars)
                .HasForeignKey(d => d.PhotoID)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_UserAvatar_PhotoID");

            entity.HasOne(d => d.UserAccount).WithOne(p => p.UserAvatar)
                .HasForeignKey<UserAvatar>(d => d.UserAccountID)
                .HasConstraintName("FK_UserAvatar_UserAccount");
        });

        modelBuilder.Entity<UserCredential>(entity =>
        {
            entity.ToTable("UserCredential");

            entity.HasIndex(e => e.UserAccountID, "AK_UserCredential_UserAccountID").IsUnique();

            entity.HasIndex(e => e.UserAccountID, "IX_UserCredential_UserAccount");

            entity.Property(e => e.UserCredentialID).HasDefaultValueSql("(newid())");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Expiry)
                .HasDefaultValueSql("(dateadd(day,(90),getdate()))")
                .HasColumnType("datetime");
            entity.Property(e => e.Hash).HasMaxLength(100);

            entity.HasOne(d => d.UserAccount).WithOne(p => p.UserCredential)
                .HasForeignKey<UserCredential>(d => d.UserAccountID)
                .HasConstraintName("FK_UserCredential_UserAccount");
        });

        modelBuilder.Entity<UserFollow>(entity =>
        {
            entity.ToTable("UserFollow");

            entity.HasIndex(e => new { e.FollowingID, e.UserAccountID }, "IX_UserFollow_FollowingID_UserAccount");

            entity.HasIndex(e => new { e.UserAccountID, e.FollowingID }, "IX_UserFollow_UserAccount_FollowingID");

            entity.Property(e => e.UserFollowID).HasDefaultValueSql("(newid())");
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");

            entity.HasOne(d => d.Following).WithMany(p => p.UserFollowFollowings)
                .HasForeignKey(d => d.FollowingID)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_UserFollow_UserAccountFollowing");

            entity.HasOne(d => d.UserAccount).WithMany(p => p.UserFollowUserAccounts)
                .HasForeignKey(d => d.UserAccountID)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_UserFollow_UserAccount");
        });

        modelBuilder.Entity<UserVerification>(entity =>
        {
            entity.ToTable("UserVerification");

            entity.HasIndex(e => e.UserAccountID, "AK_UserVerification_UserAccountID").IsUnique();

            entity.HasIndex(e => e.UserAccountID, "IX_UserVerification_UserAccount");

            entity.Property(e => e.UserVerificationID).HasDefaultValueSql("(newid())");
            entity.Property(e => e.VerificationDateTime)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");

            entity.HasOne(d => d.UserAccount).WithOne(p => p.UserVerification)
                .HasForeignKey<UserVerification>(d => d.UserAccountID)
                .HasConstraintName("FK_UserVerification_UserAccount");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
