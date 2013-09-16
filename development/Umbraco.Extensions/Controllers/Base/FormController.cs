using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;

using DigibizEmailForm;
using HtmlAgilityPack;
using Umbraco.Core;
using Umbraco.Extensions.Enums;
using Umbraco.Extensions.Models;
using Umbraco.Extensions.Models.Custom;
using Umbraco.Extensions.Utilities;
using Umbraco.Web;
using Umbraco.Web.Mvc;
using Umbraco.Web.Models;
using Umbraco.Core.Models;

namespace Umbraco.Extensions.Controllers.Base
{
    public abstract class FormController : BaseSurfaceController
    {
        #region Form - Methods

        /// <summary>
        /// Given the set of replacement values and a list of property aliases
        /// of the email fields, construct and send the required emails.
        /// </summary>
        /// <param name="emailValues">The replacement values</param>
        /// <param name="formAliases">The node property aliases, relevant to the current node.</param>
        protected void ProcessForms(Dictionary<string, string> emailValues, EmailType emailType, params string[] formAliases)
        {
            ProcessForms(emailValues, CurrentPage, emailType, formAliases);
        }

        /// <summary>
        /// Given the set of replacement values and a list of property aliases
        /// of the email fields, construct and send the required emails.
        /// </summary>
        /// <param name="emailValues">The replacement values</param>
        /// <param name="formAliases">The node property aliases, relevant to the current node.</param>
        protected void ProcessForms(Dictionary<string, string> emailValues, IPublishedContent content, EmailType emailType, params string[] formAliases)
        {
            // process each of the given property names, retrieving the form data,
            // replacing placeholders, and sending the email.
            foreach (var alias in formAliases)
            {
                var prop = content.GetPropertyValue<string>(alias, true, string.Empty);
                if (prop != null)
                {
                    var emailFields = DEF_Helper.GetFields(prop);

                    if (emailFields.Send)
                    {
                        ReplacePlaceholders(emailFields, emailValues);
                        emailFields.Body = AddImgAbsolutePath(emailFields.Body);
                        Umbraco.SendEmail(
                            emailFields.SenderEmail,
                            emailFields.SenderName,
                            emailFields.ReceiverEmail,
                            emailFields.Subject,
                            emailFields.Body,
                            emailFields.CCEmail, 
                            emailFields.BCCEmail,
                            emailType: emailType
                            );
                    }
                }
            }
        }

        /// <summary>
        /// Using a dictionary of replacement keys with their corresponding values,
        /// replace the placeholders in each of the email form fields. Dictionary
        /// keys have the placeholder brackets ("[]") added to them, so these
        /// don't need to be included.
        /// </summary>
        /// <param name="template">The email template to process.</param>
        /// <param name="phData">The placeholder data.</param>
        private void ReplacePlaceholders(DEF_Fields template, Dictionary<string, string> phData)
        {
            template.Subject = ReplacePlaceholders(template.Subject, phData);
            template.Body = ReplacePlaceholders(template.Body, phData);
            template.ReceiverEmail = ReplacePlaceholders(template.ReceiverEmail, phData);
            template.CCEmail = ReplacePlaceholders(template.CCEmail, phData);
            template.BCCEmail = ReplacePlaceholders(template.BCCEmail, phData);
            template.SenderEmail = ReplacePlaceholders(template.SenderEmail, phData);
            template.SenderName = ReplacePlaceholders(template.SenderName, phData);
        }

        private string ReplacePlaceholders(string templateString, Dictionary<string, string> phData, bool escapeHtml = false)
        {
            StringBuilder templ = new StringBuilder(templateString);

            foreach (var kv in phData)
            {
                var val = kv.Value;
                if (escapeHtml)
                {
                    val = Server.HtmlEncode(val);
                }
                templ.Replace("[" + kv.Key + "]", val);
            }

            return templ.ToString();
        }

        /// <summary>
        /// Add an absolute path to all the img tags in the html of an e-mail.
        /// </summary>
        /// <param name="html"></param>
        /// <returns></returns>
        private string AddImgAbsolutePath(string html)
        {
            HtmlDocument doc = new HtmlDocument();
            doc.LoadHtml(html);

            var uri = new Uri(HttpContext.Request.Url.AbsoluteUri);
            var domainUrl = string.Format("{0}://{1}", uri.Scheme, uri.Authority);

            if (doc.DocumentNode.SelectNodes("//img[@src]") != null)
            {
                foreach (HtmlNode img in doc.DocumentNode.SelectNodes("//img[@src]"))
                {
                    HtmlAttribute att = img.Attributes["src"];
                    if (att.Value.StartsWith("/"))
                    {
                        att.Value = domainUrl + att.Value;
                    }
                }
            }

            return doc.DocumentNode.InnerHtml;
        }

        #endregion
    }
}
