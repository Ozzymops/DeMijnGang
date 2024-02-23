using Facebook;
using FacebookRipper.Code;
using FacebookRipper.Models;

// set up instance
FacebookFunctions instance = new FacebookFunctions("EAAQ9Jvkt12EBO6abiRJf5lZBfJgjG395wMx7iGJA3STNEC5B2dBorVTUXvAsZASYZAlKLoNyEg0DZCY400KprPC85O5w1kZClY8cv3m4lK4bjW4TEwCFW6Po4PULKLIAEUb481OXxuZCpx9OUxOFDldrwiZCPJB0VxDScEa7TZCsxfk5rl2mX0egCViinrvYlJxD3AZC9giVQZCAWUKuRAzlIZD");

// make call
//Group DeMijngang = instance.FetchGroupData(106522215647024);
List<Photo> photoList = instance.FetchPhotosFromGroup(106522215647024);
int count = 0;

foreach (Photo photo in photoList)
{
    count++;
    Console.WriteLine(count + " - " + photo.Filename);
}