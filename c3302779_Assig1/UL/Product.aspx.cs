using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using c3302779_Assig1.BL;

namespace c3302779_Assig1.UL
{
    public partial class Product : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // makes sure the connection is not secure
            if (!Request.IsSecureConnection)
            {
                // makes sure only guests and users can access the page
                if (Session["AccountStatus"].Equals("AdminAccount"))
                {
                    Response.Redirect("~/UL/Error");
                }
                else
                {
                    ProductItem product = new ProductItem();
                    ShoppingCart shoppingCart = Session["ShoppingCart"] as ShoppingCart;

                    product = product.selectProduct(Session["productVendorUID"].ToString());

                    // returns product item
                    Session["Product"] = product;

                    lblProductTitle.Text = product.teamLocation + " " + product.teamName + " " + product.playerFirstName + " " + product.playerLastName;
                    lblProductDescription.Text = product.productDescription;
                    lblProductPrice.Text = string.Format("{0:C0}", product.productPrice);

                    productImage.ImageUrl = "IMG\\" + product.productImage;
                }
            }
            else
            {
                string url = ConfigurationManager.AppSettings["UnsecurePath"] + "Product";
                Response.Redirect(url);
            }
        }

        protected void AddToCart(object sender, EventArgs e)
        {
            // adds product to shopping cart
            if (IsValid)
            {
                ProductItem productData = Session["Product"] as ProductItem;

                ShoppingCart shoppingCart = HttpContext.Current.Session["ShoppingCart"] as ShoppingCart;

                bool existingItem = false;

                foreach (ShoppingCartItems item in shoppingCart.Items)
                {
                    if (item.Product.productVendorUID == productData.productVendorUID)
                    {
                        item.Quantity += Convert.ToInt32(txtQuantity.Text);
                        existingItem = true;
                        break;
                    }
                }

                if (!existingItem)
                    shoppingCart.AddShoppingCartItem(new ShoppingCartItems(productData, Convert.ToInt32(txtQuantity.Text)));

                Response.Redirect("~/UL/Cart");
            }
        }
    }
}