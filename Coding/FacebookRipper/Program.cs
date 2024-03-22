using FacebookRipper.Code;
using FacebookRipper.Models;
using System.Diagnostics;

namespace FacebookRipper
{
    public class Program
    {
        // setup
        static APIHandler apiHandler = new APIHandler("EAAQ9Jvkt12EBO8KlZCHGArgwOS0PqJBuoNZCy5MMHTt9oxcS4bLQCMS3N3QQdCvdhhtW8MBCGXZA4FzRYkq9XOcrcyPbfPytUSDBaF2YMn0GkMZBdhU1nwuyQiWZCkHADOIld15ZB44JrZBcmDMmfrZC2n2RjP9P830kMkWGTbWfTFT9mWkJmKZAca6QYbKfR9ZAuTfFQl3bM7jsaFzqT3xAZDZD");
        static CustomConsole customConsole = new CustomConsole();
        static WebDownloader webDownloader = new WebDownloader();

        static void Main(string[] args)
        {
            ValidateAuthenticationToken();
            ValidateGroupId("DeMijngang");
            GetPhotos("DeMijngang");
        }

        static void ValidateAuthenticationToken()
        {
            // auth check
            // - continue or re-enter token
            bool isAuthValid = false;
            CustomConsole.WriteLine("Checking if [authentication token] is still valid...", ConsoleColor.Yellow);

            while (!isAuthValid)
            {
                if (apiHandler.ValidateAuthenticationToken())
                {
                    isAuthValid = true;
                    CustomConsole.WriteLine("[Authentication token] is [valid].", ConsoleColor.Yellow, ConsoleColor.Green);
                }
                else
                {
                    CustomConsole.WriteLine("[Authentication token] is [invalid].", ConsoleColor.Yellow, ConsoleColor.Red);
                    CustomConsole.WriteLine("Please reenter [authentication] token:", ConsoleColor.Yellow);
                    Console.ReadLine();
                    // input blah blah
                }
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

                    if (webDownloader.DownloadFile(photo, AppDomain.CurrentDomain.BaseDirectory + $"pictures\\{albumId}\\"))
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