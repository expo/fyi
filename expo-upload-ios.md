# `expo upload:ios`

In `expo-cli@4`, `expo upload:ios` no longer works. This document explains what the alternatives are and why it was removed.

## What you can use instead of `expo upload:ios`

- [EAS Submit](https://docs.expo.io/submit/introduction/) - this is the closest equivalent to `expo upload:ios`. By default it works best with `eas build`, but [you can also use it with `expo build:[ios|android]`](https://docs.expo.io/submit/classic-builds/). This option is currently available to EAS Priority Plan subscribers, but will be part of the free tier when EAS Submit graduates from feature preview.
- [Transporter.app](https://apps.apple.com/us/app/transporter/id1450874784?mt=12) - download this app to your macOS machine, open it, then run `expo build:ios`, download the resulting `ipa` file. Drag the `ipa` into Transporter.app to upload it to the App Store.
- [fastlane deliver](https://docs.fastlane.tools/actions/deliver/) - if you used `expo upload:ios` to automate submissions from CI, you can do this by installing `fastlane` on your CI server, downloading your app by using `curl` with the URL returned from `expo url:ipa`, then run `fastlane deliver` with the appropriate parameters.

## Why it was removed

The `upload:ios` command was implemented as follows:

- `expo-cli` packaged a library called `traveling-fastlane` - a standalone, cross-platform [fastlane](https://fastlane.tools/) wrapper.
- `fastlane` is a Ruby library, and `traveling-fastlane` depends on `traveling-ruby` to provide a self-contained cross-platform Ruby executable. The Ruby version in `traveling-ruby` must be compatible with the `fastlane` version.
- `expo-cli` would download your app binary (using `expo url:ipa`) and then call into `traveling-fastlane` to invoke [`fastlane deliver`](https://docs.fastlane.tools/actions/deliver/) with the appropriate parameters.

[Traveling Ruby hasn't been updated for a long time](https://www.joyfulbikeshedding.com/blog/2021-01-06-the-future-of-traveling-ruby.html) and isn't something we can depend on to stay up to date with fastlane's Ruby version requirements. Ruby <= 2.3 stopped being supported [as of fastlane 2.147.0](https://github.com/fastlane/fastlane/releases/tag/2.147.0), and that was the latest version of Ruby that shipped with Traveling Ruby.

In addition to this dependency situation, there were some significant limitations with the `fastlane` approach:

- `fastlane deliver` only works on macOS machines.
- It can fail if the developer's Xcode version out of date.

So, we built a replacement - [EAS Submit](https://docs.expo.io/submit/introduction/). This is a hosted service that works on macOS, Windows, Linux, and any other platform where Node.js & eas-cli will run.

> Note: in 2021 there has been some movement in updating Traveling Ruby, but it does not yet show signs of being a sustainable project that we can depend on and because of the limitations mentioned above we prefer the EAS Submit solution.