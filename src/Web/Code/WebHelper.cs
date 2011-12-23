using System;
using System.Configuration;
using System.IO;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI.WebControls;

namespace Web.Code
{
	/// <summary>
	/// Web-centric parsing/utility methods
	/// </summary>
	public class WebHelper
	{
		public static string BaseUrl
		{
			get
			{
				string basePath = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + HttpContext.Current.Request.ApplicationPath;

				if (!basePath.EndsWith("/"))
					basePath = basePath + "/";

				return basePath;
			}
		}

		public static string GetCurrentPageName()
		{
			string Url = HttpContext.Current.Request.Url.AbsolutePath;
			FileInfo file = new FileInfo(Url);
			return file.Name;
		}

		public static string GetFileName(string path)
		{
			FileInfo file = new FileInfo(path);
			return file.Name;
		}
		
		public static string GetIPAddress()
		{
			string ip = "";

			//Suppose to work if the user is behind a proxy, but unreliable - helps with getting around ISP routers though.
			ip = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

			if (ip == null || ip.Length == 0)
				//Same as HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"]
				ip = HttpContext.Current.Request.UserHostAddress;

			return ip;
		}

		public static string GetReferrer()
		{
			var referrer = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];

			if (referrer != null && referrer.Length > 0)
				return referrer.ToString();
			else
				return "";
		}

		/// <summary>
		/// Gets the setting from the Web.Config or App.Config
		/// </summary>
		/// <param name="webConfigEnum">The key, as a ConfigKey enum</param>
		/// <returns>String value or empty string</returns>
		public static string GetSetting(ConfigKey webConfigEnum)
		{
			string key = webConfigEnum.ToString();

			//Use for *required* config keys; Nick wants to throw an exception if it's missing.
			var value = ConfigurationManager.AppSettings[webConfigEnum.ToString()];

			if (value == null)
				throw new Exception("Missing config key: " + key);

			return value.ToString();
		}

		/// <summary>
		/// Gets the session variable if it exists
		/// </summary>
		/// <param name="key">The key, as a string</param>
		/// <returns>String value or empty string</returns>
		public static string GetSession(string key)
		{
			string value = "";

			if (HttpContext.Current != null && HttpContext.Current.Session[key] != null)
				value = HttpContext.Current.Session[key].ToString();

			return value;
		}

		public static int GetSessionAsNumber(string key)
		{
			int value = -1;

			if (HttpContext.Current != null && HttpContext.Current.Session[key] != null)
			{
				var s = HttpContext.Current.Session[key].ToString();

				//int parsed = -1;
				bool isNumber = Int32.TryParse(s, out value);
			}

			return value;
		}

		#region Validation Helpers

		public static string FilterText(string text)
		{
			//Regular expression whitelisting (see FilterAlphaNumericText methods) is generally preferable to HtmlEncode, unless for some reason 
			// we NEED to save html/richly-formatted text (such as from a WYSIWYG content-updating form).

			text = text.Trim();

			//TODO: Do other processing too, such as stripping out linefeeds?

			if (!string.IsNullOrEmpty(text))
				return HttpUtility.HtmlEncode(text);
			else
				return "";
		}

		public static string FilterAlphaNumericText(string text)
		{
			text = text.Trim();

			//Restrictive filter - use only for names, not multi-line textboxes.
			//Should strip out anything that is not alphanumeric
			//Regex regex = new Regex(@"\W+"); //FAIL because it can't handle names like O'Reilly, Smith-Jones and St. John!
			Regex regex = new Regex(@"[^\w\.\'-]");

			//Replace with spaces, so we don't LOSE actual whitespace!
			return regex.Replace(text, " ");
		}

		public static string FilterAlphaNumericText2(string text)
		{
			text = text.Trim();

			//Far less restrictive filter. Use for comment box input, for example. Even if we strip out something "legitimate", such as an oddball 
			// semicolon, quote or emdash, it should not affect the overall readability of the text block.
			//Should strip out anything that is not alphanumeric or a space, number sign, period, quote, comma, or dash.
			//Regular expressions are very fussy and this only seems to work if the literals (preceded by a slash) are at the front.
			Regex regex = new Regex(@"[^\w\s\#\.\',-]");

			//Since we check for whitespace, remove without replacing
			return regex.Replace(text, "");
		}

		//Should be more thorough than the simple front-end checks we usually use
		public static bool IsValidEmail(string text)
		{
			//From http://msdn.microsoft.com/en-us/library/01escwtf.aspx
			return Regex.IsMatch(text,
				   @"^(?("")("".+?""@)|(([0-9a-zA-Z]((\.(?!\.))|[-!#\$%&'\*\+/=\?\^`\{\}\|~\w])*)(?<=[0-9a-zA-Z])@))" +
				   @"(?(\[)(\[(\d{1,3}\.){3}\d{1,3}\])|(([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,6}))$");
		}

		#region Phone

		/// <summary>
		/// Returns the numbers-only representation of a phone number, as a string
		/// </summary>
		/// <param name="PhoneNumber"></param>
		/// <returns></returns>
		public static string RawPhone(string PhoneNumber)
		{
			//Remove symbols (dash, space, period and parentheses)
			string raw = Regex.Replace(PhoneNumber, @"[- ().]", String.Empty);

			//Check for exactly 10 numbers left over
			Regex regTotalDigits = new Regex(@"^\d{10}$");
			Match matchTotalDigits = regTotalDigits.Match(raw);

			if (matchTotalDigits.Success)
				return raw;
			else
				return "";
		}

		/// <summary>
		/// Returns the numbers-only representation of a phone number, as a string
		/// </summary>
		/// <param name="PhoneNumber"></param>
		/// <returns></returns>
		public static string RawPhone2(string PhoneNumber)
		{
			string returnValue = "";

			for (int i = 0; i <= PhoneNumber.Length - 1; i++)
			{
				if (char.IsNumber(PhoneNumber, i))
				{
					returnValue += PhoneNumber[i];
				}
			}

			return returnValue;
		}

		/// <summary>
		/// Formats a 10 digit phone number to be in the xxx-xxx-xxxx format
		/// </summary>
		/// <param name="phoneNumber"></param>
		/// <returns></returns>
		public static string FormatPhoneNumber(string phoneNumber)
		{
			string returnValue = phoneNumber;

			if (!string.IsNullOrEmpty(phoneNumber) && (phoneNumber.Trim().Length == 10))
			{
				phoneNumber = phoneNumber.Trim();
				returnValue = phoneNumber.Insert(3, "-").Insert(7, "-");
			}

			return returnValue;
		}

		public static bool IsValidPhone(string PhoneNumber)
		{
			string raw = RawPhone(PhoneNumber);

			return (raw.Length > 0);
		}
		#endregion

		#endregion
	}
}