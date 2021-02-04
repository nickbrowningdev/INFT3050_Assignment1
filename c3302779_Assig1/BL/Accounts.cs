using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using c3302779_Assig1.DAL;

namespace c3302779_Assig1.BL
{
    public class Accounts
    {
        // UserAccount
        public int userID { get; set; }
        public string userFirstName { get; set; }
        public string userLastName { get; set; }
        public string userEmail { get; set; }
        public string userPassword { get; set; }
        public string userPhone { get; set; }
        public bool userIsActive { get; set; }

        // AdminAccount
        public int adminID { get; set; }
        public string adminFirstName { get; set; }
        public string adminLastName { get; set; }
        public string adminEmail { get; set; }
        public string adminPassword { get; set; }
        public bool adminIsActive { get; set; }

        // attempts to log in as an user
        public int userLogin(string userAccount, string password)
        {
            DataAccessLayer userLogin = new DataAccessLayer();

            bool userFound;

            DataRow userData = userLogin.getUserData(userAccount, out userFound);

            if (userFound)
            {
                fillUser(userData);
                // If user account has not been suspended
                if (userIsActive)
                {
                    password = hashPassword(password);
                    // Check password
                    if (password == userPassword)
                    {
                        
                        return userID;
                    }
                }
                else
                {
                    return -2;
                }

                return -1;
            }

            return 0;
        }

        // attempts to log in as an admin
        public int adminLogin(string adminAccount, string password)
        {
            DataAccessLayer adminLogin = new DataAccessLayer();

            bool adminFound;

            DataRow adminData = adminLogin.getAdminData(adminAccount, out adminFound);
            if (adminFound)
            {
                fillAdmin(adminData);
                // If user account has not been suspended
                if (adminIsActive)
                {
                    password = hashPassword(password);
                    // Check password
                    if (password == adminPassword)
                    {
                        return adminID;
                    }
                }
                else
                {
                    return -2;
                }

                return -1;
            }

            return 0;
        }

        // hash password
        public static string hashPassword(string password)
        {
            using (MD5 md5Hash = MD5.Create())
            {
                byte[] passHash = md5Hash.ComputeHash(Encoding.UTF8.GetBytes(password));

                StringBuilder sb = new StringBuilder();

                foreach (byte b in passHash)
                {
                    sb.Append(b.ToString("x2"));
                }

                password = sb.ToString();
            }

            return password;
        }

        // creates password for forget password and admin password section
        public static string buildPassword(int size, bool lowerCase)
        {
            StringBuilder builder = new StringBuilder();
            Random random = new Random();
            char ch;
            for (int i = 0; i < size; i++)
            {
                ch = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * random.NextDouble() + 65)));
                builder.Append(ch);
            }
            if (lowerCase)
                return builder.ToString().ToLower();
            return hashPassword(builder.ToString());
        }

        // update user password
        public static bool updateUserPassword(Accounts user, string password)
        {
            return DataAccessLayer.updateUserPassword(user, hashPassword(password));
        }

        // update admin password
        public static bool updateAdminPassword(Accounts admin, string password)
        {
            return DataAccessLayer.updateAdminPassword(admin, hashPassword(password));
        }

        // fill user
        private void fillUser(DataRow userData)
        {
            userID = Convert.ToInt32(userData["userID"]);
            userFirstName = userData["userFirstName"].ToString();
            userLastName = userData["userLastName"].ToString();
            userEmail = userData["userEmail"].ToString();
            userPassword = userData["userPassword"].ToString();
            userPhone = userData["userPhone"].ToString();
            userIsActive = Convert.ToBoolean(userData["userIsActive"]);
        }

        // fill admin
        private void fillAdmin(DataRow adminData)
        {
            adminID = Convert.ToInt32(adminData["adminID"]);
            adminFirstName = adminData["adminFirstName"].ToString();
            adminLastName = adminData["adminLastName"].ToString();
            adminEmail = adminData["adminEmail"].ToString();
            adminPassword = adminData["adminPassword"].ToString();
            adminIsActive = Convert.ToBoolean(adminData["adminIsActive"]);
        }

        // get user accounts
        public static DataSet getUserAccounts()
        {
            DataAccessLayer user = new DataAccessLayer();
            return user.getUserAccounts();
        }


        // get user account by id
        public Accounts getSingleUser(int userID)
        {
            DataAccessLayer user = new DataAccessLayer();

            DataRow userData = user.getSingleUser(userID);

            fillUser(userData);

            return this;
        }

        // get user account by email
        public Accounts getUserByEmail(string email)
        {
            DataAccessLayer user = new DataAccessLayer();

            DataRow userData = user.getUserByEmail(email);

            fillUser(userData);

            return this;
        }

        // get admin account by email
        public Accounts getAdminByEmail(string email)
        {
            DataAccessLayer admin = new DataAccessLayer();

            DataRow adminData = admin.getAdminByEmail(email);

            fillAdmin(adminData);

            return this;
        }

        // checks if user exists
        public static int checkUser(string userAccount)
        {
            DataAccessLayer check = new DataAccessLayer();

            bool found;

            DataRow userData = check.getUserData(userAccount, out found);

            if (found)
                return Convert.ToInt32(userData["userID"]);

            return 0;
        }

        // checks if admin exists
        public static int checkAdmin(string adminAccount)
        {
            DataAccessLayer check = new DataAccessLayer();

            bool found;

            DataRow adminData = check.getAdminData(adminAccount, out found);

            if (found)
                return Convert.ToInt32(adminData["adminID"]);

            return 0;
        }

        // checks if user email exists
        public static bool checkUserEmail(string email)
        {
            DataAccessLayer user = new DataAccessLayer();

            bool found;

            DataRow userData = user.getUserData(email, out found);

            return found;
        }

        // checks if admin email exists
        public static bool checkAdminEmail(string email)
        {
            DataAccessLayer admin = new DataAccessLayer();

            bool found;

            DataRow adminData = admin.getAdminData(email, out found);

            return found;
        }

        // add user
        public static int addUserAccount(Accounts newUserAccount)
        {
            DataAccessLayer user = new DataAccessLayer();

            newUserAccount.userPassword = hashPassword(newUserAccount.userPassword);

            int rows = user.addUserAccount(newUserAccount);

            return rows;
        }

        // add admin
        public static int addAdminAccount(Accounts newAdminAccount)
        {
            DataAccessLayer admin = new DataAccessLayer();

            newAdminAccount.adminPassword = hashPassword(newAdminAccount.adminPassword);

            int rows = admin.addAdminAccount(newAdminAccount);

            return rows;
        }

        // toggle user
        public static void toggleUserAccount(int userID)
        {
            DataAccessLayer.toggleUserAccount(userID);
        }


        // update user
        public static bool updateUserAccount(Accounts userAccount)
        {
            return DataAccessLayer.updateUserAccount(userAccount);
        }
    }
}