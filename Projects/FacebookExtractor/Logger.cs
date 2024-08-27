using ShellProgressBar;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Net.WebSockets;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace FacebookExtractor
{
    internal class Logger
    {
        /// <summary>
        /// Write a line in the console with the specified color
        /// </summary>
        private static void WriteColoredLine(string message, ConsoleColor color)
        {
            Console.ForegroundColor = color;
            Console.Write(message);
            Console.ResetColor();
        }

        /// <summary>
        /// Write the current time as prefix
        /// </summary>
        private static void TimePrefix()
        {
            WriteColoredLine($"[{DateTime.Now.ToString("HH:mm:ss")}] ", ConsoleColor.Cyan);
        }

        /// <summary>
        /// Write bracketed text as prefix
        /// </summary>
        /// <param name="messageType">1: info, 2: warning, 3: error</param>
        private static void TypePrefix(int messageType)
        {
            switch(messageType)
            {
                case 1: // info
                    WriteColoredLine("[INFO] ", ConsoleColor.White);
                    break;

                case 2: // warning
                    WriteColoredLine("[WARNING] ", ConsoleColor.Yellow);
                    break;

                case 3: // error
                    WriteColoredLine("[ERROR] ", ConsoleColor.Red);
                    break;
            }
        }

        /// <summary>
        /// Write a line in the console with the specified color, prefixed by the current time.
        /// Only colors substring surrounded by brackets [ ].
        /// </summary>
        public static void WriteLine(string message, int messageType = 0, ConsoleColor colorA = ConsoleColor.Gray, ConsoleColor colorB = ConsoleColor.Gray)
        {
            TimePrefix();

            if (messageType != 0)
            {
                TypePrefix(messageType);
            }

            string[] pieces = Regex.Split(message, @"(\[[^\]]*\])");

            // Check if multiple colors were given
            bool multipleColors = false;
            int colorProgress = 0;

            if (colorA != ConsoleColor.White && colorB != ConsoleColor.White)
            {
                multipleColors = true;
            }

            // Extract substring between brackets
            for (int i = 0; i < pieces.Length; i++)
            {
                string piece = pieces[i];

                if (piece.StartsWith("[") && piece.EndsWith("]"))
                {
                    if (multipleColors)
                    {
                        piece = piece.Substring(1, piece.Length - 2);

                        if (colorProgress == 0)
                        {
                            WriteColoredLine(piece, colorA);
                        }
                        else if (colorProgress == 1)
                        {
                            WriteColoredLine(piece, colorB);
                        }

                        colorProgress++;
                    }
                    else
                    {
                        piece = piece.Substring(1, piece.Length - 2);
                        WriteColoredLine(piece, colorA);
                    }
                }
                else
                {
                    Console.Write(piece);
                }
            }

            Console.WriteLine();
        }

        public static void DownloadProgress(string message)
        {
            

            const int totalTicks = 10;
            var options = new ProgressBarOptions
            {
                ProgressCharacter = '─',
                ProgressBarOnBottom = true
            };

            using (var pbar = new ProgressBar(totalTicks, "Initial message", options))
            {
                for (int i = 0; i < 100; i++)
                {
                    if (i % 10 == 0)
                    {
                        pbar.Tick();
                    }

                    Thread.Sleep(100);
                }
            }
        }
    }
}
