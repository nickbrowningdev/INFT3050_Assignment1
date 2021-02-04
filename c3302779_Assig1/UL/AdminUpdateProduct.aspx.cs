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
    public partial class AdminUpdateProduct : System.Web.UI.Page
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

						ProductItem product = Session["Product"] as ProductItem;
						txtPlayerFirstName.Text = product.playerFirstName;
						txtPlayerLastName.Text = product.playerLastName;
						txtProductDescription.Text = product.productDescription;
						productImage.ImageUrl = "~/UL/IMG/" + product.productImage;
						ddlTeamList.SelectedValue = product.teamID;
						txtPrice.Text = string.Format("{0:F2}", product.productPrice);

						if (product.productIsActive)
						{
							ToggleProduct.CssClass = "btn btn-dark";
							ToggleProduct.Text = "Active";
						}
						else
						{
							ToggleProduct.CssClass = "btn btn-dark";
							ToggleProduct.Text = "Inactive";
						}
					}
				}
				else
				{
					Response.Redirect("~/UL/Error");
				}
			}
			else
			{
				string url = ConfigurationManager.AppSettings["SecurePath"] + "AdminUpdateProduct";
				Response.Redirect(url);
			}
		}

		protected void addInitialItem(object sender, EventArgs e)
		{
			ddlTeamList.Items.Insert(0, new ListItem("Select a team.", ""));
		}

		protected void uploadImageFile(FileUpload file)
		{
			if (file.HasFile)
			{
				file.SaveAs(Server.MapPath("~/UL/IMG/") + file.FileName);
			}
		}

		protected void checkValidImage(object sender, ServerValidateEventArgs args)
		{
			CustomValidator customVal = sender as CustomValidator;

			FileUpload file = imageUploadForm.FindControl(customVal.ControlToValidate) as FileUpload;

			args.IsValid = file.PostedFile.ContentLength > 0 && (file.PostedFile.ContentType.Contains("image/jpeg") || file.PostedFile.ContentType.Contains("image/png"));
		}

		protected void fileExists(object sender, ServerValidateEventArgs args)
		{
			CustomValidator csv = sender as CustomValidator;

			FileUpload file = imageUploadForm.FindControl(csv.ControlToValidate) as FileUpload;

			args.IsValid = !File.Exists(Server.MapPath("~/UL/IMG/") + file.FileName);
		}

		protected void Update_Click(object sender, EventArgs e)
		{
			if (IsValid)
			{
				ProductItem currentProduct = Session["Product"] as ProductItem;

				currentProduct.productDescription = txtProductDescription.Text;
				if (fullImage.HasFile)
					currentProduct.productImage = fullImage.FileName;

				uploadImageFile(fullImage);

				currentProduct.productPrice = Convert.ToDouble(txtPrice.Text);


				Session["Product"] = currentProduct;

				ProductItem.updateProduct(currentProduct);

				Session.Remove("Product");

				Response.Redirect("~/UL/AdminProductManagement");
			}
		}

		protected void ToggleProductButton_Click(object sender, EventArgs e)
		{
			ProductItem product = Session["Product"] as ProductItem;

			if (product.productIsActive)
			{
				ToggleProduct.CssClass = "btn btn-dark";
				ToggleProduct.Text = "Inactive";
				product.productIsActive = false;
			}
			else
			{
				ToggleProduct.CssClass = "btn btn-dark";
				ToggleProduct.Text = "Active";
				product.productIsActive = true;
			}

			Session["Product"] = product;

			ProductItem.toggleProductActivity(product.productVendorUID);
		}
	}
}