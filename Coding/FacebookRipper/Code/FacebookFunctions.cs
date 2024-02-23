using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using FacebookRipper.Models;

namespace FacebookRipper.Code
{
    internal class FacebookFunctions
    {
        FacebookService instance = new FacebookService(new FacebookClient());

        public async Task<List<Photo>> ConvertPhotos(string groupId)
        {
            JObject json = await instance.GetPhotosAsJson(groupId);

            List<Photo> photos = new List<Photo>();
            JObject photoObject = JsonConvert.DeserializeObject<JObject>(json["albums"].ToString());
            int length = photoObject.SelectToken("data[0].photos.data").Count();

            // first run
            for (int i = 0; i < length; i++)
            {
                string prefix = "data[0].photos.data[" + i + "]";
                photos.Add(ParsePhoto(prefix, photoObject));
            }

            // loop

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
