using System;
using System.Collections.Generic;

namespace DataAccessLayer;

public partial class Comment
{
    public Guid CommentID { get; set; }

    public string? CommentText { get; set; }

    public Guid PostedByID { get; set; }

    public virtual UserAccount PostedBy { get; set; } = null!;
}
