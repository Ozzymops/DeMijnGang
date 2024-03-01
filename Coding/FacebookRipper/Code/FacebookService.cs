using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FacebookRipper.Code
{
    public interface IFacebookService
    {
        Task<JObject> GetPhotosAsJson(string groupId);
    }

    public class FacebookService : IFacebookService
    {
        private readonly IFacebookClient _facebookClient;

        public FacebookService(IFacebookClient facebookClient)
        {
            _facebookClient = facebookClient;
        }

        public async Task<bool> GetAuthStatus()
        {
            var result = await _facebookClient.GetAsync<dynamic>("me");

            if (result != null)
            {
                return true;
            }

            return false;
        }

        public async Task<bool> CheckGroupExistence(string groupId)
        {
            var result = await _facebookClient.GetAsync<dynamic>(groupId);

            if (result != null)
            {
                return true;
            }

            return false;
        }

        public async Task<JObject> GetPhotosAsJson(string groupId)
        {
            var result = await _facebookClient.GetAsync<dynamic>(groupId, "fields=albums{photos{id,webp_images,created_time}}");
            return result;
        }

        public async Task<JObject> GetPhotosAsJson(string groupId, string paging)
        {
            var result = await _facebookClient.GetAsync<dynamic>(groupId, "fields=albums{photos{id,webp_images,created_time}}&after=" + paging);
            return result;
        }
    }
}
