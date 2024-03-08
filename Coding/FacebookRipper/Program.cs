using FacebookRipper.Code;
using FacebookRipper.Models;
using System.Diagnostics;

namespace FacebookRipper
{
    public class Program
    {
        // setup
        static APIHandler apiHandler = new APIHandler("EAAQ9Jvkt12EBO2iawi0QbDYsR58NEVINwQpEPGJXA5ygjMb7yo05ErB1UIe2CHdyYgDMcIYzqumVuVQM8mCaXzT14AcPCWlo0a6ZB0nQlx01hcX7pwDNfC1kB78idZA0Ezi1KvxCJ5jZCZBCbzwJM8Br6WwZCyKnv8LzBjvTmZA59K112FVzOGBPwrB6Ue6nKE6jOK6JZA7xZBZBdg11OgwZDZD");
        static CustomConsole customConsole = new CustomConsole();

        static void Main(string[] args)
        {
            ValidateAuthenticationToken();
            // ValidateGroupId("DeMijngang");
            // Debug();
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

        // WIP!
        static void Debug()
        {
            List<Photo> photos = apiHandler.GetPhotosFromAlbum("119285344359716");
        }

        static void GetPhotos()
        {
            List<string> albumIds = apiHandler.GetAlbumIdsFromPage("DeMijngang");

            foreach (string albumId in albumIds)
            {
                // parse until end
            }
        }
    }
}

// retrieve pictures
//var photos = await instance.ConvertPhotos(groupId);
//int amount = photos.Count;

// input picture download location
// - default location ("root/pictures") or specified location

//bool isLocationValid = false;
//string directory = "";
//CustomConsole.WriteLine($"Download to default location [({AppDomain.CurrentDomain.BaseDirectory + "pictures\\"})] or specify a [directory]?", ConsoleColor.Yellow);

//while (!isLocationValid)
//{
//    Console.WriteLine("> [D]efault or [S]pecify");
//    string answer = Console.ReadLine();

//    if (answer.ToLower() == "d")
//    {
//        isLocationValid = true;
//        directory = AppDomain.CurrentDomain.BaseDirectory + "pictures\\";
//        CustomConsole.WriteLine($"Pictures will be saved to default location [({directory})].", ConsoleColor.Yellow);
//    }
//    else if (answer.ToLower() == "s")
//    {
//        Console.WriteLine("Input folder path: ");
//        string path = Console.ReadLine();

//        Console.WriteLine("Invalid path input.");
//    }
//    else
//    {
//        Console.WriteLine("Invalid input.");
//    }
//}
//Console.WriteLine();

// ask if pictures should be converted to .webp if not .webp
// ask if pictures should be resized to a maximum height

// download pictures
//FileDownloader fileDownloader = new FileDownloader();
//CustomConsole.WriteLine($"Downloading [{amount}] photos to directory [{directory}]...", ConsoleColor.Yellow);
//int count = 0;

//foreach (Photo photo in photos)
//{
//    count++;
//    Console.WriteLine($"Photo {count}: {photo.Filename}");
//    fileDownloader.DownloadFile(photo, directory);
//    Console.WriteLine();
//}

//Console.WriteLine("Finished!");

// finish