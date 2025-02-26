namespace FoodApi.Tests;

public class OnetimeSetUp
{
    [SetUpFixture]
    public class SetUpFixture()
    {
        [OneTimeSetUp]
        public void SetUp()
        {
            if (Directory.Exists(OpenApiHandlerSettings.OutputFolder))
            {
                Directory.Delete(OpenApiHandlerSettings.OutputFolder, true);
            }
            
            Directory.CreateDirectory(OpenApiHandlerSettings.OutputFolder);
        }
    }
}