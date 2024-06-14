using FacebookExtractor.Code;

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

    static string token = "EAAQ9Jvkt12EBOwAZCDZC5jviED05kVVirga1b3FCfRR7c78dDD3MLcANx2u2zuXPEjJqvtjRzgL8uxJAJhEQZA3OHOJzFKsSqFtieMzEoLhfA3ejqjAOA8OGMkyQON144sB2ZC7ClnPQZAdmpssjjj19mAEvuI6U1ZBDGHcZBZACphhN5KtxI0EaZAfW3PAailJyVptcA6mSBARCTVhN09xYkZCMgZD";

    static void Main()
    {
        fb = new FacebookHandler(token);

        // Validation("DeMijnGang");
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

        CustomConsole.WriteLine("\nValidating [page id]...", ConsoleColor.Yellow);
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
        CustomConsole.WriteLine($"\nBeginning extraction of posts from page [{page}].", ConsoleColor.Yellow);

        fb.RetrievePosts(page);
    }
}