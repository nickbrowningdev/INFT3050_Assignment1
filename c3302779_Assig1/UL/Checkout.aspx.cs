using c3302779_Assig1.BL;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using INFT3050.PaymentSystem;
using System.Configuration;

namespace c3302779_Assig1.UL
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.IsSecureConnection)
            {
                if(Session["AccountStatus"].Equals("UserAccount"))
                {
                    ShoppingCart shoppingCart = Session["ShoppingCart"] as ShoppingCart;

                    // checks if shopping cart is empty
                    if (!shoppingCart.isEmpty())
                    {
                        if (!IsPostBack)
                        {
                            // returns cost of all items
                            double amount = Convert.ToDouble((Session["ShoppingCart"] as ShoppingCart).Amount);

                            lblAmount.Text = string.Format("{0:C}", amount);

                            ddlPostageOption.DataSource = PostageOption.getPostageOptionSet();
                            ddlPostageOption.DataBind();

                            Accounts userAccount = Session["CurrentAccount"] as Accounts;

                            lblFirstName.Text = userAccount.userFirstName;
                            lblLastName.Text = userAccount.userLastName;
                        }
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
                string url = ConfigurationManager.AppSettings["SecurePath"] + "Checkout";
                Response.Redirect(url);
            }
        }

        // selects postage option
        protected void ddlPostageOption_SelectedIndexChanged(object sender, EventArgs e)
        {
            PostageOption postageOption = new PostageOption();
            double amount;

            if (ddlPostageOption.SelectedValue != "")
            {
                postageOption = postageOption.getPostageOptionInformation(Convert.ToInt32(ddlPostageOption.SelectedValue));
                Session["PostageOption"] = postageOption;
                amount = Convert.ToDouble((Session["ShoppingCart"] as ShoppingCart).Amount) + postageOption.postageCost;
            }
            else
                amount = Convert.ToDouble((Session["ShoppingCart"] as ShoppingCart).Amount);

        }

        // to prevent errors
        protected void addInitialItem(object sender, EventArgs e)
        {
            ddlPostageOption.Items.Insert(0, new ListItem("Select a postage method.", ""));
        }

        // makes payment
        protected void MakePayment(object sender, EventArgs e)
        {
            if (IsValid)
            {
                Accounts userAccount = Session["CurrentAccount"] as Accounts;

                // adds address
                PostageAddress address = new PostageAddress
                {
                    addressStreet = txtCustomerAddress.Text,
                    addressPostal = txtOptionalAddress.Text,
                    addressCity = txtCity.Text,
                    addressCountry = ddlCountry.SelectedValue,
                    addressState = ddlStateTerritory.SelectedValue,
                    addressPostCode = Convert.ToInt32(txtPostCode.Text),
                    FK_userID = userAccount.userID
                };

                PostageAddress.addPostageAddress(address);

                lblResult.Text = "";

                Payment payment = new Payment(Session["ShoppingCart"] as ShoppingCart, Session["CurrentAccount"] as Accounts, Session["PostageOption"] as PostageOption);


                string[] card = { cardName.Text, cardNumber.Text, txtCVV.Text, txtExpiryDate.Text};


                TransactionResult result = payment.processPayment(card);

                Session["Result"] = result;

                // checks the outcome of the payment
                switch (result)
                {
                    case TransactionResult.Approved:
                        int rows = Payment.addNewOrder(payment, card);
                        Response.Redirect("~/UL/Confirmed");
                        break;
                    case TransactionResult.Declined:
                        lblResult.Text = "Card reports insufficient funds";
                        break;
                    case TransactionResult.InvalidCard:
                        lblResult.Text = "Card is invalid";
                        break;
                    case TransactionResult.InvalidExpiry:
                        lblResult.Text = "Invalid card expiry date";
                        break;
                    case TransactionResult.ConnectionFailure:
                        lblResult.Text = "Connection failed while processing";
                        break;
                }
            }
        }
    }
}