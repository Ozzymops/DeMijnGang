using FacebookExtractor;
using FacebookExtractor.Models;
using ShellProgressBar;
using System;
using System.Reflection.Metadata.Ecma335;

public class Program
{
    static async Task Main(string[] args)
    {
        var arguments = ParseArguments(args);

        string token = null;
        string page = null;

        // arguments
        if (arguments.TryGetValue("--token", out token))
        {
            Logger.WriteLine("Found token in arguments, applying...", 1);
        }
        else
        {
            Logger.WriteLine("Please supply an [authentication token] using the argument '[--token=/authentication token/]'.\nPress ENTER to exit the application.", 2, ConsoleColor.Yellow, ConsoleColor.Cyan);
            Console.ReadLine();
            Environment.Exit(0);
        }

        if (!arguments.TryGetValue("--page", out page))
        { 
            Logger.WriteLine("Please supply a [page id] using the argument '[--page=/page id/]'.\nPress ENTER to exit the application.", 2, ConsoleColor.Yellow, ConsoleColor.Cyan);
            Console.ReadLine();
            Environment.Exit(0);
        }

        FacebookAPI api = new FacebookAPI(token);

        // validation
        if (!api.Authenticate())
        {
            Logger.WriteLine("The [authentication token] is invalid or expired.\nPlease regenerate the [authentication token] following the instructions below:\nhttps://developers.facebook.com/docs/facebook-login/guides/access-tokens/get-long-lived/\nPress ENTER to close the application.", 2, ConsoleColor.Yellow, ConsoleColor.Yellow);
            Console.ReadLine();
            Environment.Exit(0);
        }

        if (!api.Validate(page))
        {
            Logger.WriteLine("The [page id] is invalid or the supplied authentication token has insufficient privileges.\nPlease ensure that the authentication token has sufficient privileges and double check the [page id].\nPress ENTER to close the application.", 2, ConsoleColor.Yellow, ConsoleColor.Yellow);
            Console.ReadLine();
            Environment.Exit(0);
        }

        // extraction
        List<Post> posts = new List<Post>();
        posts = api.FetchPosts(page);
        posts.AddRange(api.FetchScheduledPosts(page));

        int postCount = 0;

        ProgressBarOptions options = new ProgressBarOptions {
            ForegroundColor = ConsoleColor.White,
            BackgroundColor = ConsoleColor.DarkGray,
            ProgressCharacter = '|',
            CollapseWhenFinished = true
        };

        using ProgressBar progressBar = new ProgressBar(posts.Count, $"Processing posts: {postCount} / {posts.Count}.", options);

        foreach (Post post in posts)
        {
            postCount++;
            int sameDateCount = 1;

            bool folderCheck = true;
            string dir = null;

            while (folderCheck)
            {
                string[] splitDate = post.Date.ToString("yyyy-MM-dd").Split("-");
                dir = AppDomain.CurrentDomain.BaseDirectory + $"downloads\\{page}\\{splitDate[0]}\\{splitDate[1]}\\{splitDate[2]}\\{sameDateCount}\\";

                if (Directory.Exists(dir))
                {
                    sameDateCount++;
                }
                else
                {                   
                    folderCheck = false;
                }
            }

            using ChildProgressBar childProgressBar = progressBar.Spawn(0, null, options);
            await Downloader.Download(post, dir, childProgressBar);
            progressBar.Tick($"Processing posts: {postCount} / {posts.Count}.");
        }

        progressBar.Dispose();

        await Downloader.Summarize(posts, $"downloads\\{page}\\", page);

        Console.WriteLine();
        Logger.WriteLine($"Downloads [finished]. Press ENTER to exit the application.", 0, ConsoleColor.Green);
        Console.ReadLine();
        Environment.Exit(0);
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
}