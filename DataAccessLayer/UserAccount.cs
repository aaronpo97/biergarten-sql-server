using System;
using System.Collections.Generic;

namespace DataAccessLayer;

public partial class UserAccount
{
    public Guid UserAccountID { get; set; }

    public string Username { get; set; } = null!;

    public string FirstName { get; set; } = null!;

    public string LastName { get; set; } = null!;

    public string Email { get; set; } = null!;

    public DateTime CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public DateTime DateOfBirth { get; set; }

    public virtual ICollection<BeerPost> BeerPosts { get; set; } = new List<BeerPost>();

    public virtual ICollection<BreweryPost> BreweryPosts { get; set; } = new List<BreweryPost>();

    public virtual ICollection<Comment> Comments { get; set; } = new List<Comment>();

    public virtual ICollection<Photo> Photos { get; set; } = new List<Photo>();

    public virtual UserAvatar? UserAvatar { get; set; }

    public virtual UserCredential? UserCredential { get; set; }

    public virtual ICollection<UserFollow> UserFollowFollowings { get; set; } = new List<UserFollow>();

    public virtual ICollection<UserFollow> UserFollowUserAccounts { get; set; } = new List<UserFollow>();

    public virtual UserVerification? UserVerification { get; set; }
}
