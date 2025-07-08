
# Configuring Expo SSO with the Generic Identity Provider

The "generic" provider can be used in some cases to configure an identity provider for Expo SSO when your provider isn't explicitly supported. 

### Setting up the client in your IdP

The specifics of this configuration will depend on your identity provider, but in general you want to set the following on the client you create within your IdP for Expo SSO:

- Grant type: Authorization code grant
- Callback URL: `https://expo.dev/auth/callback/generic`
- OpenID Connect scopes: `email,openid,profile`

### Get information from your IdP

You will need the following fields from your identity provider client in order to configure SSO in your Expo dashboard:

- Client ID
- Client secret
- Issuer URL

### Setup your IdP in your Expo dashboard

In order to configure SSO, the following must be true:
- Your account is an organization account
- Your user profile has Owner access on that organization account
- The organization account is subscribed to an Enterprise or higher plan

1. Go to [https://expo.dev/accounts/[account]/settings](https://expo.dev/accounts/keith-test-org-14/settings)
2. Choose the SSO configuration option
3. Choose the "Generic" provider
4. Enter the client ID, client secret, and issuer URL

### Trying out SSO

- Click on the "Members" option in the Expo dashboard. If SSO is configured, you will see an org-specific URL. That URL can be used to log into your organization via SSO.
- You can also login via the EAS CLI:
  - Run `npm install -g eas-cli`
  - Run `eas login`
  - Follow the prompts to login via SSO

## Troubleshooting

- If you can't see the SSO option in the org settings, verify that you have owner access on the org, and that the org is subscribed to the Enterprise plan.
- If you never get redirected to your identity provider's login page, check the Issuer URL
- If you don't get redirected back to Expo, check the contents of the callback URL. Sometimes these have status codes.
- If you can get an error after redirect, contact Expo support

## Staging URL's

If you are evaluating this solution in the staging environment, use the following URL's:
- Callback URL: `https://staging.expo.dev/auth/callback/generic`
- Account settings: [https://staging.expo.dev/accounts/[account]/settings](https://staging.expo.dev/accounts/keith-test-org-14/settings)