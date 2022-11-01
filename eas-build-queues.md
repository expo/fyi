# EAS Build Queues

At any given time, there is a fixed maximum capacity for number of concurrent builds on EAS Build. The number of build requests at times will exceed the capacity, and so it is necessary to put build requests into queues.

There are two queue types: normal and priority. The normal queue is available to developers on the free tier, and priority is available to accounts with Production and Enterprise subscriptions.

Usage of EAS Build tends to peak during the middle of the business day in North American timezones, and during that time, priority builds will typically use up most of the available capacity. The normal queue time during peak will frequently grow to an hour or more. If you find yourself in this situation, you have the following options.

## Alternatives to waiting in free tier queue

- [Upgrade to a Production or Enterprise accounts](https://expo.dev/pricing) for priority queue access
- Run your build locally (or on other hosted infrastructure) with `eas build --local`. [Learn more](https://docs.expo.dev/build-reference/local-builds/)
- Run your build locally by running `expo prebuild` and then manually archiving and signing it. [Learn more about prebuild](https://docs.expo.dev/workflow/prebuild/)
- Work around peak times and build at slower times of the day. You can see detailed charts about usage on the [EAS Build - Service Status Page](https://expo.dev/eas-build-status) to help decide what times are best.

## Frequently asked questions

### Why are queues needed at all?

Running builds is expensive! If a build takes 20 minutes, that's 20 minutes of compute time on a compute resource that is powerful enough to build an iOS/Android app. Compute time for iOS builds is particularly expensive, and the infrastructure is not dynamically scalable.

### If I urgently need to get a build completed, can I pay for just that build?

We may offer this in the future, currently it is not possible.
