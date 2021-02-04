using c3302779_Assig1.BL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace c3302779_Assig1.UL
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.IsSecureConnection)
            {
                if (Session["AccountStatus"].Equals("LoggedOut"))
                {
                    // loads normally
                }
                else
                {
                    Response.Redirect("~/UL/Error");
                }
            }
            else
            {
                string url = ConfigurationManager.AppSettings["SecurePath"] + "AdminLogin";
                Response.Redirect(url);
            }
        }

        protected void LogInAdmin(object sender, EventArgs e)
        {
            if (IsValid)
            {
                Accounts adminAccount = new Accounts();

                int result = adminAccount.adminLogin(txtEmail.Text, txtPassword.Text);

                switch (result)
                {
                    case (0):
                        errorMessage.Text = "Account does not exist.";
                        break;
                    case (-1):
                        errorMessage.Text = "Account does not exist.";
                        break;
                    case (-2):
                        errorMessage.Text = "Account is suspended.";
                        break;
                    default:
                        Session["AdminFirstName"] = adminAccount.adminFirstName;
                        Session["AdminAccount"] = adminAccount.adminEmail;
                        Session["AccountStatus"] = "AdminAccount";
                        Response.Redirect("~/UL/Home");
                        break;
                }
            }
        }
    }
}