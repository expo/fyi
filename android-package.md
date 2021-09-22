# Android Package

A unique id for your application using [reverse domain name notation](https://en.wikipedia.org/wiki/Reverse_domain_name_notation). The package for the Expo client app is `host.exp.exponent`, but it could also be `io.expo.client` or any other unique string that follows this notation. You don't need to own the domain to use the package. The package name also determines the path for your source files inside of your project.

To set the package name, set `android.package` in the Expo config (`app.json` or `app.config.js`) for example:

```json
{
  "android": {
    "package": "io.expo.client"
  }
}
```
