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
    public partial class Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.IsSecureConnection)
            {
                if (!Session["AccountStatus"].Equals("AdminAccount"))
                {
                    // returns active products
                    productsRepeat.DataSource = ProductItem.getActiveProducts();
                    productsRepeat.DataBind();
                }
                else
                {
                    Response.Redirect("~/UL/Error");
                }
            }
            else
            {
                string url = ConfigurationManager.AppSettings["UnsecurePath"] + "Products";
                Response.Redirect(url);
            }
        }

        protected void btnSelectProduct(object sender, EventArgs e)
        {
            // sends user to a single product page
            LinkButton btnSelectProduct = sender as LinkButton;
            Session["productVendorUID"] = btnSelectProduct.CommandArgument;
            Response.Redirect("~/UL/Product");
        }
    }
}