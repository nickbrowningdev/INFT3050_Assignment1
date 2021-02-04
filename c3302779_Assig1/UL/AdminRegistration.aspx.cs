using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using c3302779_Assig1.BL;

namespace c3302779_Assig1.UL
{
    public partial class AdminRegistration : System.Web.UI.Page
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
                string url = ConfigurationManager.AppSettings["SecurePath"] + "AdminRegistration";
                Response.Redirect(url);
            }
        }

        protected void RegisterAdmin(object sender, EventArgs e)
        {
            if (IsValid)
            {
                string password = Accounts.buildPassword(8, true);
                string mailbody =
                    "<p>"
                    + "Hi,"
                    + "</p>"
                    + "<p>"
                    + "Below is your credentials:"
                    + "</p>"
                    + "<p>"
                    + "Email: " + txtEmail.Text + "<br />"
                    + "Password: " + password
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
                    Email.SendEmail(txtEmail.Text, "Admin Verification Link - JerseyZone", mailbody);
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/UL/Error");
                }

                Accounts newAdminAccount = new Accounts
                {
                    adminFirstName = txtFirstName.Text,
                    adminLastName = txtLastName.Text,
                    adminPassword = password,
                    adminEmail = txtEmail.Text,
                    adminIsActive = true
                };

                Accounts.addAdminAccount(newAdminAccount);

                newAdminAccount.adminLogin(newAdminAccount.adminEmail, newAdminAccount.adminPassword);

                Session["AdminFirstName"] = newAdminAccount.adminFirstName;
                Session["AdminAccount"] = newAdminAccount.adminEmail;
                Session["AccountStatus"] = "AdminAccount";

                Response.Redirect("~/UL/Home");
            }
        }

        protected void checkAdminExists(object sender, ServerValidateEventArgs args)
        {
            args.IsValid = Accounts.checkAdmin(args.Value) == 0;
        }
    }
}