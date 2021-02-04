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
    public partial class Login : System.Web.UI.Page
    {
        // checks if path is secure
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
                string url = ConfigurationManager.AppSettings["SecurePath"] + "Login";
                Response.Redirect(url);
            }
        }

        protected void LogIn(object sender, EventArgs e)
        {
            // useraccount attempts login
            if (IsValid)
            {
                Accounts userAccount = new Accounts();

                int result = userAccount.userLogin(txtEmail.Text, txtPassword.Text);

                switch (result)
                {
                    case (0):
                        // account does not exist
                        errorMessage.Text = "Account does not exist.";
                        break;
                    case (-1):
                        // password is wrong
                        errorMessage.Text = "Account does not exist.";
                        break;
                    case (-2):
                        // account is suspended
                        errorMessage.Text = "Account is suspended.";
                        break;
                    default:
                        Session["AccountFirstName"] = userAccount.userFirstName;
                        Session["UserAccount"] = userAccount.userEmail;
                        Session["CurrentAccount"] = userAccount;
                        Session["AccountStatus"] = "UserAccount";
                        Response.Redirect("~/UL/Home");
                        break;
                }
            }
        }




    }
}