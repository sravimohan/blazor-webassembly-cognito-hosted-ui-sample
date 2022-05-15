# Sample Blazor Webassembly project Using Cognito Hosted UI Authentication

- Create dotnet WASM project

    ```dotnet new blazorwasm -au Individual -o BlazorWasmCognitoSample```

    This should create a Blazor WASM project with Indivdual type authentication

- [Optional] Create AWS Cognito User Pool. 

    [Sample Cloudformation - cognito-stack.yml](./.cloudformation/cognito-stack.yml)

    [Deploy Script - deploy-cognito-stack.sh](./.cloudformation/deploy-cognito-stack.sh)

    If you are using an existing user pool, make sure the CallbackURLs and LogoutURLs match exactly.  A common cause of grief is the missing or additional trailing slashes.

    Also you will need to configure the Hosted UI.

- Update appsettings.json or appsettings.development.json under wwwroot.  Make sure to replace <AWS_REGION>, <AWS_COGNITO_USERPOOL_ID>, <AWS_COGNITO_APP_CLIENT_ID> with your values.
    ```
    {
        "Cognito": {
            "Authority": "https://cognito-idp.<AWS_REGION>.amazonaws.com/<AWS_COGNITO_USERPOOL_ID>",
            "ClientId": "<AWS_COGNITO_APP_CLIENT_ID>",
            "RedirectUri": "https://localhost:5001/authentication/login-callback",
            "PostLogoutRedirectUri": "https://localhost:5001/authentication/logout-callback",
            "ResponseType": "code"
        }
    }
    ```
- Update Program.cs, to refer to the correct config
    ```
    builder.Services.AddOidcAuthentication(options =>
    {
        builder.Configuration.Bind("Cognito", options.ProviderOptions);
    });
    ```    
    
- Add Authorize Attribute to pages which needs to be protected
    ```
        @using Microsoft.AspNetCore.Authorization

        @page "/fetchdata"
        @attribute [Authorize]
        @inject HttpClient Http

        <PageTitle>Weather forecast</PageTitle>

        ...
    ```

- Run
    ```dotnet run```

Please refer to https://docs.microsoft.com/en-au/aspnet/core/blazor/security/webassembly/?view=aspnetcore-6.0 for official documentation.