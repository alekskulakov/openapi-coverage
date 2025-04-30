using System.Diagnostics;
using Microsoft.AspNetCore.Mvc.Testing;

namespace FoodApi.Tests.Tests;

[Category("Cooking")]
public class CookingTests
{
    private readonly WebApplicationFactory<Program> _factory = new();

    [OneTimeTearDown]
    public void RunAfterAnyTests()
    {
        _factory.Dispose();
    }

    [TestCase("drink")]
    [TestCase("fish")]
    public async Task Get_EndpointsReturnSuccessAndCorrectContentType(string mealId)
    {
        // Arrange
        var client = _factory.CreateHttpClient();

        // Act
        var response = await client.GetAsync($"/meal/{mealId}/cook");

        // Assert
        response.EnsureSuccessStatusCode(); // Status Code 200-299
        Debug.Assert(response.Content.Headers.ContentType != null);
        Assert.That(response.Content.Headers.ContentType.ToString(), Is.EqualTo("application/json; charset=utf-8"));
    }
}