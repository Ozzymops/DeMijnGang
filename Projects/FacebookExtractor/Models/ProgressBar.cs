using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FacebookExtractor.Models
{
    // https://gist.github.com/DanielSWolf/0ab6a96899cc5377bf54
    internal class ProgressBar : IDisposable, IProgress<double>
    {
        private const int maxBlocks = 10;
        private const string animatedString = @"|/-\";
        private readonly TimeSpan animationFrameRate = TimeSpan.FromSeconds(1.0 / 8);

        private readonly Timer timer;

        private double progress = 0;
        private string text = string.Empty;
        private bool disposed = false;
        private int animationFrame = 0;

        public ProgressBar()
        {
            timer = new Timer(TimerHandler);
            if (!Console.IsOutputRedirected)
            {
                ResetTimer();
            }
        }

        public void Report(double value)
        {
            value = Math.Max(0, Math.Min(1, value));
            Interlocked.Exchange(ref progress, value);
        }

        private void TimerHandler(object state)
        {
            lock (timer)
            {
                if (disposed) return;

                int progressBlocks = (int)(progress * maxBlocks);
                int percentage = (int)(progress * 100);
                string progressText = string.Format("[{0}{1}] {2,3}% {3}",
                    new string('#', progressBlocks), new string('-', maxBlocks - progressBlocks),
                    percentage,
                    animatedString[animationFrame++ % animatedString.Length]);
                UpdateText(progressText);
                ResetTimer();
            }
        }

        private void UpdateText(string progressText)
        {
            int commonPrefixLength = 0;
            int commonLength = Math.Min(text.Length, progressText.Length);
            while (commonPrefixLength < commonLength && progressText[commonPrefixLength] == text[commonPrefixLength])
            {
                commonPrefixLength++;
            }

            StringBuilder output = new StringBuilder();
            output.Append('\b', text.Length - commonPrefixLength);
            output.Append(progressText.Substring(commonPrefixLength));

            int overlap = text.Length - progressText.Length;
            if (overlap > 0)
            {
                output.Append(' ', overlap);
                output.Append('\b', overlap);
            }

            Console.Write(output);
            text = progressText;
        }

        private void ResetTimer()
        {
            timer.Change(animationFrameRate, TimeSpan.FromMilliseconds(-1));
        }

        public void Dispose()
        {
            lock (timer)
            {
                disposed = true;
                UpdateText(string.Empty);
            }
        }
    }
}
