using System;
using System.Security.Principal;
using System.Web;
using System.Web.Security;

namespace Web.Code
{
	public class MembershipHelper
	{
		public static string GetUserName()
		{
			string username = "";

			if (HttpContext.Current == null || HttpContext.Current.User == null)
				return username;

			var user = HttpContext.Current.User;
			
			if (user != null && user.Identity != null && user.Identity.Name != null)
				username = user.Identity.Name;

			//TODO: May be able to remove this now?
			//Last ditch effort - try to get this from the session
            //if (string.IsNullOrEmpty(username) && HttpContext.Current.Session != null)
            //{
            //    var x = NLog.MappedDiagnosticsContext.Get(Web.Log.AppLogKeys.UserName);
            //    if (x != null)
            //        username = x.ToString();
            //}

			return username;
		}

		//Do not delete this, may be used if we switch back to using custom Membership class again.
		/*
		public static string GetUserName()
		{
			MembershipUser user = Membership.GetUser() as Common.Domain.User;

			string username = "(unknown)";

			if (user != null && user.UserName != null)
				username = user.UserName;

			return username;
		}*/

		public static bool CanNavigate(string url)
		{
			return UrlAuthorizationModule.CheckUrlAccessForPrincipal(url, HttpContext.Current.User, "get");
		}

		public static bool CanNavigate(object o)
		{
			var url = o.ToString();
			IPrincipal p = HttpContext.Current.User;
			return UrlAuthorizationModule.CheckUrlAccessForPrincipal(url, p, "get");
		}

		//Even "Super-users" still need to have each role manually assigned to them - there are no 'composite/combo' accounts.

		//Aka formerly "super user". Use this to restrict access to the "Admin" folder, which should only be visible to internal employees.
		public static bool UserIsDev
		{
			get
			{
				return HttpContext.Current.User.IsInRole(MembershipRole.Developer.ToString());
			}
		}

		public static bool UserIsAdmin
		{
		    get
		    {
				return HttpContext.Current.User.IsInRole(MembershipRole.Admin.ToString());
		    }
		}

		public static bool UserIsModerator
		{
			get
			{
				return HttpContext.Current.User.IsInRole(MembershipRole.Moderate.ToString());
			}
		}

		//"Audit" only controls access to the Audit page (auditing is a backend process, not user-initiated)
		public static bool UserIsAuditor
		{
			get
			{
				return HttpContext.Current.User.IsInRole(MembershipRole.Audit.ToString());
			}
		}

		public static bool UserIsEditor
		{
			get
			{
				return HttpContext.Current.User.IsInRole(MembershipRole.Edit.ToString());
			}
		}

		public static bool UserIsApprover
		{
			get
			{
				return HttpContext.Current.User.IsInRole(MembershipRole.Approve.ToString());
			}
		}

		public static bool UserIsLogger
		{
			get
			{
				return HttpContext.Current.User.IsInRole(MembershipRole.Log.ToString());
			}
		}

		public static bool UserIsReporter
		{
			get
			{
				return HttpContext.Current.User.IsInRole(MembershipRole.Report.ToString());
			}
		}
	}
}