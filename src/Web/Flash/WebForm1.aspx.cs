using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Web.Code;

namespace Web.Flash
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            DrawFlash();
        }

        private void DrawFlash()
        {
            FlashComponent fc = new FlashComponent(this);

            //flash vars
            fc.AddFlashVars("flashVar", "Test Var from Page");

            //params and attribs
            fc.AddFlashParams(FlashParameters.wmode, "transparent");
            fc.AddFlashAttribs(FlashAttributes.id, "flashObject");

            fc.FlashMoviePath = "../Flash/FlashExample.swf"; //path to flash

            fc.FlashContainerID = "FlashContainer"; //this is the div the flash will live in
            fc.FlashName = "Flash";
            fc.FlashWidth = "640";
            fc.FlashHeight = "480";
            fc.FlashVersion = "9.0.0";
            fc.FlashInstaller = "../Flash/expressInstall.swf";

            //write the flash to the page
            fc.WriteFlashScript();
        }
    }
}