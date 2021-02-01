## How to migrate from Expo's LegacyNotifications to the new `expo-notifications` library

If you're still using the `LegacyNotifications` library, it's time for you to migrate over! The new library brings plenty of new features, bug fixes, and is much more reliable and intuitive. Plus, we're actively working on it 😁

**If you're using Expo's push notification service, you don't need to change anything on the server-side for this migration.**

### Set up

Run `expo install expo-notifications`. 

> If you're using the bare workflow, you'll need to follow [these additional instructions](https://github.com/expo/expo/tree/master/packages/expo-notifications#installation-in-bare-react-native-projects).

Replace any occurences of 
```
import { Notifications } from 'expo'
``` 
in your JS code with 
```
import * as Notifications from 'expo-notifications';
```

### Edit `app.json`

Some values from [your `app.json` `notification` key](https://docs.expo.io/versions/latest/config/app/#notification) still apply, but some do not:

- `icon` still applies, do not remove it ✅
- `color` still applies, do not remove it ✅
- `iosDisplayInForeground` does not apply, remove it 🚨
  - With `expo-notifications`, this is controlled via [`Notifications.setNotificationHandler()`](https://docs.expo.io/versions/latest/sdk/notifications/#setnotificationhandlerhandler-notificationhandler--null-void)
- `androidMode` does not apply, remove it 🚨
- `androidCollapsedTitle` does not apply, remove it 🚨
  - Both `androidMode` and `androidCollapsedTitle` will be replaced by setting a key in your notification payload, this feature is in progress.

### Replace function calls

Listed below are each of the methods exposed via the LegacyNotifications module, and what you should replace them with.

#### `LegacyNotifications.addListener()`

`addListener` allows you to provide a callback to be run whenever a notification is received or selected in your app. `expo-notifications` actually exposes two different methods to replace this: [`addNotificationReceivedListener()`](https://docs.expo.io/versions/latest/sdk/notifications/#addnotificationreceivedlistenerlistener-event-notification--void-void) and [`addNotificationResponseReceivedListener()`](https://docs.expo.io/versions/latest/sdk/notifications/#addnotificationresponsereceivedlistenerlistener-event-notificationresponse--void-void). The `NotificationReceivedListener` is triggered when a notification is received while your app is foregrounded. The `NotificationResponseReceivedListener` is triggered when a user **interacts** with a notification that was delivered to their device (either by tapping on it, or through the actions exposed via [notification categories](https://docs.expo.io/versions/latest/sdk/notifications/#managing-notification-categories-interactive-notifications)).

Prefer to use hooks? `expo-notifications` has you covered- use the [`useLastNotificationResponseHook()`](https://docs.expo.io/versions/latest/sdk/notifications/#uselastnotificationresponse-undefined--notificationresponse--null) instead of `addNotificationResponseReceivedListener`.

#### `LegacyNotifications.getExpoPushTokenAsync()` & `LegacyNotifications.getDevicePushTokenAsync()`

Both `getExpoPushTokenAsync` and `getDevicePushTokenAsync` have the exact same methods in the new `expo-notifications` API: 
- [`Notifications.getExpoPushTokenAsync()`](https://docs.expo.io/versions/latest/sdk/notifications/#getexpopushtokenasyncoptions-expotokenoptions-expopushtoken)
- [`Notifications.getDevicePushTokenAsync()`](https://docs.expo.io/versions/latest/sdk/notifications/#getdevicepushtokenasync-devicepushtoken)

No changes are necessary unless you eject to bare, in which case you should check the method parameters in the docs.

#### `LegacyNotifications.presentLocalNotificationAsync()` & `LegacyNotifications.scheduleLocalNotificationAsync()`

Both of these have been replaced by [`Notifications.scheduleNotificationAsync()`](https://docs.expo.io/versions/latest/sdk/notifications/#schedulenotificationasyncnotificationrequest-notificationrequestinput-promisestring). To get the same behavior as `LegacyNotifications.presentLocalNotificationAsync` (AKA- trigger a notification instantly), just pass `null` in as the `NotificationTriggerInput`.


#### `LegacyNotifications.dismissNotificationAsync()` 

There is an identical method in the new `expo-notifications` module- [`Notifications.dismissNotificationAsync()`](https://docs.expo.io/versions/latest/sdk/notifications/#dismissnotificationasyncidentifier-string-promisevoid)- no changes necessary:

#### `LegacyNotifications.dismissAllNotificationsAsync()` 

There is an identical method in the new `expo-notifications` module- [`Notifications.dismissAllNotificationsAsync()`](https://docs.expo.io/versions/latest/sdk/notifications/#dismissallnotificationsasync-promisevoid)- no changes necessary:

#### `LegacyNotifications.cancelScheduledNotificationAsync()` 

There is an identical method in the new `expo-notifications` module- [`Notifications.cancelScheduledNotificationAsync()`](https://docs.expo.io/versions/latest/sdk/notifications/#cancelschedulednotificationasyncidentifier-string-promisevoid)- no changes necessary:

#### `LegacyNotifications.cancelAllScheduledNotificationsAsync()`

There is an identical method in the new `expo-notifications` module- [`Notifications.cancelAllScheduledNotificationsAsync()`](https://docs.expo.io/versions/latest/sdk/notifications/#cancelallschedulednotificationsasync-promisevoid)- no changes necessary:


#### `LegacyNotifications.getBadgeNumberAsync()`

Replace with [`Notifications.getBadgeCountAsync`](https://docs.expo.io/versions/latest/sdk/notifications/#getbadgecountasync-promisenumber).

#### `LegacyNotifications.setBadgeNumberAsync()`

Replace with [`Notifications.setBadgeCountAsync`](https://docs.expo.io/versions/latest/sdk/notifications/#setbadgecountasyncbadgecount-number-options-setbadgecountoptions-promiseboolean).

### Notification Categories

We’ve added much more comprehensive support for categories in the new `expo-notifications` module, with plenty more customization options, so the methods and the parameters they accept are a little different. You should [read here](https://docs.expo.io/versions/latest/sdk/notifications/#managing-notification-categories-interactive-notifications) for a complete guide. 

> Replace `LegacyNotifications.createCategoryAsync` with `Notifications.setNotificationCategoryAsync`, and `LegacyNotifications.deleteCategoryAsync` with `Notifications.deleteNotificationCategoryAsync`. 


### Android Notification Channels

We’ve added much more comprehensive support for Android’s notification channels in the new `expo-notifications` module, with plenty more customization options, so the methods and the parameters they accept are a little different. You should [read here](https://docs.expo.io/versions/latest/sdk/notifications/#managing-notification-channels-android-specific) for a complete guide. 

> Replace `LegacyNotifications.createChannelAndroidAsync` with `Notifications.setNotificationChannelAsync`, and replace `LegacyNotifications.deleteChannelAndroidAsync` with `Notifications.deleteNotificationChannelAndroidAsync`. 


