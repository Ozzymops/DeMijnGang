using FacebookRipper.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace FacebookRipper.Code
{
    internal class FileDownloader
    {
        public void DownloadFile(Photo photo)
        {
            using (var client = new WebClient())
            {
                client.DownloadFile(photo.Link, photo.Filename + ".webp");
            }
        }
    }
}