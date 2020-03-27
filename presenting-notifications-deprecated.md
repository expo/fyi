# `presentNotificationAsync` method is deprecated

#### 🤔 What Happened

In older `Notifications` API implementations, `presentNotificationAsync` has always showed the implementation without any prerequisites.

Architecture changes in `expo-notifications`, aligning the module's logic closer to how native platforms work, allowed us to expose a much more powerful and customizable API, letting developers explicitly decide how a notification should be handled when the application is in foreground.

In the first version of `expo-notifications` we have decided to leave `presentNotificationAsync` to help developers migrate their code more swiftly, but we have also deprecated it to gently prompt you move to the new API.

#### 💡 Solution

Instead of `presentNotificationAsync` developers are encouraged to use `setNotificationHandler` and `scheduleNotificationAsync`.

`setNotificationHandler` lets you define a function called whenever a new notification is about to be presented in which you can decide how to handle the notification — whether to display the alert or not, whether to play a sound or not, etc.

The simplest notification handler imaginable would be:

```ts
import * as Notifications from 'expo-notifications';

Notifications.setNotificationHandler({
  handleNotification: async () => {
    return {
      shouldShowAlert: true,
      shouldPlaySound: true,
      shouldSetBadge: true,
    };
  },
});
```

Just place this in your `App.[ts|js]` file and all the notifications triggered while your app is in foreground will: show an alert, play a sound and set the badge.

With this handler in place we can now schedule the notification with a trigger that will present the notification immediately, taking handler's configuration into account.

```ts
import * as Notifications from 'expo-notifications';

const notification = { title: 'I am a one, hasty notification.' };

Notifications.scheduleNotificationAsync(notification, null);
```
