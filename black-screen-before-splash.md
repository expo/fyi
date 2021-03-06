# Why does my app launch with a black screen on iOS?

Sometimes you might encounter a black screen before your launch screen on iOS. While this can be annoying, it usually boils down to a few possible issues that are easy to debug and resolve! 

**Note:** The easiest way to set up your splash screen is to use the `@expo/configure-splash-screen` package like so: 
```bash
yarn expo-splash-screen -p ios -i splash.png -b "#ffffff"
```

### 1. Your device or simulator is caching the previously configured splash screen

If you've manually added your own splash image to `Images.xcassets`, then you might need to restart your simulator or device. 

### 2. The provided asset may be invalid

If you never see your splash screen image i.e the app launch transitions from black screen to your app, then there might be a problem with your image.

This could be a number of different issues, [this StackOverflow thread](https://stackoverflow.com/questions/63978396/launch-screen-not-working-on-ios-14-with-xcode-12) outlines a number of possibly solutions.

One quick and easy way to verify that it is indeed a problem with your asset is to change to one of the system assets that is bundled with Xcode - these should launch with no problem

### 3. Sometimes you might have to restart Xcode

It's not uncommon for your app to get into a state where the black screen doesn't seem to go away, or your app never launches. Restarting Xcode usually fixes this.
