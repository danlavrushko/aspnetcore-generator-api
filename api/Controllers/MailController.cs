using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Faker;
using MimeKit;
using MailKit.Net.Smtp;
using MailKit.Security;

namespace api.Controllers
{
    // Just use action name as route
    [Route("[action]")]
    public class MailController : Controller
    {
        public const string MAIL_HOST = "localhost";
        public const int MAIL_PORT = 1025;

        [HttpPost]
        public async Task EmailRandomNames(Range range, string email = "test@fake.com")
        {
            var message = new MimeMessage();
            message.From.Add(new MailboxAddress("Generator", "generator@generate.com"));
            message.To.Add(new MailboxAddress("", email));
            message.Subject = "Here are your random names!";

            message.Body = new TextPart("plain")
            {
                Text = string.Join(Environment.NewLine, range.Of(Name.FullName))
            };
            using (var mailClient = new SmtpClient())
            {
                await mailClient.ConnectAsync(MAIL_HOST, MAIL_PORT, SecureSocketOptions.None);
                await mailClient.SendAsync(message);
                await mailClient.DisconnectAsync(true);
            }
        }
    }
}
