using System;

namespace Web.Code
{
	public class BaseService
	{
		public static void LogDeleteError(int id, string ItemType)
		{
			var errorMessage = string.Format("Error deleting {0} item (id={1}). Nothing to delete!", ItemType, id);
			//Global.logger.Error(errorMessage);
			throw new Exception(errorMessage);
		}

		public static string Delete(int id, Delegate del, string ItemType)
		{
			var message = string.Empty;
			var sqlError = string.Empty;
			var errorMessage = string.Format("Error deleting {0} item (id={1}).", ItemType, id);

			try
			{
				var r = del.DynamicInvoke(id, sqlError);

				//Return actual error message, if any
				if (!string.IsNullOrEmpty(sqlError))
					throw new Exception(errorMessage += " " + sqlError);
				else if ((int)r != 0)
					throw new Exception(string.Format("{0} {1} returned {2}.", errorMessage, del.Method.Name, r));
			}
			catch (Exception exc)
			{
				message = errorMessage;
				Global.logger.ErrorException(message, exc);
				throw;
			}

			return message;
		}

		public static string Save(Delegate del, string ItemType, params object[] args)
		{
			var message = string.Empty;
			var errorMessage = string.Format("Error saving {0} item (id={1}).", ItemType, args[0]);

			try
			{
				var r = del.DynamicInvoke(args);					

				//NewId = (r == null ? -1 : r.Id);

				if (r == null)
					throw new Exception(string.Format("{0} {1} returned null.", errorMessage, del.Method.Name));
			}
			catch (Exception exc)
			{
				message = errorMessage;
				Global.logger.ErrorException(message, exc);
				throw;
			}

			return message;
		}
	}
}