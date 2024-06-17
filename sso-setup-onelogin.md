# Configuring OneLogin for Expo SSO

In order for Expo to configure your organization to use Single Sign-On (SSO), you will need to configure a new application in OneLogin and make note of the following information:

- Client ID from your OneLogin application
- Client secret from OneLogin application
- OneLogin issuer URL
- Expo organization name

Read on for how to configure the OneLogin application and obtain this information.

## Setting up the OneLogin application

1. In the OneLogin administration dashboard, select **Applications** -> **Applications** in the top menu:

[<img src="./assets/sso-setup-onelogin/01-applications-menu.png" width="250" />](./assets/sso-setup-onelogin/01-applications-menu.png)

2. Click **Add App**:

[<img src="./assets/sso-setup-onelogin/02-add-app.png" width="250" />](./assets/sso-setup-onelogin/02-add-app.png)

3. Find and choose “**OpenId Connect (OIDC)**”:

[<img src="./assets/sso-setup-onelogin/03-find-oidc.png" width="600" />](./assets/sso-setup-onelogin/03-find-oidc.png)

4. Give your app a display name and click **Save**:

[<img src="./assets/sso-setup-onelogin/04-display-name.png" width="600" />](./assets/sso-setup-onelogin/04-display-name.png)

5. Go to the Configuration tab, set **Redirect URI’s** to `https://expo.dev/auth/callback/onelogin` and the **Post Logout Redirect URI’s** to `https://expo.dev`:

[<img src="./assets/sso-setup-onelogin/05-redirect-uris.png" width="600" />](./assets/sso-setup-onelogin/05-redirect-uris.png)

## Ensuring users can login from the new application

Depending on how your OneLogin org is configured, you may need to add the application you just created to users’ accounts.

To check this, you can go to the **Users** menu, choose **Users**, and click on a specific user. Click on **Applications**, and check if the user has the application you just created added:

[<img src="./assets/sso-setup-onelogin/06-users.png" width="600" />](./assets/sso-setup-onelogin/06-users.png)

## Providing application info to Expo

Inside your Application on the OneLogin administration dashboard, you can find and copy the information that will be needed by the Expo team in order to configure SSO on your Expo organization.

Expo will need:
- Client ID
- Client secret
- Issuer URL
- Expo organization name

### Obtaining Client ID / Secret / Issuer URL

1. Go to the **Applications menu**, and click on **Applications**:

[<img src="./assets/sso-setup-onelogin/01-applications-menu.png" width="250" />](./assets/sso-setup-onelogin/01-applications-menu.png)

2. Click on your OIDC application:

[<img src="./assets/sso-setup-onelogin/07-application.png" width="600" />](./assets/sso-setup-onelogin/07-application.png)

3. Click on the **SSO** tab, and all of these fields will be to the right:

[<img src="./assets/sso-setup-onelogin/08-sso-tab.png" width="600" />](./assets/sso-setup-onelogin/08-sso-tab.png)

### Obtaining Expo organization name

The Expo organization name is available from the Account overview when logging into your account at [expo.dev](https://expo.dev):

[<img src="./assets/sso-setup-general/01-expo-org.png" width="400" />](./assets/sso-setup-general/01-expo-org.png)