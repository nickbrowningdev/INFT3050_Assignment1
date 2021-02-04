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
    public partial class AdminPostageOptionManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.IsSecureConnection)
            {
                if (Session["AccountStatus"].Equals("AdminAccount"))
                {
                    if (!IsPostBack)
                    {
                        lsvPostage.DataSource = PostageOption.getPostageOptions();
                        lsvPostage.DataBind();
                    }
                }
                else
                {
                    Response.Redirect("~/UL/Error");
                }
            }
            else
            {
                string url = ConfigurationManager.AppSettings["SecurePath"] + "AdminPostageOptionManagement";
                Response.Redirect(url);
            }
        }

        protected void CreatePostageOption(object sender, EventArgs e)
        {
            if (IsValid)
            {
                PostageOption postageOption = new PostageOption
                {
                    postageType = txtPostageType.Text,
                    postageCost = Convert.ToDouble(txtPostageCost.Text),
                    postageDays = Convert.ToInt32(txtPostageDays.Text)
                };

                PostageOption.addPostageOption(postageOption);

                // Redirect to updated postage options
                Response.Redirect("~/UL/Admin/PostageOptionManagement");
            }
        }

        protected void checkActive_CheckedChanged(object sender, EventArgs e)
        {
            ListViewItem item = (sender as CheckBox).NamingContainer as ListViewItem;
            int index = Convert.ToInt32((item.FindControl("lblPostageID") as Label).Text);
            PostageOption.togglePostageOptionActivity(index);
            lsvPostage.DataSource = PostageOption.getPostageOptions();
            lsvPostage.DataBind();
        }
    }
}