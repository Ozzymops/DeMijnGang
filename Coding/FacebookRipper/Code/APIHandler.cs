using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.CompilerServices;
using FacebookRipper.Models;
using System.Diagnostics;

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
            result.Wait();

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
            result.Wait();

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
            result.Wait();

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
            int photoCount = 0;
            string nextPage = null;
            List<string> pageMemory = new List<string>();

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
                    result = _webClient.Get<dynamic>(albumId + "/photos", "fields=created_time,id,webp_images&limit=25&after=" + nextPage);
                }

                result.Wait();

                if (result.Result == null)
                {
                    busy = false;
                    break;
                }

                var photoObjects = JsonConvert.DeserializeObject<JToken>(result.Result["data"].ToString());
                
                try
                {
                    nextPage = JsonConvert.DeserializeObject<JObject>(result.Result["paging"].ToString()).SelectToken("cursors.after").ToString();
                    pageCount++;
                }
                catch
                {
                    nextPage = null;
                }               

                if (!pageMemory.Contains(nextPage))
                {
                    pageMemory.Add(nextPage);
                }
                else
                {
                    // avoid duplicate paging stuff
                    busy = false;
                    break;
                }

                foreach (JObject obj in photoObjects)
                {
                    photoCount++;
                    Photo photo = new Photo((long)obj.SelectToken("id"),
                                              (DateTime)obj.SelectToken("created_time"),
                                              obj.SelectToken("webp_images[0].source").ToString());
                    photos.Add(photo);
                    Console.WriteLine($"[{nextPage}, page {pageCount}] Added photo {photoCount} with id {photo.Id}");
                }
            }

            return photos;
        }
    }
}
