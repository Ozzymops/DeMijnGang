using AndroidApp_Prototype.Code;
using AndroidApp_Prototype.Models;

public class Program
{
    static iCalReader reader = new iCalReader();

    static void Main()
    {
        reader.FetchICS();
        List<Event> events = reader.ParseICS();
    }
}