# Migrating from auth proxy and Expo Go to Development builds

[`expo-auth-session`](https://docs.expo.dev/versions/latest/sdk/auth-session) API allows [browser-based authentication](https://docs.expo.dev/versions/latest/sdk/auth-session/#how-web-browser-based-authentication-flows-work) (using OAuth or OpenID Connect) to your project for Android and iOS. This guide provides a general overview of configuring and using the API with a [development build](/development/create-development-builds/).

Using AuthSession API proxy (`auth.expo.io`) with Expo Go to implement sign-in functionality using a third-party provider such as Google and Facebook is not recommended for security reasons. This is because the AuthSession API uses a proxy to redirect the user to the third-party provider's website. This proxy is not secure and can be used to steal the user's credentials.

Using development builds allows setting up OAuth 2 from a third-party auth provider. It is more secure since the auth credentials are being transferred between only the app and the auth provider.

## Define a custom scheme

To use the AuthSession API with a development build, you must define a custom [`scheme`](/versions/latest/config/app/#scheme) for your app. This is the same scheme you use to open your app from a link. So, for example, if you use `myapp://` to open your app, you need to define `myapp` as a custom scheme.

You can define a custom scheme in your **app.json**:

```json
{
  "expo": {
    "scheme": "myapp"
  }
}
```

The authentication flow will complete if you do not provide a value for the `scheme`. However, the user will not be redirected back to the app. Instead, they will have to manually exit the authentication popup, which will result in the rejection of the process.

## Use a deep linking URL as a redirect URI

If the OAuth provider requires you to specify a redirect URI manually, you can compose it in the following format:

```shell
scheme://expo-development-client/?url=manifestUrl

# Example
your-scheme://expo-development-client/?url=https://u.expo.dev/your-eas-build-project-id?channel-name=your-channel-name
```

This URI is used to redirect the user back to the app after the authorization process completes.

The `manifestUrl` parameter requires adding your project's EAS project ID and the channel name. If you don't have a channel name specified, the default value is `main`.

Learn more about the [manifestUrl](https://docs.expo.dev/development/development-workflows/#deep-linking-urls).

## Update `useAuthRequest` hook

The [`useAuthRequest`](https://docs.expo.dev/versions/latest/sdk/auth-session/#useauthrequestconfig-discovery) hook loads an authorization request for a code.

It takes a config object in which you have to specify the client ID and other configurations depending on the OAuth provider you are using. You also need to specify the `redirectUri` parameter in the config object.

```diff
const [request, response, promptAsync] = useAuthRequest(
    {
      clientId: 'CLIENT_ID',
      scopes: [...],
+      redirectUri: makeRedirectUri({
+        scheme: 'your-scheme'
+      }),
    },
  );
```

The [`makeRedirectUri()`](https://docs.expo.dev/versions/latest/sdk/auth-session/#authsessionmakeredirecturioptions) generates a redirect URI based on the `scheme` you have defined in the **app.json**. Depending on the OAuth provider you are using, you may need to specify [additional parameters](https://docs.expo.dev/versions/latest/sdk/auth-session/#authsessionredirecturioptions).

> [!NOTE]
> If your project uses `startAsync()` which has been deprecated, you need to migrate to use `useAuthRequest`.

### Using `auth.expo.io` proxy?

If you are using the `auth.expo.io` proxy, you need to update the `redirectUri` parameter to use the `expo-auth-session` package instead of the `expo` package as explained in the previous section. **You should redirect to your app with its own registered scheme rather than to the auth proxy URL.**

If you have previously used `https://auth.expo.io/@your-username/your-app-slug/start` as a redirect URI,

- You can add the additional redirect URI in the format: `your-scheme://expo-development-client/?url=https://u.expo.dev/your-eas-build-project-id?channel-name=your-channel-name`, if your OAuth provider allows you to specify multiple redirect URIs and you can use both the old and new redirect URIs. This will allow your app users to migrate to your app's latest version slowly, and you can remove the old redirect URI later.
- If your OAuth provider only allows you to specify one redirect URI, you must release a new version of your app with the new redirect URI. Your app users who haven't updated yet will need to update before they can log in with the third-party auth provider again. Since the auth provider will be expecting devices to specify the new redirect URI.

## Create a development build

If you have been using Expo Go for development and testing, at this point, you will need to migrate to a [development build](https://docs.expo.dev/development/introduction/).

1. Install `expo-dev-client` in your project by running the following command:

```shell
npx expo install expo-dev-client
```

2. [Create a development](https://docs.expo.dev/development/create-development-builds/) build and install it on your test device or simulator.

> **Note:** If you already use a development build, rebuild your app, as you've defined a custom scheme in the **app.json**.

## Test your changes

Test your changes locally on your development build by running:

```shell
npx expo start --dev-client
```

Then follow the prompts on the terminal to run it on your emulator/simulator, or scan the QR code to run it on your device.

## Security considerations

Never put any secret keys inside your application code. There is no secure way to do this! Instead, you should store your secret key(s) on a server and expose an endpoint that makes API calls for your client and passes the data back.

## Learn more

For some popular providers, we have created guides that show how to set up authentication with them:

- [Google](https://docs.expo.dev/guides/google-authentication)
- [Facebook](https://docs.expo.dev/guides/facebook-authentication)
