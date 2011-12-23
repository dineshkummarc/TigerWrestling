using System;
using System.Configuration;
using System.Linq;
using System.Web;

using Web.Data.DataContext;


namespace Web.Code
{
	public class ProjectLogic
	{
		public static string GetConnectionString()
		{
			return ConfigurationManager.ConnectionStrings["ApplicationConnectionString"].ConnectionString;
		}

        //public static AppDataContext GetDataContext()
        //{
        //    //Since we are using stored procedures, turn tracking off by default.
        //    return GetDataContext(false);
        //}

        //public static AppDataContext GetDataContext(bool track)
        //{
        //    //var dc = new AppDataContext(GetConnectionString());
        //    //dc.ObjectTrackingEnabled = track;
        //    //return dc;
        //}
		
		#region Project Properties

		public static string GetProjectProperty(string code)
		{
			return GetProjectProperty(code, null);
		}

        public static string GetProjectProperty(string code, string defaultValue)
        {
            string value = "";

            //var property = ProjectPropertyServiceCache.ProjectProperties().Where(x => x.Name == code).SingleOrDefault();

            //if (property != null)
            //    value = property.Value;

            //if (string.IsNullOrEmpty(value) && !string.IsNullOrEmpty(defaultValue))
            //    value = defaultValue;

            return value;
        }

		public static int GetProjectPropertyAsNumber(string code)
		{
			return GetProjectPropertyAsNumber(code, null);
		}

		public static int GetProjectPropertyAsNumber(string code, string defaultValue)
		{
			var value = GetProjectProperty(code, defaultValue);

			int number = 0;
			int result = 0;

			bool isInt = int.TryParse(value, out result);

			if (isInt)
				number = result;

			return number;
		}

        public static bool IsHTTPS()
		{
			bool https = false;

			//If using HTTPS flag, set security property
			string secure = ProjectLogic.GetProjectProperty("HTTPS", "false");
			if (secure != null)
			{
				bool test = false;
				var isBool = bool.TryParse(secure, out test);
				if (isBool)
					https = test;
			}

			return https;
		}

		public static int GetAuthTicketTime()
		{
			return GetProjectPropertyAsNumber("AuthTicketTime", "20");
		}

		#region Hyperlinks

		

		#endregion Hyperlinks

		#endregion

		#region Date Settings

		public static string DateConverter(DateTime? input)
		{
			//return input.ToString("MM/dd/yy hh:mm:ss tt");
			if (input == null)
				return "&nbsp;";
			else
				return ((DateTime)input).ToString("MM/dd/yy hh:mm:ss tt");
		}

		public static string ProjectTimeZone
		{
			get
			{
				//Not a proper time zone!
				//return GetProjectProperty("TimeZone", "Eastern Daylight Time");
				return GetProjectProperty("TimeZone", "Eastern Standard Time");	
			}
		}

		//Returns the min-date if there is no Project setting for "StartDate"
		public static DateTime ProjectStartDate
		{
			get
			{
				DateTime StartDate = DateTime.MinValue;

				string _startDate = GetProjectProperty("StartDate");

				if (!string.IsNullOrEmpty(_startDate))
				{
					DateTime date = new DateTime();
					if (DateTime.TryParse(_startDate, out date))
						StartDate = date;
				}

				return StartDate;
			}
		}

		//Returns the max-date if there is no Project setting for "EndDate"
		public static DateTime ProjectEndDate
		{
			get
			{
				DateTime EndDate = DateTime.MaxValue;

				string _endDate = GetProjectProperty("EndDate");

				if (!string.IsNullOrEmpty(_endDate))
				{
					DateTime date = new DateTime();
					if (DateTime.TryParse(_endDate, out date))
						EndDate = date;
				}

				return EndDate;
			}
		}

		#endregion Date Settings

		#region Data Munging

		public static bool ParseBool(string input)
		{
			bool value = false;
            bool.TryParse(input, out value);
            return value;
		}

		public static int ParseInt(string input)
		{
			int value = 0;
            int.TryParse(input, out value);
			return value;
		}

		public static int ParseSort(string textSort)
		{
            int value = Constants.MaxNum;
            int.TryParse(textSort, out value);
            return value;
		}

		public static DateTime ParseStartDate(string startDate)
		{
			DateTime dt = DateTime.MinValue;
			DateTime tryDate = new DateTime();

			bool isDate = DateTime.TryParse(startDate, out tryDate);
			if (isDate)
				dt = tryDate.Date;

			return dt;
		}

		public static DateTime ParseEndDate(string endDate)
		{
			DateTime dt = DateTime.MaxValue;
			DateTime tryDate = new DateTime();

			bool isDate = DateTime.TryParse(endDate, out tryDate);
			if (isDate)
				dt = tryDate.AddDays(1).Date;

			return dt;
		}
		#endregion
	}
}