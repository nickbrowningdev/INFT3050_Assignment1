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
    public partial class ForgetPassword : System.Web.UI.Page
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
                string url = ConfigurationManager.AppSettings["SecurePath"] + "ForgotPassword";
                Response.Redirect(url);
            }
        }

        protected void RequestButton(object sender, EventArgs e)
        {
            if (IsValid)
            {
                // creates random code for the link
                string randomCode = Accounts.buildPassword(8, true);

                // gets account and update password with random code
                Accounts user = new Accounts();
                user = user.getUserByEmail(txtEmail.Text);
                Accounts.updateUserPassword(user, randomCode);

                // Attachs link
                string mailbody =
                    "<p>"
                    + "Hi,"
                    + "</p>"
                    + "<p>"
                    + "Use the link below to change your password:"
                    + "</p>"
                    + "<p>"
                    + "https://localhost:44312/UL/ChangePassword/" + txtEmail.Text + "/" + randomCode
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
                    Email.SendEmail(txtEmail.Text, "Verification Link - JerseyZone", mailbody);
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
            // Checks if email exists
            args.IsValid = Accounts.checkUserEmail(args.Value);
        }
    }
}