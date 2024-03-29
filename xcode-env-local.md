# .xcode.env and .xcode.env.local

The `.xcode.env` file exists to make it easy for developers to tell Xcode where to find the `node` executable on their system. This file is intended to be checked in to source control, and it is a generic mechanism that works on most machines. If you're in your team and you all have the same setup which is non-standard, you may want to modify this file.

The `.xcode.env.local` file exists to allow you to override the behavior of `.xcode.env` on your system. **It is not intended to be checked in to source control**. When running a build, if you have accidentally included it in your project then EAS Build will remove the file and warn you. [If you use `.easignore`](https://expo.fyi/eas-build-archive) then you should add `.xcode.env.local` to it. You also likely want it to be included in your `.gitignore`, so your local configuration is not shared with colleagues. Note that `.xcode.env.local` is automatically generated by `pod install`.
