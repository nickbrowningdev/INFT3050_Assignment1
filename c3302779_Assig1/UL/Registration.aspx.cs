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
    public partial class Registration : System.Web.UI.Page
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
                string url = ConfigurationManager.AppSettings["SecurePath"] + "Registration";
                Response.Redirect(url);
            }
        }

        protected void RegisterUser(object sender, EventArgs e)
        {
            if (IsValid)
            {
                // account is created
                Accounts newUserAccount = new Accounts
                {
                    userFirstName = txtFirstName.Text,
                    userLastName = txtLastName.Text,
                    userEmail = txtEmail.Text,
                    userPassword = txtPassword.Text,
                    userPhone = txtPhoneNo.Text,
                    userIsActive = true
                };

                Accounts.addUserAccount(newUserAccount);

                // user is logged in
                newUserAccount.userLogin(newUserAccount.userEmail, newUserAccount.userPassword);

                // sessions are created
                Session["AccountFirstName"] = newUserAccount.userFirstName;
                Session["UserAccount"] = newUserAccount.userEmail;
                Session["CurrentAccount"] = newUserAccount;
                Session["AccountStatus"] = "UserAccount";

                Response.Redirect("~/UL/Home");
            }
        }

        protected void checkUserExists(object sender, ServerValidateEventArgs args)
        {
            // checks if email exists
            args.IsValid = Accounts.checkUser(args.Value) == 0;
        }
    }
}