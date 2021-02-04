using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.FriendlyUrls.Resolvers;

namespace c3302779_Assig1.App_Start
{
    public class WebsiteResolver : WebFormsFriendlyUrlResolver
    {
        // this method is to clean up the url as seeing the UL\ is distracting and causes unnecessary errors
        public override void PreprocessRequest(HttpContextBase httpContext, IHttpHandler httpHandler)
        {
            string path = httpContext.Request.CurrentExecutionFilePath;

            if (path.Contains("UL/"))
            {
                httpContext.Response.Redirect("~/" + path.Replace("UL/", ""));
            }

            base.PreprocessRequest(httpContext, httpHandler);
        }
    }
}