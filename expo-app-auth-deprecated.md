# Deprecating `expo-app-auth`

In May 2020 we rewrote [`expo-auth-session`](https://docs.expo.dev/versions/latest/sdk/auth-session/) as a pure JS replacement for most of the authentication systems in Expo.

**AuthSession** solves the following issues with `expo-app-auth`:

- Many authentication providers require nonstandard customizations which weren't possible with the existing native API.
- `expo-app-auth` includes heavy native packages which weren't fully exposed, resulting in larger than necessary build sizes.
- Debugging `expo-app-auth` proved to be very difficult.
- `expo-app-auth` didn't include web support and the native interface wasn't cross platform.
- `expo-app-auth` extends a native library from Google which mostly just worked with the Google authentication.

## Migration

Many auth providers have robust documentation for integrating with `expo-auth-session` making it easier to move over: [Learn more](https://docs.expo.dev/guides/authentication/).

You will probably want to migrate to the Hooks API provided by `expo-auth-session` which has no comparable API in `expo-app-auth`, but if you'd like to migrate one to one, here is the closest estimation:

### `issuer`

An "issuer" is a URL for a server that returns an object of URLs that are used for interacting with the authentication service. For example, Google uses `https://accounts.google.com/.well-known/openid-configuration`.

In `expo-app-auth` you can pass either the `issuer` (service discovery URL) or the `serviceConfiguration` (service object) to the native methods. Internally, the `issuer` would be resolved automatically, this means a single native function has a higher chance of failing (due to network issues, service connection, etc.) and throwing errors that would not be easy to distinguish.

In `expo-auth-session`, you're required to resolve the service object yourself and handle any errors accordingly. This is faster because you can potentially make less fetch requests by getting the issuer once and sharing it across invocations.

Here are some examples of how to use the new API:

**Imperative**

```ts
import { fetchDiscoveryAsync } from "expo-auth-session";
(async () => {
  try {
    const discovery = await fetchDiscoveryAsync(
      "https://accounts.google.com/.well-known/openid-configuration"
    );
  } catch (error) {
    // Handle server / network errors...
  }
})();
```

**Declarative**

```ts
import { useAutoDiscovery } from "expo-auth-session";

// A React component...
function App() {
  const discovery = useAutoDiscovery(
    "https://accounts.google.com/.well-known/openid-configuration"
  );

  // The discovery goes from null to an object when the request finishes.

  return null;
}
```

### `AppAuth.authAsync`

The `authAsync` method encapsulates a lot of functionality, such as auto exchanging client side secrets (never store your secrets in the client!). This functionality has been divided across a couple of different methods and classes in `expo-auth-session`. It is highly recommended that you use the React Hooks API for performing authentication in `expo-auth-session` via `AuthSession.useAuthRequest()`.

For examples of performing authentication with `expo-auth-session`, check out the [Authentication guide](https://docs.expo.dev/guides/authentication/).

Example of [auto exchanging client secret](https://docs.expo.dev/guides/authentication/#coinbase) on the client side (dangerously) in the Coinbase "Auth Code" demo.

For even more info, check out the [API reference](https://docs.expo.dev/versions/latest/sdk/auth-session/#useauthrequest).

### `AppAuth.revokeAsync` -> `AuthSession.revokeAsync`

> [`AuthSession.revokeAsync()` API](https://docs.expo.dev/versions/latest/sdk/auth-session/#authsessionrevokeasync).

The `revokeAsync` method wraps an request to the `revocationEndpoint` URL. This is a simple system to migrate between.

```ts
const clientId = "XXX";
const token = "XXX";
const serviceConfiguration = {
  revocationEndpoint: "...",
};

AppAuth.revokeAsync(
  {
    clientId,
    serviceConfiguration,
  },
  {
    token,
    isClientIdProvided: !!clientId,
  }
);

// v v v

AuthSession.revokeAsync(
  {
    clientId,
    token,
  },
  serviceConfiguration
);
```

### `AppAuth.refreshAsync` -> `AuthSession.refreshAsync`

> [`AuthSession.refreshAsync()` API](https://docs.expo.dev/versions/latest/sdk/auth-session/#authsessionrefreshasync).

The `refreshAsync` method wraps an request to the `tokenEndpoint` URL. This is a simple system to migrate between. Spec: [Section 6](https://tools.ietf.org/html/rfc6749#section-6).

```ts
const clientId = "XXX";
const refreshToken = "XXX";
const serviceConfiguration = {
  tokenEndpoint: "...",
};

AppAuth.refreshAsync(
  {
    clientId,
    serviceConfiguration,
    isRefresh: true,
  },
  refreshToken
);

// v v v

AuthSession.refreshAsync(
  {
    clientId,
    refreshToken,
  },
  serviceConfiguration
);
```

### `AppAuth.URLSchemes`

There is currently no replacement for this iOS-only constant which returns the URI schemes from the app's native `Info.plist`. This may be added to `expo-linking` or `expo-application` in the future.

Check out the [redirect URI patterns](https://docs.expo.dev/guides/authentication/#redirect-uri-patterns) guide for more info.

### `AppAuth.OAuthRedirect`

There is currently no replacement for this constant which simply indicates a native URI scheme that maps to the bundle identifier on iOS and the package name on Android.

This can be generally retrieved by using `expo-application`:

```ts
import * as Application from "expo-application";

const OAuthRedirect = Application.applicationId;
```

### `AppAuth.getDefaultOAuthRedirect()`

This method simply wraps `OAuthRedirect` like so `${ExpoAppAuth.OAuthRedirect}:/oauthredirect`. This can be replicated with `${require('expo-application').applicationId}:/oauthredirect`.
