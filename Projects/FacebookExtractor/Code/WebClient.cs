using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Headers;
using System.Net.Security;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace FacebookExtractor.Code
{
    public interface IWebClient
    {
        Task<T> Get<T>(string endpoint, string args = null);
    }

    public class WebClient : IWebClient
    {
        private readonly string _accessToken;
        private readonly HttpClient _httpClient;
        private readonly Uri _apiUri = new Uri("https://graph.facebook.com/v20.0/");
        private readonly Uri _oauthUri = new Uri("https://graph.facebook.com/oauth/");

        public WebClient(string accessToken)
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
                query = $"{endpoint}?access_token={_accessToken}&{args}";
            }

            // ERROR SOMEWHERE AROUND HERE?

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

            HttpClient authClient = new HttpClient { BaseAddress = _oauthUri };
            using HttpResponseMessage response = await authClient.GetAsync(query);

            if (!response.IsSuccessStatusCode)
            {
                return default(T);
            }

            var result = await response.Content.ReadAsStringAsync();
            return JsonConvert.DeserializeObject<T>(result);
        }
    }
}
