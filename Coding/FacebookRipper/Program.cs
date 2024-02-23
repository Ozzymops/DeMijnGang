using FacebookRipper.Code;
using FacebookRipper.Models;

// set-up
FacebookFunctions instance = new FacebookFunctions();

// execute
FileDownloader fileDownloader = new FileDownloader();
var photos = await instance.ConvertPhotos("106522215647024");
int count = 0;

foreach (Photo photo in photos)
{
    count++;
    Console.WriteLine($"Photo {count}: {photo.Filename}");
    fileDownloader.DownloadFile(photo);
}