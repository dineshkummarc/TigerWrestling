using System;
using System.Web;
using System.Web.DynamicData;
using System.Web.Routing;
using System.Web.Script.Serialization;
using System.Web.Security;
//
using NLog;
//






namespace Web
{
	public class Global : System.Web.HttpApplication
	{
		public static Logger logger = null;

		public static void RegisterRoutes(RouteCollection routes)
		{
			MetaModel model = new MetaModel();

			// IMPORTANT: DATA MODEL REGISTRATION 
			// Uncomment this line to register LINQ to SQL classes
			// model for ASP.NET Dynamic Data. Set ScaffoldAllTables = true only if you are sure 
			// that you want all tables in the data model to support a scaffold (i.e. templates) 
			// view. To control scaffolding for individual tables, create a partial class for 
			// the table and apply the [Scaffold(true)] attribute to the partial class.
			// Note: Make sure that you change "YourDataContextType" to the name of the data context
			// class in your application. 


			//model.RegisterContext(typeof(Web.Data.DataContext.AppDataContext), new ContextConfiguration() { ScaffoldAllTables = true });

			// The following statement supports separate-page mode, where the List, Detail, Insert, and 
			// Update tasks are performed by using separate pages. To enable this mode, uncomment the following 
			// route definition, and comment out the route definitions in the combined-page mode section that follows.
            
            routes.Add(new DynamicDataRoute("DynamicData/{table}/{action}.aspx")  
			{
				Constraints = new RouteValueDictionary(new { action = "List|Details|Edit|Insert" }),
				Model = model
			});

			// The following statements support combined-page mode, where the List, Detail, Insert, and
			// Update tasks are performed by using the same page. To enable this mode, uncomment the
			// following routes and comment out the route definition in the separate-page mode section above.
			//routes.Add(new DynamicDataRoute("{table}/ListDetails.aspx") {
			//    Action = PageAction.List,
			//    ViewName = "ListDetails",
			//    Model = model
			//});

			//routes.Add(new DynamicDataRoute("{table}/ListDetails.aspx") {
			//    Action = PageAction.Details,
			//    ViewName = "ListDetails",
			//    Model = model
			//});
		}		 

		protected void Session_Start(object sender, EventArgs e)
		{
			//For logging purposes
        //    MappedDiagnosticsContext.Set(AppLogKeys.IpAddress, Context.Request.ServerVariables["REMOTE_ADDR"]);
        //    MappedDiagnosticsContext.Set(AppLogKeys.Browser, Request.Browser.Browser + Request.Browser.Version);
        //    MappedDiagnosticsContext.Set(AppLogKeys.Session, Context.Session.SessionID.ToString());
        }

		protected void Session_End(object sender, EventArgs e)
		{
            ////For logging purposes
            //MappedDiagnosticsContext.Set(AppLogKeys.UserName, "");
            //MappedDiagnosticsContext.Set(AppLogKeys.UserId, "");
            //MappedDiagnosticsContext.Set(AppLogKeys.Session, "");
            //MappedDiagnosticsContext.Set(AppLogKeys.IpAddress, "");
		}

		void Application_Start(object sender, EventArgs e)
		{
			RegisterRoutes(RouteTable.Routes);

			//For logging purposes
            //logger = LogManager.GetCurrentClassLogger(); 
            //GlobalDiagnosticsContext.Set(AppLogKeys.Server, Context.Server.MachineName);
		}

		void Application_Error(object sender, EventArgs e)
		{
            //logger.Error(Server.GetLastError());
		}

		protected void Application_AuthenticateRequest(Object sender, EventArgs e)
        {
        //    HttpCookie authCookie = Context.Request.Cookies[FormsAuthentication.FormsCookieName];

        //    if (authCookie == null) { return; }

        //    FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
        //    var serializer = new JavaScriptSerializer();
        //    var ticket = serializer.Deserialize<AuthTicket>(authTicket.UserData);

        //    Context.User = AccountPrincipal.CreatePrincipal(ticket);

        //    //For logging purposes
        //    MappedDiagnosticsContext.Set(AppLogKeys.UserName, Context.User.Identity.Name);
        //    MappedDiagnosticsContext.Set(AppLogKeys.UserId, ticket.TableId.ToString());
		}
	}
}