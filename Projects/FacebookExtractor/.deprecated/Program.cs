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

    static string token = null;
    static string page = null;

    static void Main(string[] args)
    {
        dl = new Downloader();
        var arguments = ParseArguments(args);

        if (arguments.TryGetValue("--token", out string token))
        {
            CustomConsole.WriteLine("Found [authentication token] in arguments. Applying...", ConsoleColor.Yellow);
        }
        else
        {
            CustomConsole.WriteLine("Please supply an [authentication token] using the argument '[--token=/authentication token/]'. Press ENTER to exit the application.", ConsoleColor.Yellow, ConsoleColor.Yellow);
            Console.ReadLine();
            Environment.Exit(0);
        }

        fb = new FacebookHandler(token);

        if (arguments.TryGetValue("--page", out string page))
        {
            Validation(page);
            Extract(page);
        }
        else
        {
            CustomConsole.WriteLine("Please supply a [page id] using the argument '[--page=/page id/]'. Press ENTER to exit the application.", ConsoleColor.Yellow, ConsoleColor.Yellow);
            Console.ReadLine();
            Environment.Exit(0);
        }
    }

    static Dictionary<string, string> ParseArguments(string[] args)
    {
        var arguments = new Dictionary<string, string>();

        foreach (var arg in args)
        {
            string[] parts = arg.Split('=');

            if (parts.Length == 2)
            {
                arguments[parts[0]] = parts[1];
            }
            else
            {
                arguments[arg] = null;
            }
        }

        return arguments;
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
            CustomConsole.WriteLine("[Authentication token] is [invalid]. Please follow the instructions from https://developers.facebook.com/docs/facebook-login/guides/access-tokens/get-long-lived/, supply a valid token in the configuration file and restart the application.\nPress ENTER to close the application.", ConsoleColor.Yellow, ConsoleColor.Red);
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
            CustomConsole.WriteLine("[Page id] is [invalid or the supplied authentication token has insufficient privileges]. Please double check the supplied page id and restart the application.\nPress ENTER to close the application.", ConsoleColor.Yellow, ConsoleColor.Red);
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

        if (File.Exists($"downloads\\{page}\\summary.txt"))
        {
            File.Delete($"downloads\\{page}\\summary.txt");
        }

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

        dl.HandleSummarize(posts, $"downloads\\{page}\\", page);

        Console.WriteLine();
        CustomConsole.WriteLine($"Downloads [finished]. Press ENTER to exit the application.", ConsoleColor.Green);
        Console.ReadLine();
        Environment.Exit(0);
    }
}