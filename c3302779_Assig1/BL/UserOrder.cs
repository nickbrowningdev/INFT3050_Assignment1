using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using c3302779_Assig1.DAL;

namespace c3302779_Assig1.BL
{
    public class UserOrder
    {
        // returns user tranactions from a certain user
        public static DataSet getUserTransactions(Accounts userAccount)
        {
            return DataAccessLayer.getUserTransactions(userAccount);
        }

        // returns all user transactions
        public static DataSet getAllUserTransactions()
        {
            return DataAccessLayer.getAllUserTransactions();
        }
    }
}