#r "Newtonsoft.Json"

using System.Net;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Primitives;
using System.Linq;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;
using Newtonsoft.Json;


public static async Task<IActionResult> Run(HttpRequest req, ILogger log)
{
    log.LogInformation("C# HTTP trigger function processed a request.");    
    var blobConnectionString = System.Environment.GetEnvironmentVariable("AzureWebJobsStorage");
    
    CloudStorageAccount storageAccount = CloudStorageAccount.Parse(blobConnectionString);

    CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();

    CloudBlobContainer container = blobClient.GetContainerReference("memes");

    CloudBlobDirectory directory = container.GetDirectoryReference("memes/");

    var segmentResult = await directory.ListBlobsSegmentedAsync(false, BlobListingDetails.Metadata, null, null, null, null);
    List<IListBlobItem> list = new List<IListBlobItem>();
    list.AddRange(segmentResult.Results);

    var count = list.Count();

    log.LogInformation($"Amount of items: {count}");

    Random random = new Random();
    int randomNumber = random.Next(0, count - 1);

    log.LogInformation($"Random number: {randomNumber}");
    
    var meme = new {
        memeUrl = list[randomNumber].Uri.AbsoluteUri
    };

    return new OkObjectResult(JsonConvert.SerializeObject(meme));
}