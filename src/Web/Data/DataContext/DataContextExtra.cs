using System;
using System.Web;
using System.Data.Linq;

namespace Web.Data.DataContext
{
	/*
	partial class AppDataContext : System.Data.Linq.DataContext
	//partial class DataContextDataContext : System.Data.Linq.DataContext
	{
		public override void SubmitChanges(ConflictMode failureMode)
		{
			AuditChanges();
			base.SubmitChanges(failureMode);
		}

		private void AuditChanges()
		{
			var set = this.GetChangeSet();
			foreach (var i in set.Inserts)
			{
				if ((!(i is Audit)) && (!(i is AuditValue)))
				{
					Audit a = new Audit();
					AddAudit(i, a);
				}
			}
			foreach (var i in set.Updates)
			{
				if ((!(i is Audit)) && (!(i is AuditValue)))
				{
					Audit a = new Audit();
					AddAudit(i, a);
				}
			}
			foreach (var i in set.Deletes)
			{
				if ((!(i is Audit)) && (!(i is AuditValue)))
				{
					Audit a = new Audit();
					AddAudit(i, a);
				}
			}
		}

		private void AddAudit(object i, Audit a)
		{
			Type type = i.GetType();
			a.ItemId = Convert.ToInt32(type.GetProperty("Id").GetValue(i, null));
			a.ItemName = Convert.ToString(type.GetProperty("Name").GetValue(i, null));

			a.ItemType = type.ToString();
			this.Audits.InsertOnSubmit(a);

			//foreach(pro in PropertyChanges) 
			{
				AuditValue av = new AuditValue();
				av.Audit = a;
				av.OldValue = "old";
				av.NewValue = "new";
				this.AuditValues.InsertOnSubmit(av);
			}
		}




		partial void InsertMedia(Media instance)
		{
			var user = HttpContext.Current.User;
			instance.CreatedBy = user.Identity.Name;
			instance.CreatedDate = DateTime.Now;
			instance.ModifiedBy = user.Identity.Name;
			instance.ModifiedDate = DateTime.Now;

			// finally send this to the DB
			this.ExecuteDynamicInsert(instance);
		}

		partial void UpdateMedia(Media instance)
		{
			var user = HttpContext.Current.User;
			instance.ModifiedBy = user.Identity.Name;
			instance.ModifiedDate = DateTime.Now;

			// finally send this to the DB
			this.ExecuteDynamicUpdate(instance);
		}

		partial void InsertUser(User instance)
		{
			var user = HttpContext.Current.User;
			instance.CreatedBy = user.Identity.Name;
			instance.CreatedDate = DateTime.Now;
			instance.ModifiedBy = user.Identity.Name;
			instance.ModifiedDate = DateTime.Now;

			// finally send this to the DB
			this.ExecuteDynamicInsert(instance);
		}

		partial void UpdateUser(User instance)
		{
			var user = HttpContext.Current.User;
			instance.ModifiedBy = user.Identity.Name;
			instance.ModifiedDate = DateTime.Now;

			// finally send this to the DB
			this.ExecuteDynamicUpdate(instance);
		}

		partial void InsertProjectProperty(ProjectProperty instance)
		{
			var user = HttpContext.Current.User;
			instance.CreatedBy = user.Identity.Name;
			instance.CreatedDate = DateTime.Now;
			instance.ModifiedBy = user.Identity.Name;
			instance.ModifiedDate = DateTime.Now;

			// finally send this to the DB
			this.ExecuteDynamicInsert(instance);
		}

		partial void UpdateProjectProperty(ProjectProperty instance)
		{
			var user = HttpContext.Current.User;
			instance.ModifiedBy = user.Identity.Name;
			instance.ModifiedDate = DateTime.Now;

			// finally send this to the DB
			this.ExecuteDynamicUpdate(instance);
		}
          

		partial void InsertRole(Role instance)
		{
			var user = HttpContext.Current.User;
			instance.CreatedBy = user.Identity.Name;
			instance.CreatedDate = DateTime.Now;
			instance.ModifiedBy = user.Identity.Name;
			instance.ModifiedDate = DateTime.Now;

			// finally send this to the DB
			this.ExecuteDynamicInsert(instance);
		}

		partial void UpdateRole(Role instance)
		{
			var user = HttpContext.Current.User;
			instance.ModifiedBy = user.Identity.Name;
			instance.ModifiedDate = DateTime.Now;

			// finally send this to the DB
			this.ExecuteDynamicUpdate(instance);
		}

		partial void InsertRoleUser(RoleUser instance)
		{
			var user = HttpContext.Current.User;
			instance.CreatedBy = user.Identity.Name;
			instance.CreatedDate = DateTime.Now;
			instance.ModifiedBy = user.Identity.Name;
			instance.ModifiedDate = DateTime.Now;

			// finally send this to the DB
			this.ExecuteDynamicInsert(instance);
		}

		partial void UpdateRoleUser(RoleUser instance)
		{
			var user = HttpContext.Current.User;
			instance.ModifiedBy = user.Identity.Name;
			instance.ModifiedDate = DateTime.Now;

			// finally send this to the DB
			this.ExecuteDynamicUpdate(instance);
		}
          
		partial void InsertTip(Tip instance)
		{
			var user = HttpContext.Current.User;
			instance.CreatedBy = user.Identity.Name;
			instance.CreatedDate = DateTime.Now;
			instance.ModifiedBy = user.Identity.Name;
			instance.ModifiedDate = DateTime.Now;

			// finally send this to the DB
			this.ExecuteDynamicInsert(instance);
		}

		partial void UpdateTip(Tip instance)
		{
			var user = HttpContext.Current.User;
			instance.ModifiedBy = user.Identity.Name;
			instance.ModifiedDate = DateTime.Now;

			// finally send this to the DB
			this.ExecuteDynamicUpdate(instance);
		}
	}*/
}