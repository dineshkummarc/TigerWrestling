using System;
using System.Web;

namespace Web.Code
{
	public class SessionVar
	{
		private const string SessionDateOverride = "ApplicationDate";

		public static DateTime Now
		{
			get
			{
				DateTime date = DateTime.Now;

				if (HttpContext.Current != null && HttpContext.Current.Session != null && HttpContext.Current.Session[SessionDateOverride] != null)
				{
					string DateOverride = HttpContext.Current.Session[SessionVar.SessionDateOverride].ToString();
					DateTime test = new DateTime();
					if (DateTime.TryParse(DateOverride, out test))
						date = test;
				}

				return date;
			}
			set
			{
				if (HttpContext.Current != null && HttpContext.Current.Session != null)
					HttpContext.Current.Session[SessionDateOverride] = value;
			}
		}
	}
}