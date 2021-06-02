# Stuck on the Splash Screen?

It can be frustrating to work on your app when you can't even get it to load past the splash screen. Here are a couple of possible reasons why you might be seeing this with your app:

### 1. You may have forgotten to call `SplashScreen.hideAsync()`

If you have been leveraging the SplashScreen component to preload extra data and assets while your app starts up, then it's possible you simply forgot to call this method! 

### 2. Unresolved promise on app startup 

If you have an unresolved promise that prevents `hideAsync()` from being called, then you'll be stuck on the splash screen indefinitely. You can verify what is going wrong by checking the terminal logs: 

<img src="./assets/splash-screen-hanging/error-console.png" width="300" alt="Error Console" />
