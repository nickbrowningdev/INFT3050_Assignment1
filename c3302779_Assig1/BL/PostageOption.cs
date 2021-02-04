using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using c3302779_Assig1.DAL;

namespace c3302779_Assig1.BL
{
    public class PostageOption
    {
        // PostageOption
        public int postageID { get; set; }
        public string postageType { get; set; }
        public int postageDays { get; set; }
        public double postageCost { get; set; }

        // returns postage options
        public static DataSet getPostageOptions()
        {
            return DataAccessLayer.getPostageOptions();
        }

        // gets postage id
        public PostageOption getPostageOptionInformation(int post)
        {
            DataRow postageOption = DataAccessLayer.getPostageOptionInformation(post);

            postageID = Convert.ToInt32(postageOption["postageID"]);
            postageType = postageOption["postageType"].ToString();
            postageDays = Convert.ToInt32(postageOption["postageDays"]);
            postageCost = Convert.ToDouble(postageOption["postageCost"]);

            return this;
        }

        // adds postage option
        public static bool addPostageOption(PostageOption postage)
        {
            DataAccessLayer postageOption = new DataAccessLayer();

            return (postageOption.addPostageOption(postage) > 0);
        }

        // gets table of postage options
        public static DataSet getPostageOptionSet()
        {
            return DataAccessLayer.getPostageOptionSet();
        }

        // toggles activity of the shipping method
        public static void togglePostageOptionActivity(int postageID)
        {
            DataAccessLayer.togglePostageOptionActivity(postageID);
        }
    }
}