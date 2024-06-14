using FacebookExtractor.Models;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace FacebookExtractor.Code
{
    internal class FacebookHandler
    {
        private readonly string _accessToken = "";
        private readonly WebClient _webClient;

        public FacebookHandler(string accessToken)
        {
            _accessToken = accessToken;
            _webClient = new WebClient(accessToken);
        }

        public string GetPageToken()
        {
            // feed via config
            var result = _webClient.OAuth<dynamic>("1193137505425249", "");

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

            if (result != null)
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

            if (result != null)
            {
                return true;
            }

            return false;
        }

        public List<Post> RetrievePosts(string page)
        {
            // Get posts including id, creation date, message and (sub)attachments
            var result = _webClient.Get<dynamic>(page, "posts?fields=id,created_time,message,attachments{media,subattachments{media}}&limit=25");
            result.Wait();

            /// result
            /// "data"
            ///     "id"
            ///     "created_time"
            ///     "message"
            ///     "attachments"
            ///         "data" - single attachment
            ///             "media"
            ///                 "image"
            ///                     "src"
            ///             "subattachments" - multiple attachments
            ///                 "data"
            ///                     "media" - per image
            ///                         "image"
            ///                             "src"

            JObject retrievedPosts = JsonConvert.DeserializeObject<JObject>(result.Result["data"].ToString());

            return null;
        }
    }
}
