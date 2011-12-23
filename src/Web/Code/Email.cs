using System;
using System.Configuration;
using System.Net.Mail;

namespace Web.Code
{
    public class Email
    {
        #region Fields...
         
        private string _smtpHost;

        #endregion

        #region Enumerations...

        public enum ExactTargetSubscriberType { Customer, Employee, Prospect };

        #endregion

        #region Properties...

        public bool IsBodyHtml { get; set; }
        public string SmtpHost
        {
            get
            {
                if (String.IsNullOrEmpty(_smtpHost)) { _smtpHost = ConfigurationManager.AppSettings["EmailSmtpServer"]; }

                return _smtpHost;
            }
            set { _smtpHost = value; }
        }

        public MailAddress FromAddress { get; set; }
        public string ToAddressList { get; set; }
        public string CcAddressList { get; set; }
        public string BccAddressList { get; set; }
        public string Subject { get; set; }
        public string Body { get; set; }

        #endregion

        #region Methods...

        /// <summary>
        /// The .NET (not ExactTarget) send standard email message implementation.
        /// </summary>
        public void Send()
        {
            var msgMail = new MailMessage();

            if (ToAddressList.Length > 0)
				msgMail.To.Add(ToAddressList);
            else
				throw new ArgumentException("Email 'Send To' address is empty. Unable to send email.");

            if (FromAddress != null)
				msgMail.From = FromAddress;
            else
                throw new ArgumentException(String.Format("Unable to set 'From Address' to send email to '{0}' with Subject: '{1}'", ToAddressList, Subject));

            msgMail.Subject = Subject;
            msgMail.Body = Body;
            msgMail.IsBodyHtml = IsBodyHtml;

            var host = new SmtpClient { Host = SmtpHost };

            try
            {
                host.Send(msgMail);
            }
            catch (Exception ex)
            {
                string sendEmailErrorMsg = String.Format("Unable to send email message to '{0}' from '{1}', via SMTP Host '{2}' with Subject: '{3}'",
                                                         ToAddressList,
                                                         FromAddress,
                                                         SmtpHost,
                                                         Subject);

                throw new Exception(sendEmailErrorMsg, ex);
            }
        }
        #endregion
    }
}