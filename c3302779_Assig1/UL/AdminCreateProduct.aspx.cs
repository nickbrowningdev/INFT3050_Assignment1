using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using c3302779_Assig1.BL;

namespace c3302779_Assig1.UL
{
    public partial class AdminCreateProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
			if (Request.IsSecureConnection)
			{
				if (Session["AccountStatus"].Equals("AdminAccount"))
				{
					if (!IsPostBack)
					{
						ddlTeamList.DataSource = ProductItem.getTeams();
						ddlTeamList.DataBind();
					}
				}
				else
				{
					Response.Redirect("~/UL/Error");
				}
			}
			else
			{
				string url = ConfigurationManager.AppSettings["SecurePath"] + "AdminCreateProduct";
				Response.Redirect(url);
			}
		}

		protected void uploadImageFile(FileUpload file)
		{
			if (file.HasFile)
			{
				file.SaveAs(Server.MapPath("~/UL/IMG/") + file.FileName);
			}
		}

		protected void addInitialItem(object sender, EventArgs e)
		{
			ddlTeamList.Items.Insert(0, new ListItem("Select a team.", ""));
		}

		protected void checkValidImage(object sender, ServerValidateEventArgs args)
		{
			CustomValidator csv = sender as CustomValidator;

			FileUpload file = imageUploadForm.FindControl(csv.ControlToValidate) as FileUpload;

			args.IsValid = file.PostedFile.ContentLength > 0 && (file.PostedFile.ContentType.Contains("image/jpeg") || file.PostedFile.ContentType.Contains("image/png"));
		}

		protected void fileExists(object sender, ServerValidateEventArgs args)
		{
			CustomValidator csv = sender as CustomValidator;

			FileUpload file = imageUploadForm.FindControl(csv.ControlToValidate) as FileUpload;

			args.IsValid = !File.Exists(Server.MapPath("~/UL/IMG/") + file.FileName);
		}

		protected void Create(object sender, EventArgs e)
		{
			if (IsValid)
			{
				ProductItem newProduct = new ProductItem
				{
					playerFirstName = txtPlayerFirstName.Text,
					playerLastName = txtPlayerLastName.Text,
					teamID = ddlTeamList.SelectedValue,
					productDescription = txtProductDescription.Text,
					productImage = fullImage.FileName,
					productPrice = Convert.ToDouble(txtPrice.Text)
				};

				uploadImageFile(fullImage);

				if (ProductItem.addProduct(newProduct))
					Response.Redirect("~/UL/AdminAccount");
				else
					Response.Redirect("~/UL/AdminCreateProduct");
			}
		}
	}
}