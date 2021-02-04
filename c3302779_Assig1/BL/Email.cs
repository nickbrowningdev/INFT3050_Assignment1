using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Web;

namespace c3302779_Assig1.BL
{
    public class Email
    {
        public static void SendEmail(string to, string subject, string mailbody)
        {
            // Send email with query information
            string from = "jerseyzonestore@gmail.com";

            // Define general properties of email
            MailMessage message = new MailMessage(from, to);

            message.Subject = subject;
            message.Body = mailbody;
            message.BodyEncoding = Encoding.UTF8;
            message.IsBodyHtml = true;

            // Define SMTP properties of email
            SmtpClient client = new SmtpClient("smtp.gmail.com", 587); 
            System.Net.NetworkCredential basicCredential1 = new
            System.Net.NetworkCredential("jerseyzonestore@gmail.com", "YLvwnCLTXZMzfLJ5PzBh");
            client.EnableSsl = true;
            client.UseDefaultCredentials = false;
            client.Credentials = basicCredential1;

            // attempts to send
            try
            {
                client.Send(message);
            }

            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}