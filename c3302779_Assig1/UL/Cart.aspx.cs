using c3302779_Assig1.BL;
using Microsoft.AspNet.FriendlyUrls;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace c3302779_Assig1.UL
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.IsSecureConnection)
            {
                if (!Session["AccountStatus"].Equals("AdminAdmin"))
                {
                    int total = 0;
                    ShoppingCart shoppingCart = Session["ShoppingCart"] as ShoppingCart;

                    Cost.Text = string.Format("{0:C}", shoppingCart.Amount);
                }
                else
                {
                    Response.Redirect("~/UL/Error");
                }
            }
            else
            {
                string url = ConfigurationManager.AppSettings["SecurePath"] + "Cart";
                Response.Redirect(url);
            }
        }

        protected void btnRemove(object sender, EventArgs e)
        {
            // removes selected product
            ShoppingCart shoppingCart = Session["ShoppingCart"] as ShoppingCart;
            CheckBox selected;

            ListViewDataItem currentProductDataItem;

            for (int i = ItemList.Items.Count - 1; i >= 0; i--)
            {
                currentProductDataItem = ItemList.Items[i];
                selected = currentProductDataItem.FindControl("checkRemove") as CheckBox;
                if (selected.Checked)
                {
                    shoppingCart.Items.RemoveAt(ItemList.Items[i].DisplayIndex);
                    shoppingCart.calculate();
                }
            }
            Response.Redirect("~/UL/Cart");
        }

        protected void btnEmptyCart(object sender, EventArgs e)
        {
            // empty the cart when selected
            Session.Remove("ShoppingCart");
            Session["ShoppingCart"] = new ShoppingCart();
            Response.Redirect(Request.Url.ToString(), true);
        }

        protected void btnCheckout(object sender, EventArgs e)
        {
            // checks and makes sure everything is in order
            ShoppingCart shoppingCart = Session["ShoppingCart"] as ShoppingCart;

            if (!shoppingCart.isEmpty())
            {
                string shoppingCartTotal = Cost.Text;

                Session["ShoppingCartCost"] = shoppingCartTotal;

                if (Session["AccountStatus"].ToString().Equals("LoggedOut"))
                {
                    Response.Redirect("~/UL/Error");
                }
                else
                {
                    Response.Redirect("~/UL/Checkout");
                }
            }
            else
            {
                errorCart.Text = "This cart is empty.";
            }
        }

        // returns how many items in the cart
        public List<ShoppingCartItems> GetShoppingCartItems()
        {
            ShoppingCart shoppingCart = Session["ShoppingCart"] as ShoppingCart;
            return shoppingCart.Items;
        }
    }
}