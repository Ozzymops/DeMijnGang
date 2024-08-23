using FacebookExtractor.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FacebookExtractor
{
    internal class Testing
    {
        private readonly static string accessToken = "EAAQ9Jvkt12EBOwZAMZBQe4uZBQjoiLZC4H8QDzPWPeg87VRp3vsOBMZCdosm45xiy4BLVkYxYvXHxQPp4C6T06d3R7VZA1QzkAD3GiuKeWj4rdFqVsR8ZBXFehmHaFITcRZAsIRiwY2eTy4dS8HPT1ZCcM30YYVBSAVKH3FVUDBi7m0AYleYG3ZAQa5K79OpfHZC8gZD";

        public static void TestLogger()
        {
            Logger.WriteLine("Test 1");
            Logger.WriteLine("Test 2-1", 1);
            Logger.WriteLine("Test 2-2", 2);
            Logger.WriteLine("Test 2-3", 3);
            Logger.WriteLine("Test 3: [Apple]", 0, ConsoleColor.Green);
            Logger.WriteLine("Test 4: [Apple] [Pear] Orange", 0, ConsoleColor.Green, ConsoleColor.Magenta);
            Logger.WriteLine("Test 5-1: [Apple] [Pear] Orange", 1, ConsoleColor.Green, ConsoleColor.Magenta);
            Logger.WriteLine("Test 5-2: [Apple] [Pear] Orange", 2, ConsoleColor.Green, ConsoleColor.Magenta);
            Logger.WriteLine("Test 5-3: [Apple] [Pear] Orange", 3, ConsoleColor.Green, ConsoleColor.Magenta);
        }

        public static void TestFacebookAPI()
        {
            FacebookAPI api = new FacebookAPI(accessToken);
            Logger.WriteLine($"FacebookAPI Authenticate: [{api.Authenticate()}]", 1, ConsoleColor.Green);
            Logger.WriteLine($"FacebookAPI Validate: [{api.Validate("DeMijnGang")}]", 1, ConsoleColor.Green);
            api.FetchPosts("DeMijnGang");
        }

        public static void TestDownloader()
        {
            Logger.WriteLine("Test 1");
            using (var progress = new ProgressBar())
            {
                for (int i = 0; i <= 100; i++)
                {
                    progress.Report((double)i / 100);
                    Thread.Sleep(20);
                }
            }
        }
    }
}
