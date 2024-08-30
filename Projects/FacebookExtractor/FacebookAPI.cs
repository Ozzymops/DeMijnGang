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
            string nextPage = null;
            int pageCount = 0;
            int postCount = 0;
            DateTime previousDate = DateTime.MinValue;
            bool processing = true;

            while (processing)
            {
                dynamic result = null;

                // Change request string based on availability of next page
                string request = "posts?fields=id,created_time,message,attachments{media,subattachments.limit(100){media}}&limit=25&after=" + nextPage;

                if (string.IsNullOrEmpty(nextPage))
                {
                    request = "posts?fields=id,created_time,message,attachments{media,subattachments.limit(100){media}}&limit=25";
                }

                result = _apiHandler.Get<dynamic>(page, request);
                result.Wait();

                if (result.Result == null)
                {
                    processing = false;
                    break;
                }

                // Pagination check
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
                    processing = false;
                    break;
                }

                // Convert results to objects
                var postObjects = JsonConvert.DeserializeObject<JToken>(result.Result["data"].ToString());

                foreach (JObject obj in postObjects)
                {
                    if (obj.SelectToken("message") == null && obj.SelectToken("attachments") == null)
                    {
                        // useless post, return
                        continue;
                    }

                    Post post = new Post((string)obj.SelectToken("message"),
                        (DateTime)obj.SelectToken("created_time"),
                        new List<Uri>());

                    // parse media
                    if (obj.SelectToken("attachments") != null)
                    {
                        // primary media
                        Uri mediaLink = new Uri(obj.SelectToken("attachments.data[0].media.image.src").ToString());
                        post.Images.Add(mediaLink);

                        // additional media
                        if (obj.SelectToken("attachments.data[0].subattachments") != null)
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
                }           
            }

            Logger.WriteLine($"Fetched [{posts.Count}] posts.", 0, ConsoleColor.Green);
            return posts;
        }

        /// <summary>
        /// Black magic that fetches scheduled Facebook posts from a given page.
        /// </summary>
        public List<Post> FetchScheduledPosts(string page)
        {
            List<Post> posts = new List<Post>();
            List<string> pageMemory = new List<string>();
            string nextPage = null;
            int pageCount = 0;
            int postCount = 0;
            DateTime previousDate = DateTime.MinValue;
            bool processing = true;

            while (processing)
            {
                dynamic result = null;

                // Change request string based on availability of next page
                string request = "scheduled_posts?fields=id,created_time,message,attachments{media,subattachments.limit(100){media}}&limit=25&after=" + nextPage;

                if (string.IsNullOrEmpty(nextPage))
                {
                    request = "scheduled_posts?fields=id,created_time,message,attachments{media,subattachments.limit(100){media}}&limit=25";
                }

                result = _apiHandler.Get<dynamic>(page, request);
                result.Wait();

                if (result.Result == null)
                {
                    processing = false;
                    break;
                }

                // Pagination check
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
                    processing = false;
                    break;
                }

                // Convert results to objects
                var postObjects = JsonConvert.DeserializeObject<JToken>(result.Result["data"].ToString());

                foreach (JObject obj in postObjects)
                {
                    if (obj.SelectToken("message") == null && obj.SelectToken("attachments") == null)
                    {
                        // useless post, return
                        continue;
                    }

                    Post post = new Post((string)obj.SelectToken("message"),
                        (DateTime)obj.SelectToken("created_time"),
                        new List<Uri>());

                    // parse media
                    if (obj.SelectToken("attachments") != null)
                    {
                        // primary media
                        Uri mediaLink = new Uri(obj.SelectToken("attachments.data[0].media.image.src").ToString());
                        post.Images.Add(mediaLink);

                        // additional media
                        if (obj.SelectToken("attachments.data[0].subattachments") != null)
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
                }
            }

            Logger.WriteLine($"Fetched [{posts.Count}] scheduled posts.", 0, ConsoleColor.Green);
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