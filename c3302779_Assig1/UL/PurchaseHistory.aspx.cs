using c3302779_Assig1.BL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace c3302779_Assig1.UL
{
    public partial class PurchaseHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
			if (Request.IsSecureConnection)
			{
				if (Session["UserAccount"] != null && Session["UserAccount"].ToString() != String.Empty)
				{
					// gets current user and returns their order transactions
					Accounts user = Session["CurrentAccount"] as Accounts;
					phGridView.DataSource = UserOrder.getUserTransactions(user);
					phGridView.DataBind();
				}
				else
				{
					// Unauthorised
					Response.Redirect("~/UL/Error");
				}
			}
			else
			{
				string url = ConfigurationManager.AppSettings["SecurePath"] + "PurchaseHistory";
				Response.Redirect(url);
			}
		}
    }
}