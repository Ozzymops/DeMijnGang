using FacebookExtractor;
using FacebookExtractor.Models;
using ShellProgressBar;
using System;

public class Program
{
    static async Task Main(string[] args)
    {
        // Testing
        // Testing.TestLogger();
        // Testing.TestFacebookAPI();
        // await Testing.TestDownloader();

        string accessToken = "EAAQ9Jvkt12EBOwZAMZBQe4uZBQjoiLZC4H8QDzPWPeg87VRp3vsOBMZCdosm45xiy4BLVkYxYvXHxQPp4C6T06d3R7VZA1QzkAD3GiuKeWj4rdFqVsR8ZBXFehmHaFITcRZAsIRiwY2eTy4dS8HPT1ZCcM30YYVBSAVKH3FVUDBi7m0AYleYG3ZAQa5K79OpfHZC8gZD";
        List<Post> posts = new List<Post>();
        posts = new FacebookAPI(accessToken).FetchPosts("DeMijnGang");

        int postCount = 0;
        using ProgressBar progressBar = new ProgressBar(posts.Count, $"Processing posts: {postCount} / {posts.Count}.");

        foreach (Post post in posts)
        {
            postCount++;
            using ChildProgressBar childProgressBar = progressBar.Spawn(0, null);
            await Downloader.Download(post, "TEST", childProgressBar);
            progressBar.Tick();
        }
    }
}