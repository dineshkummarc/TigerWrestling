using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace Web.Data.DataContext
{
    //public partial class AppDataContext
    ////public partial class DataClasses1DataContext
    //{
    //    public AppDataContext()
    //        : base(global::System.Configuration.ConfigurationManager.ConnectionStrings["ApplicationConnectionString"].ConnectionString, mappingSource)
    //    {
    //        OnCreated();
    //    }
    //}

    //[MetadataType(typeof(AuditMetadata))]
    //public partial class Audit
    //{
    //}

    //public class AuditMetadata
    //{
    //    public object Id { get; set; }
    //    public object ItemName { get; set; }
    //    public object ItemId { get; set; }
    //    public object ItemType { get; set; }
    //    public object Action { get; set; }
    //    public object ModifiedDate { get; set; }
    //    public object ModifiedBy { get; set; }
    //}


    //[MetadataType(typeof(AuditValueMetadata))]
    //public partial class AuditValue
    //{
    //}

    //public class AuditValueMetadata
    //{
    //    public object Id { get; set; }
    //    public object Name { get; set; }
    //    public object AuditId { get; set; }

    //    [UIHint("TextArea")]
    //    public object OldValue { get; set; }
    //    [UIHint("TextArea")]
    //    public object NewValue { get; set; }
    //}


    //[MetadataType(typeof(MediaMetadata))]
    //public partial class Media
    //{
    //}

    //public class MediaMetadata
    //{
    //    [ScaffoldColumn(false)]
    //    public object ActiveDate { get; set; }
    //    [ScaffoldColumn(false)]
    //    public object ExpireDate { get; set; }
    //    [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}")]
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object ModifiedDate { get; set; }
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object CreatedDate { get; set; }
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object CreatedBy { get; set; }
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object ModifiedBy { get; set; }
    //}

    //[MetadataType(typeof(UserMetadata))]
    //public partial class User
    //{
    //}

    //public class UserMetadata
    //{
    //    [HideColumnIn(PageTemplate.List)]
    //    public object OpenIdIdentifer { get; set; }
    //    [HideColumnIn(PageTemplate.List)]
    //    public object ProviderName { get; set; }
    //    [HideColumnIn(PageTemplate.List)]
    //    public object UserName { get; set; }
    //    [HideColumnIn(PageTemplate.List)]
    //    public object Password { get; set; }
    //    [HideColumnIn(PageTemplate.List)]
    //    public object PasswordQuestion { get; set; }
    //    [HideColumnIn(PageTemplate.List)]
    //    public object PasswordQuestionAnswer { get; set; }
    //    [HideColumnIn(PageTemplate.List)]
    //    public object IsApproved { get; set; }
    //    [HideColumnIn(PageTemplate.List)]
    //    public object IsInitialized { get; set; }
    //    [HideColumnIn(PageTemplate.List)]
    //    public object IsLockedOut { get; set; }
    //    [HideColumnIn(PageTemplate.List)]
    //    public object CreationDate { get; set; }
    //    [HideColumnIn(PageTemplate.List)]
    //    public object LastLoginDate { get; set; }
    //    [HideColumnIn(PageTemplate.List)]
    //    public object LastPasswordChangedDate { get; set; }
    //    [HideColumnIn(PageTemplate.List)]
    //    public object LastLockoutDate { get; set; }

    //    [ScaffoldColumn(false)]
    //    public object Sort { get; set; }
    //    [ScaffoldColumn(false)]
    //    public object Status { get; set; }
    //    [ScaffoldColumn(false)]
    //    public object ActiveDate { get; set; }
    //    [ScaffoldColumn(false)]
    //    public object ExpireDate { get; set; }
    //    [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}")]
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object ModifiedDate { get; set; }
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object CreatedDate { get; set; }
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object CreatedBy { get; set; }
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object ModifiedBy { get; set; }
    //}

    //[MetadataType(typeof(ProjectPropertyMetadata))]
    //public partial class ProjectProperty
    //{
    //}

    //public class ProjectPropertyMetadata
    //{
    //    [ColumnMetadata(0)]
    //    public object Name { get; set; }
    //    [ColumnMetadata(1)]
    //    public object Value { get; set; }
    //    [ScaffoldColumn(false)]
    //    public object Sort { get; set; }
    //    [ScaffoldColumn(false)]
    //    public object Status { get; set; }
    //    [ScaffoldColumn(false)]
    //    public object ActiveDate { get; set; }
    //    [ScaffoldColumn(false)]
    //    public object ExpireDate { get; set; }
    //    [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}")]
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object ModifiedDate { get; set; }
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object CreatedDate { get; set; }
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object CreatedBy { get; set; }
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object ModifiedBy { get; set; }
    //}

    //[MetadataType(typeof(RoleMetadata))]
    //public partial class Role
    //{
    //}

    //public class RoleMetadata
    //{
    //    [HideColumnIn(PageTemplate.List)]
    //    public object Sort { get; set; }
    //    [HideColumnIn(PageTemplate.List)]
    //    public object Status { get; set; }
    //    [ScaffoldColumn(false)]
    //    public object ActiveDate { get; set; }
    //    [ScaffoldColumn(false)]
    //    public object ExpireDate { get; set; }
    //    [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}")]
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object ModifiedDate { get; set; }
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object CreatedDate { get; set; }
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object CreatedBy { get; set; }
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object ModifiedBy { get; set; }
    //}

    //[MetadataType(typeof(RoleUserMetadata))]
    //public partial class RoleUser
    //{
    //}

    //public class RoleUserMetadata
    //{

    //    [ScaffoldColumn(false)]
    //    public object Name { get; set; }
    //    [ScaffoldColumn(false)]
    //    public object Sort { get; set; }
    //    [ScaffoldColumn(false)]
    //    public object Status { get; set; }
    //    [ScaffoldColumn(false)]
    //    public object ActiveDate { get; set; }
    //    [ScaffoldColumn(false)]
    //    public object ExpireDate { get; set; }

    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object ModifiedDate { get; set; }
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object CreatedDate { get; set; }
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object CreatedBy { get; set; }
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object ModifiedBy { get; set; }
    //}

    //[MetadataType(typeof(TipMetadata))]
    //public partial class Tip
    //{
    //}

    //public class TipMetadata
    //{
    //    public object Id { get; set; }
    //    public object Name { get; set; }
    //    public object Description { get; set; }
    //    public object Issue { get; set; }
    //    public object Sort { get; set; }
    //    public object Status { get; set; }
    //    public object PictureUrl { get; set; }
    //    [ScaffoldColumn(false)]
    //    public object ActiveDate { get; set; }
    //    [ScaffoldColumn(false)]
    //    public object ExpireDate { get; set; }
    //    [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}")]
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object ModifiedDate { get; set; }
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object CreatedDate { get; set; }
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object CreatedBy { get; set; }
    //    [HideColumnIn(PageTemplate.Insert, PageTemplate.Edit, PageTemplate.List, PageTemplate.ListDetails)]
    //    public object ModifiedBy { get; set; }
    //}
}