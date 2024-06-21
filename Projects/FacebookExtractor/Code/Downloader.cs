using FacebookExtractor.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
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

                // Images
                int imageCount = 0;
                foreach (Uri link in post.Images)
                {
                    imageCount++;
                    if (!File.Exists(directory + $"{post.Date.ToString("yyyyMMdd")}_{imageCount}.webp"))
                    {
                        CustomConsole.WriteLine($"Downloading file [{post.Date.ToString("yyyyMMdd")}_{imageCount}.webp]...", ConsoleColor.Yellow);
                        _webClient.DownloadFile(link, directory + $"{post.Date.ToString("yyyyMMdd")}_{imageCount}.webp");
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

        public bool HandleSummarize(List<Post> posts, string directory, string page)
        {
            if (!Directory.Exists(directory))
            {
                Directory.CreateDirectory(directory);
            }

            if (!File.Exists(directory + "Summary.txt"))
            {
                CustomConsole.WriteLine($"Creating [Summary.txt] in root folder of page {page}...", ConsoleColor.Yellow);

                using (FileStream fileStream = File.Create($"{directory}\\Summary.txt"))
                {
                    Byte[] text = new UTF8Encoding(true).GetBytes($"Summary of posts from {page}, last downloaded {DateTime.Now}.\n");
                    fileStream.Write(text, 0, text.Length);
                }

                foreach (Post post in posts)
                {
                    using (StreamWriter streamWriter = File.AppendText($"{directory}\\Summary.txt"))
                    {
                        streamWriter.Write("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
                        streamWriter.Write($"[{posts.IndexOf(post)} - {post.Date}]\nImage count: {post.Images.Count}\n{post.Content}\n");
                    }
                }
            }

            return true;
        }
    }
}
