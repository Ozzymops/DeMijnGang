using FacebookRipper.Code;
using FacebookRipper.Models;

// setup
FacebookFunctions instance = new FacebookFunctions();
CustomConsole customConsole = new CustomConsole();

// auth check
// - continue or re-enter token
bool isAuthValid = false;
CustomConsole.WriteLine("Checking if [authentication token] is still valid...", ConsoleColor.Yellow);

while (!isAuthValid)
{
    if (await instance.CheckAuthStatus())
    {
        isAuthValid = true;
        CustomConsole.WriteLine("[Authentication token] is [valid].", ConsoleColor.Yellow, ConsoleColor.Green);
    }
    else
    {
        CustomConsole.WriteLine("[Authentication token] is [invalid].", ConsoleColor.Yellow, ConsoleColor.Red);
        CustomConsole.WriteLine("Please reenter [authentication] token:", ConsoleColor.Yellow);
        Console.ReadLine();
        // input blah blah
    }
}
Console.WriteLine();

// input group ID
// - retrieve group info
// o check if user is sure
// o return error and try again if group does not exist/insufficient authorization

// DEBUG, RESET TO false AND ""
bool isGroupValid = true;
string groupId = "DeMijngang";
// CustomConsole.WriteLine("Input [group ID]: ", ConsoleColor.Yellow);

while (!isGroupValid)
{
    groupId = Console.ReadLine();

    if (await instance.CheckGroupExistence(groupId))
    {
        isGroupValid = true;
        CustomConsole.WriteLine($"Group with ID [{groupId}] [exists].", ConsoleColor.Yellow, ConsoleColor.Green);
    }
    else
    {
        CustomConsole.WriteLine($"Group with ID [{groupId}] does [not exist].", ConsoleColor.Yellow, ConsoleColor.Red);
        CustomConsole.WriteLine($"Please double check given [group ID] and try again.", ConsoleColor.Yellow);
    }
}
Console.WriteLine();

// retrieve pictures
var photos = await instance.ConvertPhotos(groupId);
int amount = photos.Count;

// input picture download location
// - default location ("root/pictures") or specified location

bool isLocationValid = false;
string directory = "";
CustomConsole.WriteLine($"Download to default location [({AppDomain.CurrentDomain.BaseDirectory + "pictures\\"})] or specify a [directory]?", ConsoleColor.Yellow);

while (!isLocationValid)
{
    Console.WriteLine("> [D]efault or [S]pecify");
    string answer = Console.ReadLine();

    if (answer.ToLower() == "d")
    {
        isLocationValid = true;
        directory = AppDomain.CurrentDomain.BaseDirectory + "pictures\\";
        CustomConsole.WriteLine($"Pictures will be saved to default location [({directory})].", ConsoleColor.Yellow);
    }
    else if (answer.ToLower() == "s")
    {
        Console.WriteLine("Input folder path: ");
        string path = Console.ReadLine();

        Console.WriteLine("Invalid path input.");
    }
    else
    {
        Console.WriteLine("Invalid input.");
    }
}
Console.WriteLine();

// ask if pictures should be converted to .webp if not .webp
// ask if pictures should be resized to a maximum height

// download pictures
FileDownloader fileDownloader = new FileDownloader();
CustomConsole.WriteLine($"Downloading [{amount}] photos to directory [{directory}]...", ConsoleColor.Yellow);
int count = 0;

foreach (Photo photo in photos)
{
    count++;
    Console.WriteLine($"Photo {count}: {photo.Filename}");
    fileDownloader.DownloadFile(photo, directory);
    Console.WriteLine();
}

Console.WriteLine("Finished!");

// finish