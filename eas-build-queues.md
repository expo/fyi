# EAS Build Queues

At any given time, there is a fixed maximum capacity for number of concurrent builds on EAS Build. The number of build requests at times will exceed the capacity, and so it is necessary to put build requests into queues.

There are two queue types: normal and priority. The normal queue is available to developers on the free tier, and priority is available to accounts with Production and Enterprise subscriptions and On-demand builds.

Usage of EAS Build tends to peak during the middle of the business day in North American timezones, and during that time, priority builds will typically use up most of the available capacity. The normal queue time during peak will frequently grow to an hour or more. If you find yourself in this situation, you have the following options.

## Alternatives to waiting in free tier queue

- [Upgrade to a Production or Enterprise accounts](https://expo.dev/pricing) for priority queue access
- [Use the On-demand plan](https://expo.dev/pricing#pay-as-you-grow) for priority queue access, and pay per build 
- If you are still using Intel workers for your iOS builds, then [migrate to the much faster Apple Silicon workers](https://expo.fyi/intel-to-m1). [Learn more](https://blog.expo.dev/m1-workers-on-eas-build-dcaa2c1333ad)
- Run your build locally (or on other hosted infrastructure) with `eas build --local`. [Learn more](https://docs.expo.dev/build-reference/local-builds/)
- Run your build locally by running `npx expo prebuild` and then manually archiving and signing it. [Learn more about prebuild](https://docs.expo.dev/workflow/prebuild/)
- Work around peak times and build at slower times of the day. You can see detailed charts about usage on the [EAS Build - Service Status Page](https://expo.dev/eas-build-status) to help decide what times are best.

## Frequently asked questions

### Why are queues needed at all?

Running builds is expensive! If a build takes 20 minutes, that's 20 minutes of compute time on a compute resource that is powerful enough to build an iOS/Android app. Compute time for iOS builds is particularly expensive, and the infrastructure is not dynamically scalable.

### If I urgently need to get a build completed, can I pay for just that build?

You can do this with [the On-demand plan](https://expo.dev/pricing#pay-as-you-grow).
