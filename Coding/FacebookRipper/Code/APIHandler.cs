using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.CompilerServices;
using FacebookRipper.Models;

namespace FacebookRipper.Code
{
    internal class APIHandler
    {
        private readonly string _accessToken = "";
        private readonly WebClient _webClient;

        public APIHandler(string accessToken)
        {
            _accessToken = accessToken;
            _webClient = new WebClient(accessToken);
        }

        /// <summary>
        /// Check if authentication token is still valid by using the "me" endpoint
        /// </summary>
        /// <returns>true: authentication token is valid, false: authentication token is invalid</returns>
        public bool ValidateAuthenticationToken()
        {
            var result = _webClient.Get<dynamic>("me");

            if (result != null)
            {
                return true;
            }

            return false;
        }

        /// <summary>
        /// Check if given page exists.
        /// </summary>
        /// <param name="id">page id as either the page name or the actual id</param>
        /// <returns>true: page exists, false: page does not exist/id is invalid</returns>
        public bool ValidatePageId(string pageId)
        {
            var result = _webClient.Get<dynamic>(pageId);

            if (result != null)
            {
                return true;
            }

            return false;
        }

        /// <summary>
        /// Retrieve list of album ids from page
        /// </summary>
        /// <param name="pageId">page id as either the page name or the actual id</param>
        /// <returns>list of album ids</returns>
        public List<string> GetAlbumIdsFromPage(string pageId)
        {
            var result = _webClient.Get<dynamic>(pageId, "fields=albums{id}");

            JObject albumData = JsonConvert.DeserializeObject<JObject>(result.Result["albums"].ToString());
            var albumIds = albumData.SelectTokens("data[*].id").ToList();

            // convert JVal to list of strings
            List<string> albumIdList = new List<string>();
            foreach (JValue val in albumIds)
            {
                albumIdList.Add(val.ToString());
            }

            return albumIdList;
        }

        public List<Photo> GetPhotosFromAlbum(string albumId)
        {
            List<Photo> photos = new List<Photo>();
            int pageCount = 0;
            string nextPage = null;

            bool busy = true;

            while (busy)
            {
                dynamic result = null;

                if (String.IsNullOrEmpty(nextPage))
                {
                    result = _webClient.Get<dynamic>($"{albumId}/photos", "fields=created_time,id,webp_images&limit=25");                   
                }
                else
                {
                    result = _webClient.Get<dynamic>(albumId + "/photos", "fields=webp_images&created_time&id&limit=25&after=" + nextPage);
                }

                if (result == null)
                {
                    busy = false;
                    break;
                }

                JObject photoData = JsonConvert.DeserializeObject<JObject>(result.Result["data"].ToString());
                nextPage = photoData.SelectToken("paging.cursors.after").ToString();
                var photoObjects = photoData.SelectTokens("data[*]").ToList();

                foreach (JObject obj in photoObjects)
                {
                    Photo photo = new Photo((long)obj.SelectToken("id"),
                                              (DateTime)obj.SelectToken("created_time"),
                                              obj.SelectToken("webp_images[0].source").ToString());
                    photos.Add(photo);
                }
            }

            return photos;
        }
    }
}
