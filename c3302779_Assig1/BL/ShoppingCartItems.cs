using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using c3302779_Assig1.DAL;

namespace c3302779_Assig1.BL
{
    public class ShoppingCartItems
    {
        public ProductItem Product { get; set; }
        public int Quantity { get; set; }
        public double ItemTotal { get; set; }

        public ShoppingCartItems(ProductItem product, int quantity)
        {
            Product = product;
            Quantity = quantity;
            ItemTotal = Product.productPrice * Quantity;
        }

        public override string ToString()
        {
            return Product.productVendorUID + " x " + Quantity;
        }
    }
}