using FacebookRipper.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace FacebookRipper.Code
{
    internal class WebDownloader
    {
        System.Net.WebClient _webClient = new System.Net.WebClient();

        public bool DownloadFile(Photo photo, string directory)
        {
            using (_webClient)
            {
                if (!Directory.Exists(directory))
                {
                    CustomConsole.WriteLine($"Directory [{directory}] does not exist. Creating...", ConsoleColor.Yellow);
                    Directory.CreateDirectory(directory);
                }

                if (!File.Exists(directory + photo.Filename + ".webp"))
                {
                    _webClient.DownloadFile(photo.Link, directory + photo.Filename + ".webp");
                    return true;
                }

                return false;      
            }
        }
    }
}
