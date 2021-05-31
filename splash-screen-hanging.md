# Stuck on the Splash Screen?

If you've recently encountered this popup while developing your app, chances are something has gone wrong with the SplashScreen component. Here are a couple of possible reasons why you might be seeing this with your app: 

### 1. SplashScreen.hideAsync() was never called

If you have been leveraging the SplashScreen component to preload extra data and assets while your app starts up, then it's possible you simply forgot to call this method! 

### 2. Unresolved promise on app startup 

If you have an unresolved promise that prevents `hideAsync()` from being called, then you'll be stuck on the splash screen indefinitely. You can verify what is going wrong by checking the terminal logs: 

<img src="./assets/splash-screen-hanging/error-console.png" width="300" alt="Error Console" />


