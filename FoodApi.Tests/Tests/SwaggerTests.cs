using Microsoft.AspNetCore.Mvc.Testing;

namespace FoodApi.Tests.Tests;

[Category("Other")]
public class SwaggerTests
{
    private readonly WebApplicationFactory<Program> _factory = new();

    [OneTimeTearDown]
    public void RunAfterAnyTests()
    {
        _factory.Dispose();
    }

    [Test]
    public async Task Get_SwaggerJson()
    {
        var client = _factory.CreateClient();

        var response = await client.GetAsync("/openapi/v1.json");

        response.EnsureSuccessStatusCode();
        var content = await response.Content.ReadAsStringAsync();

        await File.WriteAllTextAsync(Path.Combine(SwaggerCoverageSettings.OutputFolder, "swagger.json"), content);
    }
}