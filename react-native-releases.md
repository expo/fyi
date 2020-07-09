# Expo managed workflow and React Native releases

Every version of the Expo SDK in the managed workflow uses one and only one version of React Native (in the bare workflow you can use a range of React Native versions, this document is focused on the managed workflow). Expo SDK 38 uses 0.62.2, for example. The surface area between Expo and React Native is currently large and interconnected, including the JS interpreter, JS–⁠native bridge, debugging tools, view components, bundler and development server, and some modules. It takes work to keep Expo stable in each of these areas.

A new version of the Expo SDK is released every three months (four releases per year, one per quarter - end of March, end of June, end of September, and end of December). React Native doesn't do time-based releases, and so releases can happen at any time depending on whether the team wants to ship changes that would not be suitable for a patch release.

After React Native releases there is some period of adjustment as the ecosystem catches up with compatibility, and where some bugs that were not caught during the release candidate are resolved and pushed in patch releases of React Native.

To add support for a new version of React Native, we need to do a lot of work that culminates in releasing a new SDK and new version of Expo client. Once we do a release, users expect to be able to safely upgrade to it to access new capabilities and improvements with a minimal amount of regressions (ideally none). If this isn't the case, developers waste a lot of time upgrading then rolling back to the previous release that worked well for them. So we tend to wait until we are confident that new regressions have been resolved in the latest React Native release before we update it.

At the beginning of the cycle for a new SDK version, we evaluate the state of the latest React Native release and if we are confident that it is something we can safely recommend to all Expo managed workflow users then we start the process of updating to it. Sometimes we stay on our current release, or if we're more than one release behind then we may update to the next most recent release. To get a sense of what updating React Native in the Expo codebase looks like, [see this React Native upgrade diary](https://gist.github.com/brentvatne/06ca49d5ec2176afbdbd4002113e777a) and [the related PR](https://github.com/expo/expo/pull/8310).

### So when will Expo support React Native ${LATEST_VERSION}?

This depends on the answers to a bunch of questions, such as:

- When is next Expo SDK release? (see: note above about quarterly releases). This is the earliest possible date for the update to happen.
- How widely adopted is the React Native release? Have third party libraries all updated to work well with it? Is React Native for Web compatible yet? Are there any significant open issues? Have there been patch releases closing initial regressions found during the initial release?
- How important is this React Native update for Expo managed workflow users?
- How much work will it take to keep Expo stable with the latest React Native release?
- How much bandwidth does the Expo team have during this release cycle? This depends on whether we have other more important projects we need to fit in during the SDK release cycle - for example, support for new iOS and Android releases.
