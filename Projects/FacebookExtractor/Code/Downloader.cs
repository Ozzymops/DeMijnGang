using FacebookExtractor.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FacebookExtractor.Code
{
    internal class Downloader
    {
        System.Net.WebClient _webClient = new System.Net.WebClient();

        public bool Download(Post post, string directory)
        {
            try
            {
                if (!Directory.Exists(directory))
                {
                    CustomConsole.WriteLine($"Directory [{directory}] does not exist. Creating...", ConsoleColor.Yellow);
                    Directory.CreateDirectory(directory);
                }

                // Post information
                if (!File.Exists(directory + "Post.txt"))
                {
                    using (FileStream fileStream = File.Create($"{directory}\\Post.txt"))
                    {
                        Byte[] text = new UTF8Encoding(true).GetBytes($"Post date: {post.Date}\nPost content: {post.Content}");
                        fileStream.Write(text, 0, text.Length);
                    }
                }
                else
                {
                    CustomConsole.WriteLine($"File [{post.Date}.txt] already exists. Skipping...", ConsoleColor.Yellow);
                }

                // Images
                int imageCount = 0;
                foreach (Uri link in post.Images)
                {
                    imageCount++;
                    if (!File.Exists(directory + $"{post.Date.ToString("yyyyMMdd")}_{imageCount}.webp"))
                    {
                        _webClient.DownloadFile(link, directory + $"{post.Date.ToString("yyyyMMdd")}_{imageCount}.webp");
                    }
                    else
                    {
                        CustomConsole.WriteLine($"File [{post.Date}_{imageCount}.webp] already exists. Skipping...", ConsoleColor.Yellow);
                    }
                }
            }
            catch (Exception e)
            {
                CustomConsole.WriteLine($"Error in [Downloader]: [{e.Message}]", ConsoleColor.Yellow, ConsoleColor.Red);
                return false;
            }

            return true;
        }
    }
}
