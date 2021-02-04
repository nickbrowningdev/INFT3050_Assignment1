using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using c3302779_Assig1.DAL;
using INFT3050.PaymentSystem;

namespace c3302779_Assig1.BL
{
    public class Payment
    {
        public ShoppingCart ShoppingCart { get; set; }
        public Accounts Account { get; set; }
        public PostageOption PostageOption { get; set; }

		public Payment(ShoppingCart shoppingCart, Accounts account, PostageOption postageOption)
        {
			ShoppingCart = shoppingCart;
			Account = account;
			PostageOption = postageOption;
        }

		public TransactionResult processPayment(string[] card)
		{
			IPaymentSystem paymentSystem = INFT3050PaymentFactory.Create();
			// Initialise card details
			PaymentRequest paymentRequest = new PaymentRequest();

			paymentRequest.Amount = Convert.ToDecimal(ShoppingCart.Amount + PostageOption.postageCost);
			paymentRequest.CardName = card[0];
			paymentRequest.CardNumber = card[1];
			paymentRequest.CVC = Convert.ToInt32(card[2]);
			paymentRequest.Expiry = Convert.ToDateTime("01-" + card[3]);
			paymentRequest.Description = "JerseyZone";
			

			// Attempt to process order
			Task<PaymentResult> result = paymentSystem.MakePayment(paymentRequest);

			return result.Result.TransactionResult;
		}

		public static int addNewOrder(Payment payment, string[] card)
        {
            DataAccessLayer newOrder = new DataAccessLayer();
            return newOrder.addNewOrder(payment, card);
        }

        public static string generateOrderReceipt(string userAccount, ShoppingCart cart, PostageOption shipping)
        {
			string mailbody =
				"<p>"
				+ "Why hello " + userAccount + ","
				+ "</p>"
				+ "<p>"
				+ "Below is a summary of your recent order:"
				+ "</p>"
				+ "<div>"
				+ "<table style=\"border-collapse: collapse; border: 1px solid black;\">"
				+ "<tr>"
				+ "<th style=\"border: 1px solid black; padding: 2px 5px;\">Quantity</th>"
				+ "<th style=\"border: 1px solid black; padding: 2px 5px;\">Item</th>"
				+ "<th style=\"border: 1px solid black; padding: 2px 5px;\">Cost</th>"
				+ "</tr>";

			// Repeat for each item in the order; forming one row in the table
			foreach (ShoppingCartItems item in cart.Items)
			{
				mailbody +=
					"<tr>"
					+ "<td style=\"border: 1px solid black; padding: 2px 5px;\">" + item.Quantity + "</td>"
					+ "<td style=\"border: 1px solid black; padding: 2px 5px;\">"
					+ item.Product.playerFirstName
					+ " "
					+ item.Product.playerLastName
					+ " - "
					+ item.Product.productDescription
					+ "</td>"
					+ "<td style=\"border: 1px solid black; padding: 2px 5px;\">$" + item.ItemTotal + "</td>"
					+ "</tr>";
			}

			mailbody +=
			"<tr>"
			+ "<td style=\"border: 1px solid black; padding: 2px 5px;\"></td>"
			+ "<th style=\"border: 1px solid black; padding: 2px 5px;\"></td>"
			+ "<td style=\"border: 1px solid black; padding: 2px 5px;\">Postage Option Cost - " + shipping.postageType + "</td>"
			+ "<td style=\"border: 1px solid black; padding: 2px 5px;\">$" + shipping.postageCost + "</td>"
			+ "</tr>"
			+ "<tr>"
			+ "<td style=\"border: 1px solid black; padding: 2px 5px;\"></td>"
			+ "<td style=\"border: 1px solid black; padding: 2px 5px;\"></td>"
			+ "<th style=\"border: 1px solid black; padding: 2px 5px;\">Total</td>"
			+ "<td style=\"border: 1px solid black; padding: 2px 5px;\">$" + (cart.Amount + shipping.postageCost) + "</td>"
			+ "</tr>"
			+ "</table>"
			+ "</div>"
			+ "<br/>"
			+ "<p>"
			+ "Kind Regards,"
			+ "</p>"
			+ "<p>"
			+ "JerseyZone"
			+ "</p>";

			return mailbody;
		}
    }
}