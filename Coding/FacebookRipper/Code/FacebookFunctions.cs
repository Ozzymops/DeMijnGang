using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Facebook;
using Newtonsoft.Json.Linq;
using FacebookRipper.Models;

namespace FacebookRipper.Code
{
    internal class FacebookFunctions
    {
        private string accessToken;

        public FacebookFunctions(string accessToken)
        {
            this.accessToken = accessToken;
        }

        private IDictionary<string,object> ExecuteRequest(long id, string request)
        {
            FacebookClient facebook = new FacebookClient { AccessToken = accessToken };
            return (IDictionary<string,object>)facebook.Get(id.ToString()+request);
        }

        public Group FetchGroupData(long groupId)
        {
            var result = ExecuteRequest(groupId, "");
            Group group = new Group((string)result["name"], (string)result["id"]);
            return group;
        }

        public List<Photo> FetchPhotosFromGroup(long groupId)
        {
            bool firstRun = true;
            long id = 0;
            string pagingCursor = "";
            List<Photo> photos = new List<Photo>();

            while (!String.IsNullOrEmpty(pagingCursor) || firstRun)
            {
                int length = 0;
                JObject photoObject = null;

                if (firstRun)
                {
                    firstRun = false;
                    var result = ExecuteRequest(groupId, "?fields=albums{photos{id,webp_images,created_time}}");
                    photoObject = JsonConvert.DeserializeObject<JObject>(result["albums"].ToString());
                    length = photoObject.SelectToken("data[0].photos.data").Count();

                    for (int i = 0; i < length; i++)
                    {
                        string prefix = "data[0].photos.data[" + i + "]";
                        photos.Add(ParsePhoto(prefix, photoObject));
                    }
                }
                else
                {
                    // rest
                    var result = ExecuteRequest(id, "/photos?fields=id,webp_images,created_time&after=" + pagingCursor);
                    photoObject = JsonConvert.DeserializeObject<JObject>(result["data"].ToString());
                    length = photoObject.SelectToken("data").Count();

                    for (int i = 0; i < length; i++)
                    {
                        string prefix = "data[" + i + "]";
                        photos.Add(ParsePhoto(prefix, photoObject));
                    }
                }
                                                      
                

                id = (long)photoObject.SelectToken("data[0].id");
                pagingCursor = (string)photoObject.SelectToken("paging.cursors.after");
            }

            return photos;
        }

        public Photo ParsePhoto(string prefix, JObject photoObject)
        {
            Photo photo = new Photo((long)photoObject.SelectToken(prefix + ".id"),
                                       (DateTime)photoObject.SelectToken(prefix + ".created_time"),
                                       new int[] { (int)photoObject.SelectToken(prefix + ".webp_images[0].height"), (int)photoObject.SelectToken(prefix + ".webp_images[0].width") },
                                       (string)photoObject.SelectToken(prefix + ".webp_images[0].source")
            );

            return photo;
        }
    }
}
