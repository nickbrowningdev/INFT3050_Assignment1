using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using c3302779_Assig1.App_Start;
using Microsoft.AspNet.FriendlyUrls;

namespace c3302779_Assig1
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            var settings = new FriendlyUrlSettings()
            {
                AutoRedirectMode = RedirectMode.Permanent
            };
            
            routes.EnableFriendlyUrls(settings, new WebsiteResolver());

            // urls simplified
            // user view
            routes.MapPageRoute("About", "About", "~/UL/About.aspx");
            routes.MapPageRoute("Cart", "Cart", "~/UL/Cart.aspx");
            routes.MapPageRoute("ChangePassword", "ChangePassword/{email}/{password}", "~/UL/ChangePassword.aspx", false, new RouteValueDictionary { { "email", string.Empty }, { "pass", string.Empty } });
            routes.MapPageRoute("Checkout", "Checkout", "~/UL/Checkout.aspx");
            routes.MapPageRoute("Confirmed", "Confirmed", "~/UL/Confirmed.aspx");
            routes.MapPageRoute("Contact", "Contact", "~/UL/Contact.aspx");
            routes.MapPageRoute("Error", "Error", "~/UL/Error.aspx");
            routes.MapPageRoute("ForgetPassword", "ForgetPassword", "~/UL/ForgetPassword.aspx");
            routes.MapPageRoute("Home", "Home", "~/UL/Home.aspx");
            routes.MapPageRoute("Login", "Login", "~/UL/Login.aspx");
            routes.MapPageRoute("Product", "Product", "~/UL/Product.aspx");
            routes.MapPageRoute("Products", "Products", "~/UL/Products.aspx");
            routes.MapPageRoute("PurchaseHistory", "PurchaseHistory", "~/UL/PurchaseHistory.aspx");
            routes.MapPageRoute("Registration", "Registration", "~/UL/Registration.aspx");
            routes.MapPageRoute("UpdateAccount", "UpdateAccount", "~/UL/UpdateAccount.aspx");
            routes.MapPageRoute("User", "User", "~/UL/User.aspx");

            // admin view
            routes.MapPageRoute("AdminAccountManagement", "AdminAccountManagement", "~/UL/AdminAccountManagement.aspx");
            routes.MapPageRoute("AdminAccount", "AdminAccount", "~/UL/AdminAccount.aspx");
            routes.MapPageRoute("AdminChangePassword", "AdminChangePassword/{email}/{password}", "~/UL/AdminChangePassword.aspx", false, new RouteValueDictionary { { "email", string.Empty }, { "pass", string.Empty } });
            routes.MapPageRoute("AdminForgetPassword", "AdminForgetPassword", "~/UL/AdminForgetPassword.aspx");
            routes.MapPageRoute("AdminCreateProduct", "AdminCreateProduct", "~/UL/AdminCreateProduct.aspx");
            routes.MapPageRoute("AdminLogin", "AdminLogin", "~/UL/AdminLogin.aspx");
            routes.MapPageRoute("AdminPostageOptionManagement", "AdminPostageOptionManagement", "~/UL/AdminPostageOptionManagement.aspx");
            routes.MapPageRoute("AdminProductManagement", "AdminProductManagement", "~/UL/AdminProductManagement.aspx");
            routes.MapPageRoute("AdminRegistration", "AdminRegistration", "~/UL/AdminRegistration.aspx");
            routes.MapPageRoute("AdminUpdateProduct", "AdminUpdateProduct", "~/UL/AdminUpdateProduct.aspx");
        }
    }
}
