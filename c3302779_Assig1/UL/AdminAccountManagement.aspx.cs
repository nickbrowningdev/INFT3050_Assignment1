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
    public partial class AdminAccountManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
			if (Request.IsSecureConnection)
			{
				if (Session["AccountStatus"].Equals("AdminAccount"))
				{
					if (!IsPostBack)
					{
						gvUsers.DataSource = Accounts.getUserAccounts();
						gvUsers.DataBind();

						gvTransaction.DataSource = UserOrder.getAllUserTransactions();
						gvTransaction.DataBind();
					}
				}
				else
				{
					Response.Redirect("~/UL/Error");
				}
			}
			else
			{
				string url = ConfigurationManager.AppSettings["SecurePath"] + "AdminAccountManagement";
				Response.Redirect(url);
			}
		}

		protected void gvUsers_OnRowDataBound(object sender, GridViewRowEventArgs e)
		{
			if (e.Row.RowIndex >= 0)
			{
				DataRowView rowView = e.Row.DataItem as DataRowView;

				Button statusButton = e.Row.Cells[5].FindControl("btnAccountStatus") as Button;

				if (Convert.ToBoolean(rowView["userIsActive"]))
				{
					statusButton.CssClass = "btn btn-dark";
					statusButton.Text = "Activated";
				}
				else
				{
					statusButton.CssClass = "btn btn-dark";
					statusButton.Text = "Suspended";
				}
			}
		}

		protected void gvUsers_OnRowCommand(object sender, GridViewCommandEventArgs e)
		{
			GridViewRow row = gvUsers.Rows[Convert.ToInt32(e.CommandArgument)];

			Accounts user = new Accounts();
			user = user.getSingleUser(Convert.ToInt32(row.Cells[0].Text));
			Session["User"] = user;

			switch (e.CommandName)
			{
				case "Status":
					Button statusButton = row.Cells[5].FindControl("btnAccountStatus") as Button;
					Accounts.toggleUserAccount(user.userID);

					if (statusButton.Text != "Activated")
					{
						statusButton.CssClass = "btn btn-danger";
						statusButton.Text = "Activated";
					}
					else
					{
						statusButton.CssClass = "btn btn-outline-danger";
						statusButton.Text = "Suspended";
					}
					gvUsers.DataSource = Accounts.getUserAccounts();
					gvUsers.DataBind();
					break;
				default:
					return;
			}
		}
	}
}