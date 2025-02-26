var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
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

app.MapGet("/meal/remove", () => Results.Ok());
app.MapPost("/make/{id}/tasty", (string id) => Results.Ok(id));

app.Run();

record Menu(DateOnly Date, int TemperatureC, string? Summary)
{
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}

public partial class Program
{
    public Program(){}
}