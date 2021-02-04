using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace c3302779_Assig1.UL
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.IsSecureConnection)
            {
                if (Session["AccountStatus"].Equals("AdminAccount"))
                {
                    Response.Redirect("~/UL/Error");
                }
            }
            else
            {
                string url = ConfigurationManager.AppSettings["UnsecurePath"] + "Contact";
                Response.Redirect(url);
            }
        }
    }
}