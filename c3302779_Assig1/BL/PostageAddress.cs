using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using c3302779_Assig1.DAL;

namespace c3302779_Assig1.BL
{
    public class PostageAddress
    {
        // PostageAddress
        public int FK_userID { get; set; }
        public string addressStreet { get; set; }
        public string addressPostal { get; set; }
        public string addressCity { get; set; }
        public string addressCountry { get; set; }
        public string addressState { get; set; }
        public int addressPostCode { get; set; }

        public static int addPostageAddress(PostageAddress newAddress)
        {
            DataAccessLayer address = new DataAccessLayer();

            int rows = address.addPostageAddress(newAddress);

            return rows;
        }
    }
}