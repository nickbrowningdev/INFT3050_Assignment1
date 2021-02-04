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
    public partial class AdminChangePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.IsSecureConnection)
            {
                if (!(string.IsNullOrEmpty(RouteData.Values["email"].ToString())
                      && string.IsNullOrEmpty(RouteData.Values["password"].ToString())))
                {
                    // Get request parameters
                    string email = RouteData.Values["email"].ToString();
                    string password = RouteData.Values["password"].ToString();

                    // Retrieve user corresponding to email address of account
                    Accounts user = new Accounts();
                    user = user.getAdminByEmail(email);

                    // Check password

                    int result = user.adminLogin(email, password);

                    switch (result)
                    {
                        case (0):
                            // Username does not exist
                            Response.Redirect("~/UL/Error");
                            break;
                        case (-1):
                            // Incorrect password
                            Response.Redirect("~/UL/Error");
                            break;
                        case (-2):
                            // Suspended account
                            Response.Redirect("~/UL/Error");
                            break;
                        default:
                            // Allow update password - create temporary login
                            HttpContext.Current.Session["TemporaryAccount"] = user;
                            break;
                    }
                }
                else
                {
                    if (HttpContext.Current.Session["CurrentAccount"] == null)
                    {
                        // Unauthorised
                        Response.Redirect("~/UL/Error");
                    }
                }
            }
            else
            {
                string url = ConfigurationManager.AppSettings["SecurePath"] + "AdminChangePassword";
                Response.Redirect(url);
            }
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            bool status = false;
            if (IsValid)
            {
                if (!Session["AccountStatus"].Equals("LoggedOut"))
                {
                    // Get current user from the session
                    Accounts user = HttpContext.Current.Session["CurrentAccount"] as Accounts;
                    string newPassword = Password2TextBox.Text;
                    // Run and learn success status
                    status = Accounts.updateAdminPassword(user, newPassword);
                }
                else
                {
                    if (Session["TemporaryAccount"] != null)
                    {
                        // Get current user from the session
                        Accounts user = HttpContext.Current.Session["TemporaryAccount"] as Accounts;
                        string newPassword = Password2TextBox.Text;
                        // Run and learn success status
                        status = Accounts.updateAdminPassword(user, newPassword);
                        HttpContext.Current.Session.Remove("TemporaryAccount");

                        // Log user in
                        Session["AccountFirstName"] = user.adminFirstName;
                        Session["AdminAccount"] = user.adminEmail;
                        Session["CurrentAccount"] = user;
                        Session["AccountStatus"] = "AdminAccount"; ;

                    }
                    else
                    {
                        // Unauthorised
                        Response.Redirect("~/UL/Error");
                    }
                }
            }

            if (status)
                Response.Redirect("~/UL/Home");
            else
                Response.Redirect("~/UL/Error");
        }
    }
}