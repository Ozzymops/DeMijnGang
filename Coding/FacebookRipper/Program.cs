using Facebook;

// https://github.com/facebook-csharp-sdk/facebook-csharp-sdk/wiki/Making-Synchronous-Requests
// https://developers.facebook.com/docs/graph-api

// log in
// ask for permissions
// ask for album
// fetch album
// download album

// obfuscate/request
var accessToken = "EAACXWdewi1cBO3BJsLi9YfIsuIZBxmw2AhUhEsGKQetUjdblx6q7UnVHPMP0LsXsdt4UcDDPJo3b8nH1cRDcfd2ifmZCKYEgu29kgrpnZCSKZAaiEdfrb0da3sKFaOnGvncOEdoBaZAdr3NWBBjrQP1ZAaiut64Mmox49qmKEw9iXvKUYzk2N2OS3NEbTxXZCA5OpG6ZCYWGCvZBrmK3wB85zZCs33zTX8WQ8fxtvddwZDZD";

var fb = new FacebookClient { AccessToken = accessToken };
dynamic result = fb.Get("me", new { fields = new[] { "id", "name" } });
var name = result.name;

Console.WriteLine(String.Format("Literally me: {0}", name));