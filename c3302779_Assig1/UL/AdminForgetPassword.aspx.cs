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
    public partial class AdminForgetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.IsSecureConnection)
            {
                if (!Session["AccountStatus"].Equals("LoggedOut"))
                {
                    Response.Redirect("~/UL/Error");
                }
            }
            else
            {
                string url = ConfigurationManager.AppSettings["SecurePath"] + "AdminForgetPassword";
                Response.Redirect(url);
            }
        }

        protected void RequestButton(object sender, EventArgs e)
        {
            if (IsValid)
            {
                // generates a random code
                string randomCode = Accounts.buildPassword(8, true);

                // retrieves admin account
                Accounts user = new Accounts();
                user = user.getAdminByEmail(EmailTextBox.Text);
                Accounts.updateAdminPassword(user, randomCode);

                // attachs link
                string mailbody =
                    "<p>"
                    + "Hi,"
                    + "</p>"
                    + "<p>"
                    + "Use the link below to change your password:"
                    + "</p>"
                    + "<p>"
                    + "https://localhost:44312/UL/AdminChangePassword/" + EmailTextBox.Text + "/" + randomCode
                    + "</p>"
                    + "<br/>"
                    + "<p>"
                    + "Kind Regards,"
                    + "</p>"
                    + "<p>"
                    + "JerseyZone"
                    + "</p>";

                try
                {
                    // sends email
                    Email.SendEmail(EmailTextBox.Text, "Verification Link - JerseyZone", mailbody);
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/UL/Error");
                }


                Response.Redirect("~/UL/Home");
            }
        }

        protected void checkExists(object sender, ServerValidateEventArgs args)
        {
            // Checks if a account exists
            args.IsValid = Accounts.checkAdminEmail(args.Value);
        }
    }
}