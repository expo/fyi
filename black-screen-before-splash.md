# Why does my app launch with a black screen on iOS?

Sometimes you might encounter a black screen before your launch screen on iOS. While this can be annoying, it usually boils down to a few possible issues that are easy to debug and resolve! 

**Note:** The absolute best way to setup your splash screen is to use the `@expo/configure-splash-screen` package like so: 
```bash
yarn expo-splash-screen -p ios -i splash.png -b "#ffffff"
```

### 1. Xcode + Simulator is being buggy

If you've manually added your own splash image to `Images.xcassets`, then you might need to restart your simulator. 

### 2. There might be something wrong with your asset

If you never see your splash screen image i.e the app launch transitions from black screen to your app, then there might be a problem with your image.

This could be a number of different issues - a quick look at StackOverflow shows a ton of different solutions you might could try: https://stackoverflow.com/questions/63978396/launch-screen-not-working-on-ios-14-with-xcode-12

One quick and easy way to verify that it is indeed a problem with your asset is to change to one of the system assets that is bundled with Xcode - these should launch with no problem

### 3. Sometimes you might have to restart Xcode

It's not uncommon for your app to get into a state where the black screen doesn't seem to go away, or your app never launches. Restarting Xcode usually fixes this.

