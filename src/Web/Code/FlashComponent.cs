using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Web.UI;

namespace Web.Code
{

    public enum FlashAttributes
    {
        name,
        styleClass,
        align,
        id
    }

    public enum FlashParameters
    {
        play,
        menu,
        scale,
        wmode,
        devicefont,
        swliveconnect,
        allowscriptaccess,
        loop,
        quality,
        salign,
        bgcolor,
        seamlesstabbing,
        allowfullscreen,
        allownetworking
    }

    public class FlashComponent : UserControl
    {
        public string FlashMoviePath = "../Flash/test.swf";
        public string FlashContainerID = "FlashContent";
        public string FlashName = "Flash";
        public string FlashWidth = "300";
        public string FlashHeight = "120";
        public string FlashVersion = "9.0.0";
        public string FlashInstaller = "expressInstall.swf";


        private Dictionary<string, string> FlashVars = new Dictionary<string, string>();
        private Dictionary<string, string> FlashParams = new Dictionary<string, string>();
        private Dictionary<string, string> FlashAttribs = new Dictionary<string, string>();

        private Control _controlContainer;

        public FlashComponent(Control controlContainer)
        {
            _controlContainer = controlContainer;
        }

        public void WriteFlashScript()
        {
            StringBuilder jsString = new StringBuilder();
            //Begin Script Block
            jsString.Append("<script type='text/javascript'>");
            //Add flashVars
            jsString.Append("var flashvars = {};");
            foreach (KeyValuePair<string, string> kvp in FlashVars)
            {
                jsString.Append(String.Format("flashvars.{0} = \"{1}\";", kvp.Key, kvp.Value));
            }
            //Add flash params
            jsString.Append("var params = {};");
            foreach (KeyValuePair<string, string> kvp in FlashParams)
            {
                jsString.Append(String.Format("params.{0} = \"{1}\";", kvp.Key, kvp.Value));
            }
            //Add attributes
            jsString.Append("var attributes = {};");
            foreach (KeyValuePair<string, string> kvp in FlashAttribs)
            {
                jsString.Append(String.Format("attributes.{0} = \"{1}\";", kvp.Key, kvp.Value));
            }
            jsString.Append(String.Format("{0} = \"{1}\";", FlashAttributes.id, FlashName));

            //build the swfObject call
            jsString.Append("swfobject.embedSWF('"
                + FlashMoviePath + "', '"
                + FlashContainerID + "', '"
                + FlashWidth + "', '"
                + FlashHeight + "', '"
                + FlashVersion + "', '"
                + FlashInstaller + "',"
                + "flashvars, params, attributes);");
            //end script block
            jsString.Append("</script>");

            Random random = new Random();
            String FlashKey = FlashContainerID + random.Next(0, 999999).ToString(); 
           
            ScriptManager.RegisterClientScriptBlock(_controlContainer, _controlContainer.GetType(), FlashKey , jsString.ToString(), false);
        }

        public void AddFlashVars(string varName, string varValue)
        {
            FlashVars.Add(varName, varValue);
        }
        public void AddFlashParams(FlashParameters varName, string varValue)
        {
            FlashParams.Add(varName.ToString(), varValue);
        }
        public void AddFlashAttribs(FlashAttributes varName, string varValue)
        {
            FlashAttribs.Add(varName.ToString(), varValue);
        }
    }
}
