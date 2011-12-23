using System;
using System.Data.SqlTypes;

namespace Web.Code
{
    public class Constants
    {
        public static int MaxNum = 9999999;

		//Shortcuts for SQL datetime ranges
		//public static DateTime MaxDate = new DateTime(2999, 1, 1);
		//public static DateTime MinDate = new DateTime(2000, 1, 1);
		public static DateTime MinDate = SqlDateTime.MinValue.Value;
		public static DateTime MaxDate = SqlDateTime.MaxValue.Value;

        public static string CryptographyPassphrase = "asdfasffsadfwefwffdsfsafsdfsadfas";

        public static readonly char[] SplitDelimiters = " ".ToCharArray();

    }

	public class QueryStringArgs
	{
		public static string ID = "Id";
		public static string SearchString = "SearchString";
		public static string ReturnUrl = "ReturnUrl";
	}

	public class SessionArgs
	{
		

	}
}