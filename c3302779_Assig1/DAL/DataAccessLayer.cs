using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using c3302779_Assig1.BL;

namespace c3302779_Assig1.DAL
{
    public class DataAccessLayer
    {
        // adds user account
        public int addUserAccount(Accounts user)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;
            int rows;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("uspAddUserAccount", connection);

                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@userFirstName", user.userFirstName);
                command.Parameters.AddWithValue("@userLastName", user.userLastName);
                command.Parameters.AddWithValue("@userEmail", user.userEmail);
                command.Parameters.AddWithValue("@userPassword", user.userPassword);
                command.Parameters.AddWithValue("@userPhone", user.userPhone);
                command.Parameters.AddWithValue("@userIsActive", user.userIsActive);

                connection.Open();

                rows = command.ExecuteNonQuery();
            }

            return rows;
        }

        
        // adds admin account
        public int addAdminAccount(Accounts admin)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;
            int rows;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("uspAddAdminAccount", connection);

                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@adminFirstName", admin.adminFirstName);
                command.Parameters.AddWithValue("@adminLastName", admin.adminLastName);
                command.Parameters.AddWithValue("@adminEmail", admin.adminEmail);
                command.Parameters.AddWithValue("@adminPassword", admin.adminPassword);
                command.Parameters.AddWithValue("@adminIsActive", admin.adminIsActive);

                connection.Open();

                rows = command.ExecuteNonQuery();
            }

            return rows;
        }

        // adds product
        public int addNewProduct(ProductItem product)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;
            int rows;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("uspAddProduct", connection);

                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@playerFirstName", product.playerFirstName);
                command.Parameters.AddWithValue("@playerLastName", product.playerLastName);
                command.Parameters.AddWithValue("@teamID", product.teamID);
                command.Parameters.AddWithValue("@productDescription", product.productDescription);
                command.Parameters.AddWithValue("@productImage", product.productImage);
                command.Parameters.AddWithValue("@productPrice", product.productPrice);

                connection.Open();

                rows = command.ExecuteNonQuery();
            }

                return rows;
        }

        // adds new order
        public int addNewOrder(Payment purchase, string[] card)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;
            int rows;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("uspAddNewOrder", connection);

                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@orderCost", purchase.ShoppingCart.Amount);
                command.Parameters.AddWithValue("@orderTotalCost", purchase.ShoppingCart.Amount + purchase.PostageOption.postageCost);
                command.Parameters.AddWithValue("@orderIsPaid", true);
                command.Parameters.AddWithValue("@postageID", purchase.PostageOption.postageID);
                command.Parameters.AddWithValue("@userID", purchase.Account.userID);

                command.Parameters.AddWithValue("@cardName", card[0]);
                command.Parameters.AddWithValue("@cardNumber", card[1]);
                command.Parameters.AddWithValue("@cardCCV", card[2]);
                command.Parameters.AddWithValue("@cardExpiry", "1-" + card[3]);

                DataTable cartItems = new DataTable("MYITEMS");
                cartItems.Columns.Add("MYITEMS_userID", typeof(int));
                cartItems.Columns.Add("MYITEMS_productVendorUID", typeof(string));
                cartItems.Columns.Add("MYITEMS_cartQuantity", typeof(int));
                cartItems.Columns.Add("MYITEMS_cartItemPrice", typeof(double));
                cartItems.Columns.Add("MYITEMS_cartTotalPrice", typeof(double));

                foreach (ShoppingCartItems item in purchase.ShoppingCart.Items)
                {
                    cartItems.Rows.Add(purchase.Account.userID, item.Product.productVendorUID, item.Quantity, item.ItemTotal / item.Quantity, item.ItemTotal);
                }

                SqlParameter items = new SqlParameter
                {
                    ParameterName = "@myItems",
                    SqlDbType = SqlDbType.Structured,
                    Value = cartItems
                };
                command.Parameters.Add(items);

                connection.Open();

                rows = command.ExecuteNonQuery();
            }

            return rows;
        }

        // adds postage option
        public int addPostageOption(PostageOption option)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;
            int rows;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("uspAddPostageOption", connection);

                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@postageType", option.postageType);
                command.Parameters.AddWithValue("@postageDays", option.postageDays);
                command.Parameters.AddWithValue("@postageCost", option.postageCost);

                connection.Open();

                rows = command.ExecuteNonQuery();
            }

            return rows;
        }

        // adds postage address for checkout
        public int addPostageAddress(PostageAddress address)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;
            int rows;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("uspAddPostageAddress", connection);

                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@addressStreet", address.addressStreet);
                command.Parameters.AddWithValue("@addressPostal", address.addressPostal);
                command.Parameters.AddWithValue("@addressCity", address.addressCity);
                command.Parameters.AddWithValue("@addressCountry", address.addressCountry);
                command.Parameters.AddWithValue("@addressState", address.addressState);
                command.Parameters.AddWithValue("@addressPostCode", address.addressPostCode);
                command.Parameters.AddWithValue("@FK_userID", address.FK_userID);

                connection.Open();

                rows = command.ExecuteNonQuery();
            }

            return rows;
        }
        
        // gets user data 
        public DataRow getUserData(string user, out bool result)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;
            DataSet userDataSet = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter();
                SqlCommand command = new SqlCommand("uspGetUserAccount", connection);

                command.CommandType = CommandType.StoredProcedure;

                SqlParameter found = new SqlParameter
                {
                    ParameterName = "@userResult",
                    SqlDbType = SqlDbType.Int,
                    Direction = ParameterDirection.Output
                };

                command.Parameters.Add(found);
                command.Parameters.AddWithValue("@userAccount", user);

                adapter.SelectCommand = command;

                adapter.Fill(userDataSet, "UserAccount");

                result = Convert.ToBoolean(found.Value);

            }

            if (result)
                return userDataSet.Tables["UserAccount"].Rows[0];

            return null;
        }

        // get admin data
        public DataRow getAdminData(string admin, out bool result)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;
            DataSet adminDataSet = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter();
                SqlCommand command = new SqlCommand("uspGetAdminAccount", connection);

                command.CommandType = CommandType.StoredProcedure;

                SqlParameter found = new SqlParameter
                {
                    ParameterName = "@adminResult",
                    SqlDbType = SqlDbType.Int,
                    Direction = ParameterDirection.Output
                };

                command.Parameters.Add(found);
                command.Parameters.AddWithValue("@adminAccount", admin);

                adapter.SelectCommand = command;

                adapter.Fill(adminDataSet, "AdminAccount");

                result = Convert.ToBoolean(found.Value);

            }

            if (result)
                return adminDataSet.Tables["AdminAccount"].Rows[0];

            return null;
        }

        // gets user accounts
        public DataSet getUserAccounts()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;

            DataSet userDataSet = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter("uspGetUserAccounts", connection);

                adapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                adapter.Fill(userDataSet, "UserAccounts");
            }

            return userDataSet;
        }

        // gets admin accounts
        public DataSet getAdminAccounts()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;

            DataSet adminDataSet = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter("uspGetAdminAccounts", connection);

                adapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                adapter.Fill(adminDataSet, "AdminAccounts");
            }

            return adminDataSet;
        }

        // gets user account when toggling
        public DataRow getSingleUser(int userID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;

            DataSet userDataSet = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter();
                SqlCommand command = new SqlCommand("uspGetUserID", connection);

                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@userID", userID);
                adapter.SelectCommand = command;

                adapter.Fill(userDataSet, "UserAccount");

            }

            return userDataSet.Tables["UserAccount"].Rows[0];
        }

        // gets user email
        public DataRow getUserByEmail(string email)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;

            DataSet userDataSet = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter();
                SqlCommand command = new SqlCommand("uspGetUserAccountByEmail", connection);

                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@userEmail", email);
                adapter.SelectCommand = command;

                adapter.Fill(userDataSet, "UserAccount");

            }

            return userDataSet.Tables["UserAccount"].Rows[0];
        }

        // gets admin email
        public DataRow getAdminByEmail(string email)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;

            DataSet adminDataSet = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter();
                SqlCommand command = new SqlCommand("uspGetAdminAccountByEmail", connection);

                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@adminEmail", email);
                adapter.SelectCommand = command;

                adapter.Fill(adminDataSet, "AdminAccount");

            }

            return adminDataSet.Tables["AdminAccount"].Rows[0];
        }

        // returns active products for the products section
        public static DataSet getActiveProducts()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;

            DataSet productDataSet = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter("uspGetAvailableProducts", connection);

                adapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                adapter.Fill(productDataSet, "Products");
            }

            return productDataSet;

        }

        // gets all products for management
        public static DataSet getAllProducts()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;

            DataSet productDataSet = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter("uspGetAllProducts", connection);

                adapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                adapter.Fill(productDataSet, "Products");
            }

            return productDataSet;

        }

        // gets teams
        public static DataSet getTeams()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;

            DataSet teamsDataSet = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter("uspGetTeams", connection);

                adapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                adapter.Fill(teamsDataSet, "Teams");
            }

            return teamsDataSet;
        }

        // returns postage options
        public static DataSet getPostageOptions()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;

            DataSet optionDataSet = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter("uspGetPostageOptions", connection);

                adapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                adapter.Fill(optionDataSet, "PostageOption");
            }

            return optionDataSet;
        }

        // returns postage option for checkout
        public static DataSet getPostageOptionSet()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;

            DataSet shipDataSet = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter("uspGetPostageOptionSet", connection);

                adapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                adapter.Fill(shipDataSet, "PostageOption");
            }

            return shipDataSet;
        }

        // returns for creating order
        public static DataRow getPostageOptionInformation(int postageID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;

            DataSet postageDataSet = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter();
                SqlCommand command = new SqlCommand("uspGetPostageOptionInformation", connection);

                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@postageID", postageID);
                adapter.SelectCommand = command;

                adapter.Fill(postageDataSet, "PostageOption");

            }

            return postageDataSet.Tables["PostageOption"].Rows[0];
        }

        // selects product
        public static DataRow selectProduct(string productVendorUID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;

            DataSet productDataSet = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter();
                SqlCommand command = new SqlCommand("uspSelectProduct", connection);

                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@productVendorUID", productVendorUID);
                adapter.SelectCommand = command;

                adapter.Fill(productDataSet, "Product");

            }

            return productDataSet.Tables["Product"].Rows[0];
        }

        // returns user transactions
        public static DataSet getUserTransactions(Accounts user)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;

            DataSet userTransactionsDataSet = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter();
                SqlCommand command = new SqlCommand("uspGetUserTransaction", connection);

                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@userID", user.userID);

                adapter.SelectCommand = command;

                adapter.Fill(userTransactionsDataSet, "UserOrder");
            }

            return userTransactionsDataSet;
        }

        // returns all user transactions
        public static DataSet getAllUserTransactions()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;

            DataSet transactionDataSet = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter("uspGetUserTransactions", connection);

                adapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                adapter.Fill(transactionDataSet, "UserOrder");
            }

            return transactionDataSet;
        }

        // updates user account
        public static bool updateUserAccount(Accounts user)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;
            int rows;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("uspUpdateUserAccount", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                command.Parameters.AddWithValue("@userID", user.userID);
                command.Parameters.AddWithValue("@userFirstName", user.userFirstName);
                command.Parameters.AddWithValue("@userLastName", user.userLastName);
                command.Parameters.AddWithValue("@userEmail", user.userEmail);
                command.Parameters.AddWithValue("@userPhone", user.userPhone);

                connection.Open();

                rows = command.ExecuteNonQuery();
            }

            return rows > 0;
        }

        // updates user password
        public static bool updateUserPassword(Accounts user, string password)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;
            int rows;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("uspChangeUserPassword", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                command.Parameters.AddWithValue("@userEmail", user.userEmail);
                command.Parameters.AddWithValue("@userPassword", password);

                connection.Open();

                rows = command.ExecuteNonQuery();
            }

            return rows > 0;
        }

        // updates admin password
        public static bool updateAdminPassword(Accounts user, string password)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;
            int rows;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("uspChangeAdminPassword", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                command.Parameters.AddWithValue("@adminEmail", user.adminEmail);
                command.Parameters.AddWithValue("@adminPassword", password);

                connection.Open();

                rows = command.ExecuteNonQuery();
            }

            return rows > 0;
        }

        // updates product
        public static bool updateProduct(ProductItem product)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;
            int rows;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("uspUpdateProduct", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                command.Parameters.AddWithValue("@productVendorUID", product.productVendorUID);
                command.Parameters.AddWithValue("@productDescription", product.productDescription);
                command.Parameters.AddWithValue("@productImage", product.productImage);
                command.Parameters.AddWithValue("@productPrice", product.productPrice);

                connection.Open();

                rows = command.ExecuteNonQuery();
            }

            return rows > 0;
        }

        // toggles user account
        public static bool toggleUserAccount(int userID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;
            int rows;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("uspToggleUserActivity", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                command.Parameters.AddWithValue("@userID", userID);

                connection.Open();

                rows = command.ExecuteNonQuery();
            }

            return rows > 0;
        }
        
        // toggles product
        public static bool toggleProductActivity(string productVendorUID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;
            int rows;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("uspToggleProductActivity", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                command.Parameters.AddWithValue("@productVendorUID", productVendorUID);

                connection.Open();

                rows = command.ExecuteNonQuery();
            }

            return rows > 0;
        }

        // toggles postage option
        public static bool togglePostageOptionActivity(int shipID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["JerseyZoneDBConnectionString"].ConnectionString;
            int rows;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("uspTogglePostageOptionActivity", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                command.Parameters.AddWithValue("@postageID", shipID);

                connection.Open();

                rows = command.ExecuteNonQuery();
            }

            return rows > 0;
        }
    }
}