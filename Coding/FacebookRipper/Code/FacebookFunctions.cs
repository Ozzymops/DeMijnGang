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

        public async Task<bool> CheckAuthStatus()
        {
            return await instance.GetAuthStatus();
        }

        public async Task<bool> CheckGroupExistence(string groupId)
        {
            return await instance.CheckGroupExistence(groupId);
        }

        public async Task<List<Photo>> ConvertPhotos(string groupId)
        {
            bool firstRun = true;
            bool hasPaging = true;
            string paging = "";
            List<Photo> photos = new List<Photo>();

            while (hasPaging)
            {
                JObject json = null;

                if (firstRun)
                {
                    firstRun = false;
                    Console.WriteLine("Parsing first page...");
                    json = await instance.GetPhotosAsJson(groupId);
                }
                else
                {
                    Console.WriteLine($"Continuing to page {paging}...");
                    json = await instance.GetPhotosAsJson(groupId, paging);
                }

                JObject photoObject = JsonConvert.DeserializeObject<JObject>(json["albums"].ToString());

                if (String.IsNullOrEmpty(photoObject.SelectToken("data[0].photos.paging.next").ToString()))
                {
                    hasPaging = false;
                }
                else
                {
                    if (String.IsNullOrEmpty(paging))
                    {
                        paging = photoObject.SelectToken("data[0].photos.paging.next").ToString().Split(new string[] { "after=" }, StringSplitOptions.None)[1];
                    }
                    else
                    {
                        paging = photoObject.SelectToken("data[0].photos.paging.next").ToString().Split(new string[] { "after=" }, StringSplitOptions.None)[1];
                        paging = paging.Split('=')[0];
                    }
                    int length = photoObject.SelectToken("data[0].photos.data").Count();

                    for (int i = 0; i < length; i++)
                    {
                        string prefix = "data[0].photos.data[" + i + "]";
                        photos.Add(ParsePhoto(prefix, photoObject));
                    }
                }          
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
