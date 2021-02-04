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
    public partial class UpdateAccount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.IsSecureConnection)
            {
                if (Session["AccountStatus"].Equals("UserAccount"))
                {
                    if (!IsPostBack)
                    {
                        // gets user account details
                        Accounts user = Session["CurrentAccount"] as Accounts;

                        txtFirstName.Text = user.userFirstName;
                        txtLastName.Text = user.userLastName;
                        txtEmail.Text = user.userEmail;
                        txtPhoneNo.Text = user.userPhone;
                    }
                }
                else
                {
                    Response.Redirect("~/UL/Error");
                }
            }
            else
            {
                string url = ConfigurationManager.AppSettings["SecurePath"] + "UpdateAccount";
                Response.Redirect(url);
            }
        }

        protected void UpdateUser(object sender, EventArgs e)
        {
            if (IsValid)
            {
                // gets current user
                Accounts userAccount = Session["CurrentAccount"] as Accounts;

                // updates user
                Accounts user = new Accounts
                {
                    userID = userAccount.userID,
                    userFirstName = txtFirstName.Text,
                    userLastName = txtLastName.Text,
                    userEmail = txtEmail.Text,
                    userPhone = txtPhoneNo.Text,
                    userIsActive = userAccount.userIsActive
                };

                if (Accounts.updateUserAccount(user))
                {
                    Session["UserAccount"] = user.userEmail;

                    Response.Redirect("~/UL/Home");
                }
                else
                {
                    Response.Redirect("~/UL/Error");
                }

                Response.Redirect("~/UL/AccountSettings");
            }
        }

        protected void checkUserExists(object sender, ServerValidateEventArgs args)
        {
            // checks if email exists
            if (Accounts.checkUser(args.Value) == Convert.ToInt32((Session["CurrentAccount"] as Accounts).userID))
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = Accounts.checkUser(args.Value) == 0;
            }
        }
    }
}