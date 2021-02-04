using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace c3302779_Assig1.UL
{
    public partial class Error : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.IsSecureConnection)
            {
                // pages loads normally
            }
            else
            {
                string url = ConfigurationManager.AppSettings["UnsecurePath"] + "Error";
                Response.Redirect(url);
            }
        }

        protected void Return(object sender, EventArgs e)
        {
            Response.Redirect("~/UL/Home.aspx");
        }
    }
}