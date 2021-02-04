using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace c3302779_Assig1.BL
{
    public class ShoppingCart
    {
        public List<ShoppingCartItems> Items { get; set; }
        public double Amount { get; set; }

        public ShoppingCart()
        {
            Items = new List<ShoppingCartItems>();
        }

        public void AddShoppingCartItem(ShoppingCartItems item)
        {
            Items.Add(item);
            Amount += item.Quantity * item.Product.productPrice;
        }

        public void calculate()
        {
            Amount = 0;
            foreach (ShoppingCartItems item in Items)
            {
                Amount += item.Quantity * item.Product.productPrice;
            }
        }

        public bool isEmpty()
        {
            return (Items.Count == 0);
        }

        public override string ToString()
        {
            string output = "";

            foreach (ShoppingCartItems item in Items)
            {
                output += item + Environment.NewLine;
            }
            return output;
        }
    }
}