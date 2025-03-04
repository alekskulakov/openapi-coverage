namespace FoodApi.Tests;

public static class SwaggerCoverageSettings
{
    static SwaggerCoverageSettings()
    {
        OutputFolder = Path.Combine(Directory.GetCurrentDirectory(), "../../generated_specs");
        EnableSwaggerCoverage = bool.TryParse(Environment.GetEnvironmentVariable("ENABLE_SWAGGER_COVERAGE"), out var enableSwaggerCoverage) && enableSwaggerCoverage;
    }

    public static readonly bool EnableSwaggerCoverage;
    public static readonly string OutputFolder;
}