# Configuring Okta for Expo SSO

In order for Expo to configure your organization to use Single Sign-On (SSO), you will need to configure a new application in Okta and then provide the Expo support team with the following information:

- Client ID from your Okta application
- Client secret from Okta application
- Okta subdomain
- Expo organization name

Read on for how to configure the Okta application and obtain this information.

## Setting up the Okta application

1. In the Okta admin interface, select **Applications** -> **Applications** in the menu on the left:

[<img src="./assets/sso-setup-okta/01-applications-menu.png" height="200" />](./assets/sso-setup-okta/01-applications-menu.png)

2. Then click **Create App Integration**:

[<img src="./assets/sso-setup-okta/02-create-app-integration.png" height="200" />](./assets/sso-setup-okta/02-create-app-integration.png)

3. Choose **OIDC** and **Web Application**:

[<img src="./assets/sso-setup-okta/03-oidc-web-app.png" width="400" />](./assets/sso-setup-okta/03-oidc-web-app.png)

4. Name the app `Expo`` and select the **Authorization Code** and **Refresh Token** options:

[<img src="./assets/sso-setup-okta/04-auth-code-option.png" width="400" />](./assets/sso-setup-okta/04-auth-code-option.png)

5. Set the **Sign-in Redirect URI** to `https://expo.dev/auth/callback/okta` to and the **Sign-out URI** to `https://expo.dev`:

[<img src="./assets/sso-setup-okta/05-redirect-uris.png" width="400" />](./assets/sso-setup-okta/05-redirect-uris.png)

6. Set the **Assignments** settings in a manner consistent with how your Okta organization is configured:

[<img src="./assets/sso-setup-okta/06-assignments.png" width="400" />](./assets/sso-setup-okta/06-assignments.png)

## Providing application info to Expo

After saving the application, Okta will take you to the application screen, where you can copy information that will be needed by the Expo team in order to configure SSO on your Expo organization.

Expo will need:
- Client ID
- Client secret
- Okta subdomain
- Expo organization name

### Obtaining Client ID / Secret / Issuer URL

1. Obtain client ID and secret from the **General** tab under the application::

[<img src="./assets/sso-setup-okta/07-client-id.png" width="400" />](./assets/sso-setup-okta/07-client-id.png)

2. Obtain the subdomain from the user settings in the upper right corner:

[<img src="./assets/sso-setup-okta/08-subdomain.png" width="400" />](./assets/sso-setup-okta/08-subdomain.png)

### Obtaining Expo organization name

The Expo organization name is available from the Account overview when logging into your account at [expo.dev](https://expo.dev):

[<img src="./assets/sso-setup-general/01-expo-org.png" width="400" />](./assets/sso-setup-general/01-expo-org.png)