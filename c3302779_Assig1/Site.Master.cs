using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace c3302779_Assig1
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserAccount"] != null && Session["UserAccount"].ToString() != String.Empty)
            {
                // user log in and out features
                userLoggedIn.Visible = true;
                userLoggedOut.Visible = false;

                // admin log in features
                adminLoggedIn.Visible = false;

                // nav visibility
                userAbout.Visible = true;
                userContact.Visible = true;
                userProducts.Visible = true;
                userShoppingCart.Visible = true;
            }
            else if (Session["AdminAccount"] != null && Session["AdminAccount"].ToString() != String.Empty)
            {
                // user log in and out features
                userLoggedIn.Visible = false;
                userLoggedOut.Visible = false;

                // admin log in features
                adminLoggedIn.Visible = true;

                // nav visibility
                userAbout.Visible = false;
                userContact.Visible = false;
                userProducts.Visible = false;
                userShoppingCart.Visible = false;
            }
            else
            {
                // user log in and out features
                userLoggedIn.Visible = false;
                userLoggedOut.Visible = true;

                // admin log in features
                adminLoggedIn.Visible = false;

                // nav visibility
                userAbout.Visible = true;
                userContact.Visible = true;
                userProducts.Visible = true;
                userShoppingCart.Visible = true;
            }
        }

        protected void UserLogIn(object sender, EventArgs e)
        {
            // redirects user to log in as a customer
            Response.Redirect("~/UL/Login.aspx");
        }

        // user logs out
        protected void UserLogOut(object sender, EventArgs e)
        {
            if (Session["UserAccount"] != null && Session["UserAccount"].ToString() != String.Empty)
            {
                Session.Remove("UserFirstName");
                Session.Remove("User");
                Session.Remove("UserAccount");
                Session["UserAccount"] = "";
                Session["AccountStatus"] = "LoggedOut";
                Page.Response.Redirect("~/UL/Home.aspx");
            }
            else
            {
                Response.Redirect("~/UL/Error");
            }
        }

        // admin logs out
        protected void AdminLogOut(object sender, EventArgs e)
        {
            if (Session["AdminAccount"] != null && Session["AdminAccount"].ToString() != String.Empty)
            {
                Session.Remove("AdminFirstName");
                Session.Remove("Admin");
                Session.Remove("AdminAccount");
                Session["AdminAccount"] = "";
                Session["AccountStatus"] = "LoggedOut";
                Page.Response.Redirect("~/UL/Home.aspx");
            }
            else
            {
                Response.Redirect("~/UL/Error");
            }
        }
    }
}