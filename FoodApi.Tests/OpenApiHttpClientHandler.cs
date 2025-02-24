using Microsoft.AspNetCore.Mvc.Testing.Handlers;
using Microsoft.OpenApi;
using Microsoft.OpenApi.Any;
using Microsoft.OpenApi.Extensions;
using Microsoft.OpenApi.Models;

namespace FoodApi.Tests;

public class OpenApiHttpClientHandler : DelegatingHandler
{
	private readonly string _folderPath = "../../generated_specs";
	protected override async Task<HttpResponseMessage> SendAsync(
		HttpRequestMessage request,
		CancellationToken cancellationToken)
	{
		var operation = new OpenApiOperation
		{
			Description = "Returns all pets from the system that the user has access to",
			Responses = new OpenApiResponses(),
			Parameters = new List<OpenApiParameter>()
		};
		var pathModel = new OpenApiPathItem
		{
			Operations = new Dictionary<OperationType, OpenApiOperation>()
		};

		var response = await base.SendAsync(request, cancellationToken);

		operation.Responses.Add(((int)response.StatusCode).ToString(), new OpenApiResponse
		{
			Description = response.StatusCode.ToString()
		});

		var queryDictionary = System.Web.HttpUtility.ParseQueryString(request.RequestUri?.Query ?? string.Empty);
		var tt = request.RequestUri?.Segments;
		foreach (var queryParam in queryDictionary.AllKeys)
		{
			if (string.IsNullOrEmpty(queryParam))
				continue;
			
			var key = Char.ToLowerInvariant(queryParam[0]) + queryParam.Substring(1);
			operation.Parameters.Add(new OpenApiParameter()
			{
				Name = key,
				In = ParameterLocation.Query,
				Example = new OpenApiString(queryDictionary.Get(queryParam))
			});
		}

		if (Enum.TryParse<OperationType>(request.Method.Method, true, out var operationType))
		{
			pathModel.AddOperation(operationType, operation);

			var path = request.RequestUri?.AbsolutePath ?? string.Empty;

			var document = new OpenApiDocument
			{
				Info = new OpenApiInfo
				{
					Version = "1.0.0",
					Title = "Coverage project",
				},
				Paths = new OpenApiPaths
				{
					[path] = pathModel
				}
			};
			var filePath = Path.Combine(_folderPath, $"{Guid.NewGuid()}.json");

			if (!string.IsNullOrEmpty(_folderPath))
			{
				Directory.CreateDirectory(_folderPath);
				await using var myFile = File.Create(filePath);
				myFile.Close();
				var documentString = document.Serialize(OpenApiSpecVersion.OpenApi3_0, OpenApiFormat.Json);

				await File.WriteAllTextAsync(filePath, documentString, cancellationToken);
			}
		}

		return response;
	}
}