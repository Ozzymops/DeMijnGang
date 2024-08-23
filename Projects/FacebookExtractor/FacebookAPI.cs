using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using FacebookExtractor.Models;
using Newtonsoft.Json.Linq;

namespace FacebookExtractor
{
    internal class FacebookAPI
    {
        private string _accessToken { get; set; }
        private readonly APIHandler _apiHandler;

        public FacebookAPI(string accessToken)
        {
            _accessToken = accessToken;
            _apiHandler = new APIHandler(_accessToken);
        }

        /// <summary>
        /// Authenticate access token.
        /// </summary>
        public bool Authenticate()
        {
            var result = _apiHandler.Get<dynamic>("me");
            result.Wait();

            if (result.Result != null)
            {
                return true;
            }

            return false;
        }

        /// <summary>
        /// Validate given page ID.
        /// </summary>
        public bool Validate(string page)
        {
            var result = _apiHandler.Get<dynamic>(page);
            result.Wait();

            if (result.Result != null)
            {
                return true;
            }

            return false;
        }

        /// <summary>
        /// Black magic that fetches Facebook posts from a given page.
        /// </summary>
        public List<Post> FetchPosts(string page)
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
                    result = _apiHandler.Get<dynamic>(page, "posts?fields=id,created_time,message,attachments{media,subattachments.limit(100){media}}&limit=25");
                }
                else
                {
                    result = _apiHandler.Get<dynamic>(page, "posts?fields=id,created_time,message,attachments{media,subattachments.limit(100){media}}&limit=25&after=" + nextPage);
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
                        Logger.WriteLine($"[Page {pageCount}] Fetched post from {post.Date} with {post.Images.Count} images.", 0, ConsoleColor.Yellow);
                    }
                }
            }

            return posts;
        }
    }
    #region APIHandler
    internal interface IAPIHandler
    {
        Task<T> Get<T>(string endpoint, string args = null);
    }

    internal class APIHandler : IAPIHandler
    {
        private readonly string _accessToken;
        private readonly HttpClient _httpClient;
        private readonly Uri _apiUri = new Uri("https://graph.facebook.com/v20.0/");
        private readonly Uri _authUri = new Uri("https://graph.facebook.com/oauth/");

        public APIHandler(string accessToken)
        {
            _accessToken = accessToken;
            _httpClient = new HttpClient { BaseAddress = _apiUri };
            _httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
        }

        public async Task<T> Get<T>(string endpoint, string args = null)
        {
            string query = "";

            if (String.IsNullOrEmpty(args))
            {
                query = $"{endpoint}?access_token={_accessToken}";
            }
            else
            {
                query = $"{endpoint}/{args}&access_token={_accessToken}";
            }

            using HttpResponseMessage response = await _httpClient.GetAsync(query);

            if (!response.IsSuccessStatusCode)
            {
                return default(T);
            }

            var result = await response.Content.ReadAsStringAsync();
            return JsonConvert.DeserializeObject<T>(result);
        }

        public async Task<T> OAuth<T>(string appId, string appSecret)
        {
            string query = $"access_token?grant_type=fb_exchange_token&client_id={appId}&client_secret={appSecret}&fb_exchange_token={_accessToken}";

            HttpClient authClient = new HttpClient { BaseAddress = _authUri };
            using HttpResponseMessage response = await authClient.GetAsync(query);

            if (!response.IsSuccessStatusCode)
            {
                return default(T);
            }

            var result = await response.Content.ReadAsStringAsync();
            return JsonConvert.DeserializeObject<T>(result);
        }
    }
    #endregion
}