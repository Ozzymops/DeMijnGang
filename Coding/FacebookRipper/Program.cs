using Facebook;
using FacebookRipper.Code;

// set up instance
FacebookFunctions instance = new FacebookFunctions("EAAQ9Jvkt12EBO5ZCGFZAkltAP2R0qCFudON0rcZBDWToQ2wykLn28Ax0ZAB2TTIAdyj39xsQrmFazNjdN3cLsikzFSy147OBYcFM0E6zKLzTEoqsQQ80uuoVG8vu5qNN6MYMjOOR7XF68rYKYLExneQZCAgfMcyEtUj56229LAGAEqKyJqMNMrsoY84T731Cfg2Xrr7LWHyT8rJ1fFQZDZD");

// make call
//Group DeMijngang = instance.FetchGroupData(106522215647024);
List<long> longList = instance.Debugging();

foreach (long lon in longList)
{
    Console.WriteLine(lon);
}

// print results
//Console.WriteLine("Fetch group data: " + DeMijngang.Name + ", " + DeMijngang.Id);
//Console.WriteLine(jsonString);