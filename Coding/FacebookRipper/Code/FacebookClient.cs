using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Http;
using System.Net.Http.Headers;
using Newtonsoft.Json;

namespace FacebookRipper.Code
{
    public interface IFacebookClient
    {
        Task<T> GetAsync<T>(string endpoint, string args = null);
    }

    public class FacebookClient : IFacebookClient
    {
        private readonly HttpClient _httpClient;
        private readonly string _accessToken = "EAAQ9Jvkt12EBOyTORBxQqVeVKLfxPOam246iEAxUEghkXNACrXrlsAKeWqapZBwEgsIPRWtoSkKT4skn0NiQDv8UwDgFYGZCcLpJ0w6gAyMG6MVBB2AYFj5at2dzlPnjKzCcJXqzKPkuLXg7EaAcQl2W2KavzliHR9HLgr2uuCbFLxHU4i2ImZAqVQjosGAuyvHZBRCb3Kt1d8x4DdUZD";
        private Uri _graphUri = new Uri("https://graph.facebook.com/v19.0/");

        public FacebookClient()
        {
            _httpClient = new HttpClient { BaseAddress = _graphUri };
            _httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
        }

        public async Task<T> GetAsync<T>(string endpoint, string args = null)
        {
            using HttpResponseMessage response = await _httpClient.GetAsync($"{endpoint}?access_token={_accessToken}&{args}");

            if (!response.IsSuccessStatusCode)
            {
                return default(T);
            }

            var result = await response.Content.ReadAsStringAsync();
            return JsonConvert.DeserializeObject<T>(result);
        }
    }
}
