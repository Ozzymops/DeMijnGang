using FacebookRipper.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace FacebookRipper.Code
{
    internal class FileDownloader
    {
        WebClient client = new WebClient();

        public void DownloadFile(Photo photo, string directory)
        {
            using (client)
            {
                if (!Directory.Exists(directory))
                {
                    Console.WriteLine($"Directory {directory} does not exist. Creating...");
                    Directory.CreateDirectory(directory);
                }

                if (!File.Exists(directory + photo.Filename + ".webp"))
                {
                    client.DownloadFile(photo.Link, directory + photo.Filename + ".webp");
                }
                else
                {
                    Console.WriteLine("File exists, skipping...");
                }
            }
        }
    }
}