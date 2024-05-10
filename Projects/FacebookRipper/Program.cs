using FacebookRipper.Code;
using FacebookRipper.Models;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Diagnostics;

namespace FacebookRipper
{
    public class Program
    {
        // setup
        static APIHandler apiHandler = null;
        static CustomConsole customConsole = new CustomConsole();
        static WebDownloader webDownloader = new WebDownloader();

        static void Main(string[] args)
        {
            using StreamReader reader = new StreamReader(AppDomain.CurrentDomain.BaseDirectory + "config.json");
            var json = reader.ReadToEnd();
            string authenticationToken = JsonConvert.DeserializeObject<JObject>(json).SelectToken("AuthenticationToken").ToString();

            if (!String.IsNullOrEmpty(authenticationToken))
            {
                apiHandler = new APIHandler(authenticationToken);
            }
            else
            {
                CustomConsole.WriteLine($"[No authentication token found in the configuration file].\nPlease make sure the configuration file contains an [authentication token].\nPress ENTER to close the application.", ConsoleColor.Red, ConsoleColor.Yellow);
                Console.ReadLine();
                Environment.Exit(0);
            }

            if (args.Length == 1)
            {
                ValidateAuthenticationToken();
                ValidateGroupId(args[0]);
                GetPhotos(args[0]);
            }
            else
            {
                if (args.Length > 1)
                {
                    CustomConsole.WriteLine($"[Too many arguments ({args.Length})].\nTry again with [only 1 argument]; the target group ID/name.\nPress ENTER to close the application.", ConsoleColor.Red, ConsoleColor.Yellow);
                }

                if (args.Length <= 0)
                {
                    CustomConsole.WriteLine($"[No arguments found].\nTry again with [only 1 argument]; the target group ID/name.\nPress ENTER to close the application.", ConsoleColor.Red, ConsoleColor.Yellow);
                }
                Console.ReadLine();
                Environment.Exit(0);
            }
        }

        static void ValidateAuthenticationToken()
        {
            // auth check
            CustomConsole.WriteLine("Checking if [authentication token] is still valid...", ConsoleColor.Yellow);

            if (apiHandler.ValidateAuthenticationToken())
            {
                CustomConsole.WriteLine("[Authentication token] is [valid].", ConsoleColor.Yellow, ConsoleColor.Green);
            }
            else
            {
                CustomConsole.WriteLine("[Authentication token] is [invalid].", ConsoleColor.Yellow, ConsoleColor.Red);
                CustomConsole.WriteLine("Please enter a [valid] [authentication token] (from https://developers.facebook.com/tools/explorer/) in the configuration file and restart the application.\nPress ENTER to close the application.", ConsoleColor.Green, ConsoleColor.Yellow);
                Console.ReadLine();
                Environment.Exit(0);
            }

            Console.WriteLine();
        }

        static void ValidateGroupId(string pageId)
        {
            // input group ID
            // - retrieve group info
            // o check if user is sure
            // o return error and try again if group does not exist/insufficient authorization

            // DEBUG, RESET TO false AND ""
            bool isPageValid = true;
            pageId = "DeMijngang";
            // CustomConsole.WriteLine("Input [group ID]: ", ConsoleColor.Yellow);

            while (!isPageValid)
            {
                pageId = Console.ReadLine();

                if (apiHandler.ValidatePageId(pageId))
                {
                    isPageValid = true;
                    CustomConsole.WriteLine($"Page with ID [{pageId}] [exists].", ConsoleColor.Yellow, ConsoleColor.Green);
                }
                else
                {
                    CustomConsole.WriteLine($"Page with ID [{pageId}] does [not exist].", ConsoleColor.Yellow, ConsoleColor.Red);
                    CustomConsole.WriteLine($"Please double check given [page ID] and try again.", ConsoleColor.Yellow);
                }
            }
            Console.WriteLine();
        }

        static void GetPhotos(string groupId)
        {
            List<string> albumIds = apiHandler.GetAlbumIdsFromPage(groupId);

            foreach (string albumId in albumIds)
            {
                List<Photo> photos = apiHandler.GetPhotosFromAlbum(albumId);
                
                foreach (Photo photo in photos)
                {
                    CustomConsole.WriteLine($"Downloading file [{photo.Filename}]...", ConsoleColor.Yellow);

                    if (webDownloader.DownloadFile(photo, AppDomain.CurrentDomain.BaseDirectory + $"pictures\\{groupId}\\{albumId}\\"))
                    {
                        CustomConsole.WriteLine($"File [{photo.Filename}] [successfully] downloaded.", ConsoleColor.Yellow, ConsoleColor.Green);
                    }
                    else
                    {
                        CustomConsole.WriteLine($"File [{photo.Filename}] exists, [skipping].", ConsoleColor.Yellow, ConsoleColor.Red);
                    }
                    Console.WriteLine();
                }
            }
        }
    }
}