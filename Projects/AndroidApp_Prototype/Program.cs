using AndroidApp_Prototype.Code;
using AndroidApp_Prototype.Models;

public class Program
{
    static IcalHandler handler = new IcalHandler();

    static void Main()
    {
        handler.ParseIcal(handler.FetchIcal());
    }
}