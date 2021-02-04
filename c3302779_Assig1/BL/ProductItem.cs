using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using c3302779_Assig1.DAL;
using System.Security.Policy;

namespace c3302779_Assig1.BL
{
    public class ProductItem
    {
        // Product
        public string productVendorUID { get; set; }
        public string productDescription { get; set; }
        public double productPrice { get; set; }
        public string productImage { get; set; }
        public bool productIsActive { get; set; }

        // Team
        public string teamID { get; set; }
        public string teamLocation { get; set; }
        public string teamName { get; set; }

        // Player
        public string playerFirstName { get; set; }
        public string playerLastName { get; set; }

        public static DataSet getAllProducts()
        {
            return DataAccessLayer.getAllProducts();
        }

        public static DataSet getActiveProducts()
        {
            return DataAccessLayer.getActiveProducts();
        }

        public static DataSet getTeams()
        {
            return DataAccessLayer.getTeams();
        }

        public ProductItem selectProduct(string vendorUID)
        {
            DataRow productData = DataAccessLayer.selectProduct(vendorUID);

            productVendorUID = productData["productVendorUID"].ToString();
            productDescription = productData["productDescription"].ToString();
            productPrice = Convert.ToDouble(productData["productPrice"]);
            productImage = productData["productImage"].ToString();
            productIsActive = Convert.ToBoolean(productData["productIsActive"]);

            teamID = productData["teamID"].ToString();
            teamLocation = productData["teamLocation"].ToString();
            teamName = productData["teamName"].ToString();

            playerFirstName = productData["playerFirstName"].ToString();
            playerLastName = productData["playerLastName"].ToString();

            return this;
        }

        public static bool addProduct(ProductItem newProduct)
        {
            DataAccessLayer product = new DataAccessLayer();

            int rows = product.addNewProduct(newProduct);

            return rows > 0;
        }

        public static void toggleProductActivity(string productVendorUID)
        {
            DataAccessLayer.toggleProductActivity(productVendorUID);
        }

        public static bool updateProduct(ProductItem product)
        {
            return DataAccessLayer.updateProduct(product);
        }
    }
}