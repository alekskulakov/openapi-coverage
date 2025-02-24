using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.AspNetCore.Mvc.Testing.Handlers;

namespace FoodApi.Tests;

public static class WebApplicationFactoryExtensions
{
    public static HttpClient CreateHttpClient<T>(this WebApplicationFactory<T> factory) where T : class
    {
        return factory.CreateDefaultClient(CreateHandlers());
    }

    private static DelegatingHandler[] CreateHandlers()
    {
        return CreateHandlersCore().ToArray();

        IEnumerable<DelegatingHandler> CreateHandlersCore()
        {
            yield return new OpenApiHttpClientHandler();
			
            yield return new RedirectHandler(100);

            yield return new CookieContainerHandler();
        }
    }
}