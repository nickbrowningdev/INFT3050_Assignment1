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
    public partial class Confirmed : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.IsSecureConnection)
            {
                if (Session["AccountStatus"].Equals("UserAccount"))
                {
                    // checks if any items are in the cart
                    ShoppingCart shoppingCart = Session["ShoppingCart"] as ShoppingCart;

                    if (!shoppingCart.isEmpty())
                    {
                        // sends receipt
                        PostageOption postageOption = Session["PostageOption"] as PostageOption;

                        string mailbody = Payment.generateOrderReceipt("Fellow Customer", shoppingCart, postageOption);

                        try
                        {
                            Email.SendEmail(Session["UserAccount"].ToString(), "Order Receipt - JerseyZone", mailbody);
                        }
                        catch (Exception ex)
                        {
                            Response.Redirect("~/UL/Error");
                        }

                        // Remove cart from session
                        Session["ShoppingCart"] = "";
                        Session["ShoppingCart"] = new ShoppingCart();
                    }
                    else
                    {
                        Response.Redirect("~/UL/Error");
                    }
                }
                else
                {
                    Response.Redirect("~/UL/Error");
                }
            }
            else
            {
                string url = ConfigurationManager.AppSettings["SecurePath"] + "Confirmed";
                Response.Redirect(url);
            }
        }
    }
}