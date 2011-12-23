using System;

namespace Web
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
			//Keep as-is to preserve server variables, redirect url's and other POST data needed by analytics tools!
			Response.Redirect("~/Public/Home.aspx");
        }
    }
}