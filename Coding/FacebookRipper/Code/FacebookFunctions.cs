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

namespace FacebookRipper.Code
{
    internal class FacebookFunctions
    {
        private string accessToken;

        public FacebookFunctions(string accessToken)
        {
            this.accessToken = accessToken;
        }

        private IDictionary<string,object> ExecuteRequest(long groupId, string request)
        {
            FacebookClient facebook = new FacebookClient { AccessToken = accessToken };
            return (IDictionary<string,object>)facebook.Get(groupId.ToString()+request);
        }

        public Group FetchGroupData(long groupId)
        {
            var result = ExecuteRequest(groupId, "");
            Group group = new Group((string)result["name"], (string)result["id"]);
            return group;
        }

        public void FetchPhotosFromGroup(long groupId)
        {
            var result = ExecuteRequest(groupId, "?fields=albums{photos{id,webp_images,created_time}}");         
        }

        public List<long> Debugging()
        {
            string json = @"{
  'albums': {
    'data': [
      {
        'photos': {
          'data': [
            {
              'id': '358007193820862',
              'created_time': '2024-02-08T11:21:37+0000',
              'picture': 'https://scontent-ams4-1.xx.fbcdn.net/v/t39.30808-6/426354947_358007187154196_2752084081286651447_n.jpg?stp=dst-jpg_p130x130&_nc_cat=109&ccb=1-7&_nc_sid=d3bd4b&_nc_ohc=8XhHk7Mg_vgAX_tYJFi&_nc_ht=scontent-ams4-1.xx&edm=AJdBtusEAAAA&oh=00_AfCchNHXY2KLT4vH1TUHIoXaHYJIqXsIDE2HxdMWBz6N1w&oe=65CB9E0B'
            },
            {
              'id': '356261433995438',
              'created_time': '2024-02-05T16:19:15+0000',
              'picture': 'https://scontent-ams4-1.xx.fbcdn.net/v/t39.30808-6/426069659_356264537328461_7808086386114265609_n.jpg?stp=cp1_dst-jpg_s130x130&_nc_cat=102&ccb=1-7&_nc_sid=d3bd4b&_nc_ohc=g2pQC9vQrsUAX_Q8g4O&_nc_ht=scontent-ams4-1.xx&edm=AJdBtusEAAAA&oh=00_AfBHCj0Icokpls5tuTjqn1wf4UeUh5_EZTQoA_CdWqADqw&oe=65CBE92A'
            },
            {
              'id': '356261407328774',
              'created_time': '2024-02-05T16:19:15+0000',
              'picture': 'https://scontent-ams2-1.xx.fbcdn.net/v/t39.30808-6/426061387_356264500661798_5737984274650645560_n.jpg?stp=cp1_dst-jpg_s130x130&_nc_cat=104&ccb=1-7&_nc_sid=d3bd4b&_nc_ohc=eUWgOJFZpD0AX-u-OvN&_nc_ht=scontent-ams2-1.xx&edm=AJdBtusEAAAA&oh=00_AfD3QhWmFtwWQpCrI5MYXAWsBrKhVo_3t3ppf_iFex7UFA&oe=65CB4AFB'
            }
          ],
          'paging': {
            'cursors': {
              'before': 'MzU4MDA3MTkzODIwODYy',
              'after': 'MzU2MjYxNDA3MzI4Nzc0'
            },
            'next': 'https://graph.facebook.com/v19.0/119285344359716/photos?access_token=EAAQ9Jvkt12EBO5ZCGFZAkltAP2R0qCFudON0rcZBDWToQ2wykLn28Ax0ZAB2TTIAdyj39xsQrmFazNjdN3cLsikzFSy147OBYcFM0E6zKLzTEoqsQQ80uuoVG8vu5qNN6MYMjOOR7XF68rYKYLExneQZCAgfMcyEtUj56229LAGAEqKyJqMNMrsoY84T731Cfg2Xrr7LWHyT8rJ1fFQZDZD&pretty=0&fields=id%2Ccreated_time%2Cpicture&limit=3&after=MzU2MjYxNDA3MzI4Nzc0'
          }
        },
        'id': '119285344359716'
      }
    ],
    'paging': {
      'cursors': {
        'before': 'MTE5Mjg1MzQ0MzU5NzE2',
        'after': 'MTE5Mjg1MzQ0MzU5NzE2'
      },
      'next': 'https://graph.facebook.com/v19.0/106522215647024/albums?access_token=EAAQ9Jvkt12EBO5ZCGFZAkltAP2R0qCFudON0rcZBDWToQ2wykLn28Ax0ZAB2TTIAdyj39xsQrmFazNjdN3cLsikzFSy147OBYcFM0E6zKLzTEoqsQQ80uuoVG8vu5qNN6MYMjOOR7XF68rYKYLExneQZCAgfMcyEtUj56229LAGAEqKyJqMNMrsoY84T731Cfg2Xrr7LWHyT8rJ1fFQZDZD&pretty=0&fields=photos.limit%283%29%7Bid%2Ccreated_time%2Cpicture%7D&limit=1&after=MTE5Mjg1MzQ0MzU5NzE2'
    }
  },
  'id': '106522215647024'
}";
            
            JObject aids = JsonConvert.DeserializeObject<JObject>(json);
            int length = aids.SelectToken("albums.data[0].photos.data").Count();

            List<long> photoIds = new List<long>();

            for (int i = 0; i < length; i++)
            {
                photoIds.Add((long)aids.SelectToken("albums.data[0].photos.data[" + i + "].id"));
            }

            return photoIds;
        }
    }
}
