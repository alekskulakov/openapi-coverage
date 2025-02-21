using System.Diagnostics;
using Microsoft.AspNetCore.Mvc.Testing;

namespace FoodApi.Tests;

[Category("Menu")]
public class BasicTests
{
    private readonly WebApplicationFactory<Program> _factory = new();

    [OneTimeTearDown]
    public void RunAfterAnyTests()
    {
        _factory.Dispose();
    }

    [TestCase()]
    public async Task Get_EndpointsReturnSuccessAndCorrectContentType()
    {
        // Arrange
        var client = _factory.CreateClient();

        // Act
        var response = await client.GetAsync("/menu");

        // Assert
        response.EnsureSuccessStatusCode(); // Status Code 200-299
        Debug.Assert(response.Content.Headers.ContentType != null, "response.Content.Headers.ContentType != null");
        Assert.That(response.Content.Headers.ContentType.ToString(), Is.EqualTo("application/json; charset=utf-8"));
    }
}