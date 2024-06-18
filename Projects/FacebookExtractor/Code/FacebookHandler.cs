using FacebookExtractor.Models;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Xml.XPath;

namespace FacebookExtractor.Code
{
    internal class FacebookHandler
    {
        private string _accessToken { get; set; }
        private readonly WebClient _webClient;

        public FacebookHandler(string accessToken)
        {
            _accessToken = accessToken;
            _webClient = new WebClient(accessToken);
        }

        public string GetPageToken()
        {
            // feed via config
            var result = _webClient.OAuth<dynamic>("1193137505425249", "2e66c2a9da4f7a0785c75537b1461695");
            result.Wait();

            /// generate and supply user token
            /// extend via code
            /// use extended user token to generate extended page token

            return null;
        }

        /// <summary>
        /// Check if current supplied authentication token is still valid by using the "me" endpoint.
        /// </summary>
        /// <returns>true: token is valid, false: token is invalid.</returns>
        public bool ValidateToken()
        {
            var result = _webClient.Get<dynamic>("me");
            result.Wait();

            if (result.Result != null)
            {
                return true;
            }

            return false;
        }

        /// <summary>
        /// Check if supplied page id exists by using the "page" endpoint.
        /// </summary>
        /// <param name="page">Page id</param>
        /// <returns>true: page exists, false: page does not exist or page id is invalid.</returns>
        public bool ValidatePage(string page)
        {
            var result = _webClient.Get<dynamic>(page);
            result.Wait();

            if (result.Result != null)
            {
                return true;
            }

            return false;
        }

        public List<Post> RetrievePosts(string page)
        {
            List<Post> posts = new List<Post>();
            List<string> pageMemory = new List<string>();
            int postCount = 0;
            int pageCount = 0;
            string nextPage = null;
            bool busy = true;

            while (busy)
            {
                dynamic result = null;

                if (string.IsNullOrEmpty(nextPage))
                {
                    result = _webClient.Get<dynamic>(page, "posts?fields=id,created_time,message,attachments{media,subattachments.limit(100){media}}&limit=25");
                }
                else
                {
                    result = _webClient.Get<dynamic>(page, "posts?fields=id,created_time,message,attachments{media,subattachments.limit(100){media}}&limit=25&after=" + nextPage);
                }

                result.Wait();

                if (result.Result == null)
                {
                    busy = false;
                    break;
                }

                try
                {
                    nextPage = JsonConvert.DeserializeObject<JObject>(result.Result["paging"].ToString()).SelectToken("cursors.after").ToString();
                    pageCount++;
                }
                catch
                {
                    nextPage = null;
                }

                if (!pageMemory.Contains(nextPage) && nextPage != null)
                {
                    pageMemory.Add(nextPage);
                }
                else
                {
                    busy = false;
                    break;
                }

                // Convert results to Posts
                var postObjects = JsonConvert.DeserializeObject<JToken>(result.Result["data"].ToString());

                foreach (JObject obj in postObjects)
                {
                    // garbage check
                    bool garbageCheck = false;

                    JToken messageCheck = obj.SelectToken("message");
                    JToken attachmentCheck = obj.SelectToken("attachments");

                    if (messageCheck == null && attachmentCheck == null)
                    {
                        garbageCheck = true;
                    }

                    if (!garbageCheck)
                    {
                        postCount++;
                        Post post = new Post((string)obj.SelectToken("message"),
                                             (DateTime)obj.SelectToken("created_time"),
                                             new List<Uri>());

                        // media check
                        if (attachmentCheck != null)
                        {
                            Uri media = new Uri(obj.SelectToken("attachments.data[0].media.image.src").ToString());
                            post.Images.Add(media);

                            // submedia check
                            JToken subattachmentCheck = obj.SelectToken("attachments.data[0].subattachments");

                            // retarded solution but it works
                            if (subattachmentCheck != null)
                            {
                                bool parsing = true;
                                int subattachmentCount = 1;

                                while (parsing)
                                {
                                    if (obj.SelectToken($"attachments.data[0].subattachments.data[{subattachmentCount}].media.image.src") != null)
                                    {
                                        Uri subAttachment = new Uri(obj.SelectToken($"attachments.data[0].subattachments.data[{subattachmentCount}].media.image.src").ToString());
                                        post.Images.Add(subAttachment);
                                        subattachmentCount++;
                                    }
                                    else
                                    {
                                        parsing = false;
                                    }
                                }
                            }
                        }

                        posts.Add(post);
                        CustomConsole.WriteLine($"[Page {pageCount}] Fetched post from {post.Date} with {post.Images.Count} images.", ConsoleColor.Yellow);
                    }
                }
            }

            return posts;
        }
    }
}
