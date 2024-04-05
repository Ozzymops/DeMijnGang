using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace FacebookRipper.Code
{
    public interface IWebClient
    {
        Task<T> Get<T>(string endpoint, string args = null);
    }

    public class WebClient : IWebClient
    {
        private readonly string _accessToken;
        private readonly HttpClient _httpClient;
        private readonly Uri _apiUri = new Uri("https://graph.facebook.com/v19.0/");

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
    }
}
