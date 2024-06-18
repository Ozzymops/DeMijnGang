using FacebookExtractor.Code;
using FacebookExtractor.Models;

/// TO DO:
/// - Retrieve posts
/// - Put posts in model
///     o Image source(s)
///     o Title
///     o Date
///     o Content
/// - Export posts to date-sorted folder e.g. "2024-06-14 1" as text files e.g. "20240614.txt"
/// - Download images to aforementioned folder in webp format e.g. "20240614_0001.webp"
/// - Commandline arguments to target page

public class Program
{
    static FacebookHandler fb = null;
    static Downloader dl = null;

    static string token = "EAAQ9Jvkt12EBOZCcz66ByqZAi5vZBPYwTzbLeTV4iru2GfBApZCekwYGRxCKR29gAnIxsqq6vHmiNRMydiHqX79j7vRiYoaRUeV8oXJ2oOn1QYZAc3JFaeRkuPlLC8ZB9FOsb1xVcQkSwUHQJsFZA6h6gNZCc5o6HcZBaxbotUncQZBIi99yPuPLr0wr53Lk0PcZA2BZBnImrG8Cd7idEfBrZCLDb06MZD";

    static void Main()
    {
        fb = new FacebookHandler(token);
        dl = new Downloader();

        // fb.GetPageToken();
        Validation("DeMijnGang");
        Extract("DeMijnGang");
    }

    static void Validation(string page)
    {
        CustomConsole.WriteLine("Validating [authentication token]...", ConsoleColor.Yellow);
        if (fb.ValidateToken())
        {
            CustomConsole.WriteLine("[Authentication token] is [valid].", ConsoleColor.Yellow, ConsoleColor.Green);
        }
        else
        {
            CustomConsole.WriteLine("[Authentication token] is [invalid]. Please regenerate the token from https://developers.facebook.com/tools/explorer/, supply it in the configuration file and restart the application.\nPress any key to close the application.", ConsoleColor.Yellow, ConsoleColor.Red);
            Console.ReadLine();
            Environment.Exit(0);
        }

        CustomConsole.WriteLine("Validating [page id]...", ConsoleColor.Yellow);
        if (fb.ValidatePage(page))
        {
            CustomConsole.WriteLine("[Page id] is [valid].", ConsoleColor.Yellow, ConsoleColor.Green);
        }
        else
        {
            CustomConsole.WriteLine("[Page id] is [invalid or page does not exist]. Please double check the supplied page id and restart the application.\nPress any key to close the application.", ConsoleColor.Yellow, ConsoleColor.Red);
            Console.ReadLine();
            Environment.Exit(0);
        }
    }

    static void Extract(string page)
    {
        CustomConsole.WriteLine($"Beginning extraction of posts from page [{page}].", ConsoleColor.Yellow);

        List<Post> posts = new List<Post>();
        posts = fb.RetrievePosts(page);

        CustomConsole.WriteLine($"Finished extraction of posts from page [{page}], beginning downloads.", ConsoleColor.Yellow);

        foreach (Post post in posts)
        {
            int tempCounter = 1;
            bool trying = true;

            while (trying)
            {
                if (Directory.Exists(AppDomain.CurrentDomain.BaseDirectory + $"downloads\\{page}\\{post.Date.ToString("yyyy-MM-dd")} {tempCounter}\\"))
                {
                    tempCounter++;
                }
                else
                {
                    dl.Download(post, $"downloads\\{page}\\{post.Date.ToString("yyyy-MM-dd")} {tempCounter}\\");
                    trying = false;
                }
            }
        }
    }
}