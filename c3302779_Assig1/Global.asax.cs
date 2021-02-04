using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using c3302779_Assig1.BL;


namespace c3302779_Assig1
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
        }

        void Session_Start(object sender, EventArgs e)
        {
            // initializes the cart as empty and sets status of an account (user or admin) to logged out
            HttpContext.Current.Session["ShoppingCart"] = new ShoppingCart();
            HttpContext.Current.Session["AccountStatus"] = "LoggedOut";
        }
    }
}