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
    public partial class AdminProductManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.IsSecureConnection)
            {
                if (Session["AccountStatus"].Equals("AdminAccount"))
                {
                    gridProducts.DataSource = ProductItem.getAllProducts();
                    gridProducts.DataBind();
                }
                else
                {
                    Response.Redirect("~/UL/Error");
                }
            }
            else
            {
                string url = ConfigurationManager.AppSettings["SecurePath"] + "AdminProductManagement";
                Response.Redirect(url);
            }
        }

        protected void gridProducts_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gridProducts.SelectedRow;

            ProductItem product = new ProductItem();

            Session["Product"] = product.selectProduct(row.Cells[0].Text);
            Response.Redirect("~/UL/AdminUpdateProduct");
        }
    }
}