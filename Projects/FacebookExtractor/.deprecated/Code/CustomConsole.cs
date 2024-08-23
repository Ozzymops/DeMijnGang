using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace FacebookExtractor.Code
{
    internal class CustomConsole
    {
        public static void WriteLine(string message, ConsoleColor color)
        {
            var pieces = Regex.Split(message, @"(\[[^\]]*\])");

            Console.ForegroundColor = ConsoleColor.Cyan;
            Console.Write($"[{DateTime.Now.ToString("HH:mm:ss")}] ");
            Console.ResetColor();

            for (int i = 0; i < pieces.Length; i++)
            {
                string piece = pieces[i];

                if (piece.StartsWith("[") && piece.EndsWith("]"))
                {
                    Console.ForegroundColor = color;
                    piece = piece.Substring(1, piece.Length - 2);
                }

                Console.Write(piece);
                Console.ResetColor();
            }

            Console.WriteLine();
        }

        public static void WriteLine(string message, ConsoleColor colorA, ConsoleColor colorB)
        {
            var pieces = Regex.Split(message, @"(\[[^\]]*\])");

            bool firstDone = false;

            Console.ForegroundColor = ConsoleColor.Cyan;
            Console.Write($"[{DateTime.Now.ToString("HH:mm:ss")}] ");
            Console.ResetColor();

            for (int i = 0; i < pieces.Length; i++)
            {
                string piece = pieces[i];

                if (piece.StartsWith("[") && piece.EndsWith("]"))
                {
                    if (firstDone)
                    {
                        Console.ForegroundColor = colorB;
                        piece = piece.Substring(1, piece.Length - 2);
                    }
                    else if (!firstDone && piece.EndsWith("]"))
                    {
                        Console.ForegroundColor = colorA;
                        piece = piece.Substring(1, piece.Length - 2);
                        firstDone = true;
                    }
                }

                Console.Write(piece);
                Console.ResetColor();
            }

            Console.WriteLine();
        }
    }
}
