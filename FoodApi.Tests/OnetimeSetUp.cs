namespace FoodApi.Tests;

public class OnetimeSetUp
{
    [SetUpFixture]
    public class SetUpFixture()
    {
        [OneTimeSetUp]
        public void SetUp()
        {
            if (Directory.Exists(SwaggerCoverageSettings.OutputFolder))
            {
                Directory.Delete(SwaggerCoverageSettings.OutputFolder, true);
            }
            
            Directory.CreateDirectory(SwaggerCoverageSettings.OutputFolder);
        }
    }
}