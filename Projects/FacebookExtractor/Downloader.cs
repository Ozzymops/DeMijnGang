using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using ByteSizeLib;
using FacebookExtractor.Models;
using ShellProgressBar;

namespace FacebookExtractor
{
    internal class Downloader
    {
        public static async Task Download(Post post, string dir, ChildProgressBar progressBar, IProgress<double> progress = null, CancellationToken cancellationToken = default)
        {
            using HttpClient _httpClient = new HttpClient();

            double downloadSpeed = 0;
            int imageCount = 0;
            progressBar.MaxTicks = post.Images.Count;
            progressBar.Message = $"Downloading images from {post.Date.ToString("yyyy-MM-dd")}: {imageCount} / {post.Images.Count} @ {downloadSpeed}mbps.";
            progress = progressBar.AsProgress<double>();

            // check if directory exists
            if (!Directory.Exists(dir))
            {
                Directory.CreateDirectory(dir);
            }

            // post content
            if (!File.Exists(dir + "Post.txt"))
            {
                using (FileStream fileStream = File.Create($"{dir}\\Post.txt"))
                {
                    Byte[] text = new UTF8Encoding(true).GetBytes($"Post date: {post.Date}\nPost content: {post.Content}");
                    fileStream.Write(text, 0, text.Length);
                }
            }

            // post media
            foreach (Uri link in post.Images)
            {
                imageCount++;

                using HttpResponseMessage response = await _httpClient.GetAsync(link, HttpCompletionOption.ResponseHeadersRead, cancellationToken);
                response.EnsureSuccessStatusCode();

                long totalBytes = response.Content.Headers.ContentLength ?? -1L;
                long totalBytesRead = 0L;
                byte[] buffer = new byte[8192];
                bool isMoreToRead = true;

                using Stream contentStream = await response.Content.ReadAsStreamAsync();
                using FileStream fileStream = new FileStream(dir + imageCount + ".webp", FileMode.Create, FileAccess.Write, FileShare.None, buffer.Length, true);

                Stopwatch stopwatch = new Stopwatch();

                do
                {
                    stopwatch.Restart();
                    int bytesRead = await contentStream.ReadAsync(buffer, 0, buffer.Length, cancellationToken);
                    stopwatch.Stop();

                    if (bytesRead == 0)
                    {
                        isMoreToRead = false;
                        progressBar.Tick();
                        downloadSpeed = 0;
                        continue;
                    }

                    downloadSpeed = ByteSize.FromBytes(bytesRead).MegaBytes / stopwatch.Elapsed.TotalSeconds;

                    await fileStream.WriteAsync(buffer, 0, bytesRead, cancellationToken);
                    totalBytesRead += bytesRead;

                    progressBar.Message = $"Downloading images from {post.Date.ToString("yyyy-MM-dd")}: {imageCount} / {post.Images.Count} @ {downloadSpeed}mbps.";
                }
                while (isMoreToRead);
            }
        }

        public static async Task Summarize(List<Post> posts, string dir, string page)
        {
            if (!File.Exists(dir + "Summary.txt"))
            {
                Logger.WriteLine($"Creating [Summary.txt] in root folder of page {page}...", 0, ConsoleColor.Yellow);

                using (FileStream fileStream = File.Create($"{dir}\\Summary.txt"))
                {
                    Byte[] text = new UTF8Encoding(true).GetBytes($"Summary of posts from {page}, last downloaded {DateTime.Now}.\n");
                    fileStream.Write(text, 0, text.Length);
                }

                foreach (Post post in posts)
                {
                    using (StreamWriter streamWriter = File.AppendText($"{dir}\\Summary.txt"))
                    {
                        streamWriter.Write("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
                        streamWriter.Write($"[{posts.IndexOf(post)} - {post.Date.ToString("yyyy-MM-dd")}]\nImage count: {post.Images.Count}\n{post.Content}\n");
                    }
                }
            }
        }
    }
}