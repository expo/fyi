# Why not build an app based on Expo Go for production

Expo Go is meant for learning and prototyping. [Learn more](https://expo.dev/go#compare).

Behavior of production builds may differ significantly from the Expo Go app, because it is a precompiled sandbox app and your customizations that will apply to production apps and development will likely not be testable in Expo Go.

For example, if you add a library with native code that is not in the Expo SDK, that will not be available in Expo Go. If that library does not compile due to an error or incompatibility, you will only discover this when you run a production build. Additionally, most fields in your **app.json** do not have any impact on your app when it runs in Expo Go, but they will apply when you run a production or development build. Examples of such properties are: `scheme`, `splash` (only the app icon is used in Expo Go), any `plugins`, `predictiveBackGestureEnabled`, and so on.

Development builds provide a reliable and flexible development environment, and behave more predictably and similarly to production builds. This makes it easier to catch potential issues during development.

[Learn more about converting from Expo Go to a development build.](https://docs.expo.dev/develop/development-builds/expo-go-to-dev-build/)
