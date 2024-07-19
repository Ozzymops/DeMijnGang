using AndroidApp_Prototype.Code;
using AndroidApp_Prototype.Models;

public class Program
{
    static async Task Main()
    {
        await new XmlParser().Parse();
    }
}