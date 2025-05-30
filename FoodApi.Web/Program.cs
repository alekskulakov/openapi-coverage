using Microsoft.AspNetCore.Mvc;

var builder = WebApplication.CreateBuilder(args);

// Добавляем поддержку Swagger
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Включаем Swagger только в Development
if (app.Environment.IsDevelopment())
{
    app.UseSwagger(options =>
    {
        options.RouteTemplate = "openapi/{documentName}.json";
    });
}

app.UseHttpsRedirection();

var summaries = new[]
{
    "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
};

app.MapGet("/menu", () =>
    {
        var allMenu = Enumerable.Range(1, 5).Select(index =>
                new Menu
                (
                    DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
                    Random.Shared.Next(-20, 55),
                    summaries[Random.Shared.Next(summaries.Length)]
                ))
            .ToArray();
        return allMenu;
    })
    .WithName("GetMenu");

app.MapGet("/meal/{id}/cook", (string id) =>
{
    Console.WriteLine("Starting cooking {0}", id);
    return Results.Ok(id);
});
app.MapGet("/meal/remove", ([FromQuery(Name = "p")] int? page) => Results.Ok());
app.MapGet("/meal/delete", ([FromQuery(Name = "p")] int? page) => Results.Ok())
    .WithOpenApi(operation =>
    {
        operation.Summary = "Удаление приёма пищи";
        operation.Description = "Этот метод устарел, не используйте его.";
        operation.Deprecated = true; // ← это отразится в swagger.json
        return operation;
    });

app.MapDelete("/meal/trash", () => Results.Ok());
app.MapPost("/meal/trash", () => Results.Ok());
app.MapPost("/drinks/trash", () => Results.Ok());
app.MapPost("/drinks/oranges", () => Results.Ok());
app.MapPost("/make/{id}/tasty/{level}", (string id, int level) => Results.Ok(id));

app.Run();

record Menu(DateOnly Date, int TemperatureC, string? Summary)
{
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}

public partial class Program
{
    public Program() { }
}