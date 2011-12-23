using System;

using Web.Code;

namespace Web.Public
{
	public class BasePage : System.Web.UI.Page
	{
		//http://stackoverflow.com/questions/964894/how-to-convert-time-between-timezones-utc-to-edt);	

		protected override void OnLoad(EventArgs e)
		{
			if (CheckEndDateClosed())
				Response.Redirect(Page.ResolveUrl("Closed.html"));

			if (CheckStartDateComingSoon())
				Response.Redirect(Page.ResolveUrl("ComingSoon.html"));

			//Transfers execution to the CHILD page's Page_Load function
			base.OnLoad(e);
		}

		private bool CheckStartDateComingSoon()
		{
			//Get desired "now" time, corrected for the server's time zone. If an override time is in session, use that instead.
			TimeZoneInfo timeZoneLocal = TimeZoneInfo.Local;
			DateTime dateNow = TimeZoneInfo.ConvertTimeToUtc(SessionVar.Now, timeZoneLocal);

			//Get project's start date, corrected for the website's desired time zone. Automagically applies DST if appropriate.
			TimeZoneInfo timeZoneApp = TimeZoneInfo.FindSystemTimeZoneById(ProjectLogic.ProjectTimeZone);
			DateTime dateStart = TimeZoneInfo.ConvertTimeToUtc(ProjectLogic.ProjectStartDate, timeZoneApp);

			return (dateNow < dateStart);
		}

		private bool CheckEndDateClosed()
		{
			//Get desired "now" time, corrected for the server's time zone. If an override time is in session, use that instead.
			TimeZoneInfo timeZoneLocal = TimeZoneInfo.Local;
			DateTime dateNow = TimeZoneInfo.ConvertTimeToUtc(SessionVar.Now, timeZoneLocal);

			//Get project's end date, corrected for the website's desired time zone. Automagically applies DST if appropriate.
			TimeZoneInfo timeZoneApp = TimeZoneInfo.FindSystemTimeZoneById(ProjectLogic.ProjectTimeZone);
			DateTime dateEnd = TimeZoneInfo.ConvertTimeToUtc(ProjectLogic.ProjectEndDate, timeZoneApp);

			return (dateNow > dateEnd);
		}
	}
}