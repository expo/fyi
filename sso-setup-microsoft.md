# Configuring Microsoft Entra ID for Expo SSO

In order for Expo to configure your organization to use Single Sign-On (SSO), you will need to configure a new application in Microsoft Entra ID and then provide the Expo support team with the following information:

- Client ID from your application
- Client secret from application
- Tenant ID
- Expo organization name

Read on for how to configure the Entra ID application and obtain this information.

## Setting up the Entra ID application

### Creating a new application

1. In the [Azure portal](ttps://portal.azure.com/#home), go to **App Registrations** and choose **New Registration**:

[<img src="./assets/sso-setup-microsoft/01-app-registrations.png" width="250" />](./assets/sso-setup-microsoft/01-app-registrations.png)

[<img src="./assets/sso-setup-microsoft/02-new-registration.png" width="250" />](./assets/sso-setup-microsoft/02-new-registration.png)

2. For the new registration, give it a name and set it to "single tenant." Click **Register**:

[<img src="./assets/sso-setup-microsoft/03-register-new-app.png" width="700" />](./assets/sso-setup-microsoft/03-register-new-app.png)

3. Go back to the list of **App Registrations** and click your new registration. Click **Authentication**, **Add a platform**, and **Web**:

[<img src="./assets/sso-setup-microsoft/04-authentication.png" width="250" />](./assets/sso-setup-microsoft/04-authentication.png)

[<img src="./assets/sso-setup-microsoft/04-new-platform.png" width="700" />](./assets/sso-setup-microsoft/04-new-platform.png)

4. Set the **Redirect URI** to `https://expo.dev/auth/callback/msentraid` and click **Configure**:

[<img src="./assets/sso-setup-microsoft/05-configure-web.png" width="500" />](./assets/sso-setup-microsoft/05-configure-web.png)

5. Click **Add URI** and add `https://expo.dev`. Then click **Save**:

[<img src="./assets/sso-setup-microsoft/06-add-redirect-uri.png" width="600" />](./assets/sso-setup-microsoft/06-add-redirect-uri.png)

### Granting permissions

6. Click **API Permissions** on the sidebar and then **Add Permission**:

[<img src="./assets/sso-setup-microsoft/07-api-permissions.png" width="250" />](./assets/sso-setup-microsoft/07-api-permissions.png)

[<img src="./assets/sso-setup-microsoft/08-add-permissions.png" width="250" />](./assets/sso-setup-microsoft/08-add-permissions.png)

7. Click **Microsoft Graph**, **Delegated Permissions**, select the four OpenID permissions (email, offline_access, openid, profile), and then click **Add Permissions**:

[<img src="./assets/sso-setup-microsoft/09-microsoft-graph.png" width="700" />](./assets/sso-setup-microsoft/09-microsoft-graph.png)

[<img src="./assets/sso-setup-microsoft/10-openid-permissions.png" width="700" />](./assets/sso-setup-microsoft/10-openid-permissions.png)

### Set an owner

8. Click **Owners** on the sidebar, **Add owners**, and add an owner:

[<img src="./assets/sso-setup-microsoft/11-owners.png" width="250" />](./assets/sso-setup-microsoft/11-owners.png)

[<img src="./assets/sso-setup-microsoft/12-add-owners.png" width="400" />](./assets/sso-setup-microsoft/12-add-owners.png)

### Create a client secret

9. Click **Overview** on the sidebar and then **Add a certificate or secret**:

[<img src="./assets/sso-setup-microsoft/13-overview.png" width="250" />](./assets/sso-setup-microsoft/13-overview.png)

[<img src="./assets/sso-setup-microsoft/14-add-a-secret.png" width="400" />](./assets/sso-setup-microsoft/14-add-a-secret.png)

10. Click **New client secret**, set a description, and create the secret:

[<img src="./assets/sso-setup-microsoft/15-new-secret.png" width="700" />](./assets/sso-setup-microsoft/15-new-secret.png)

Copy this secret, as it will only be available for a limited time.

### Assigning users to the OIDC app

11. Go to Azure home, then to **Microsoft Entra ID**, and click on the Expo OIDC application:

[<img src="./assets/sso-setup-microsoft/16-entra-id.png" width="250" />](./assets/sso-setup-microsoft/16-entra-id.png)

[<img src="./assets/sso-setup-microsoft/20-enterprise-applications.png" width="250" />](./assets/sso-setup-microsoft/20-enterprise-applications.png)

[<img src="./assets/sso-setup-microsoft/21-enterprise-application.png" width="600" />](./assets/sso-setup-microsoft/20-enterprise-application.png)

12. Click **Assign users and groups**, then **Add User/Group**, then **None Selected**, and then select all applicable users:

[<img src="./assets/sso-setup-microsoft/22-assign-users-and-groups.png" width="250" />](./assets/sso-setup-microsoft/22-assign-users-and-groups.png)

[<img src="./assets/sso-setup-microsoft/23-users-assigned.png" width="600" />](./assets/sso-setup-microsoft/users-assigned.png)

### Important: SSO users must have email addresses

In order to login successfully to Expo with SSO, users must have an email address set. You can check this by going back to the Azure home, then to **Microsoft Entra ID**, **Users**, and then open up a user and look at their **Properties** tab.

[<img src="./assets/sso-setup-microsoft/16-entra-id.png" width="250" />](./assets/sso-setup-microsoft/16-entra-id.png)

[<img src="./assets/sso-setup-microsoft/17-users.png" width="250" />](./assets/sso-setup-microsoft/17-users.png)

[<img src="./assets/sso-setup-microsoft/18-open-a-user.png" width="400" />](./assets/sso-setup-microsoft/18-open-a-user.png)

## Providing application info to Expo

To setup your account to use MS Entra ID, Expo will need:
- Client ID from your application
- Client secret from application
- Tenant ID
- Expo organization name

### Obtaining Client ID / Tenant ID

Client ID will be available under **Home** -> **App registrations** -> your new app:

[<img src="./assets/sso-setup-microsoft/19-client-and-tenant-id.png" width="500" />](./assets/sso-setup-microsoft/19-client-and-tenant-id.png)

### Obtaining Client Secret

If you didn't copy it when creating it, for a limited time, client secret will be available next to the Client and Tenant ID's, under **Client Credentials**. If the secret is no longer visible, you can create a new one:

[<img src="./assets/sso-setup-microsoft/14-add-a-secret.png" width="500" />](./assets/sso-setup-microsoft/14-add-a-secret.png)

### Obtaining Expo organization name

The Expo organization name is available from the Account overview when logging into your account at [expo.dev](https://expo.dev):

[<img src="./assets/sso-setup-general/01-expo-org.png" width="400" />](./assets/sso-setup-general/01-expo-org.png)