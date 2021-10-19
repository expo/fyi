# Migrating from the deprecated `androidNavigationBar.visible` property

`androidNavigationBar.visible` property is deprecated in Android 11, API level 30 (Android docs: `View.setSystemUiVisibility`[https://developer.android.com/reference/android/view/WindowInsetsController]).

We only expose this API via the `app.json` so there are no application code deprecations. In Expo SDK 44, we introduced the programmatic API `expo-navigation-bar` which doesn't expose any API for setting `View.setSystemUiVisibility` directly.

Below we've translated some of the [tips provided by Google](https://developer.android.com/training/system-ui/immersive) for migrating to the new API.

None of the options will show the initial overlay that the deprecated API will, that must be implemented in user-space.

## `leanback`

> `leanback` results in the navigation bar being hidden until the first touch gesture is registered.

The lean back mode is for fullscreen experiences in which users won't be interacting heavily with the screen, such as while watching a video.

<!-- TODO: How to get initial modal? -->
<!-- TODO: Return hidden on app state change -->

```ts
import * as NavigationBar from "expo-navigation-bar";
import { setStatusBarHidden } from "expo-status-bar";

NavigationBar.setPositionAsync("relative");
NavigationBar.setVisibilityAsync("hidden");
NavigationBar.setBehaviorAsync("inset-touch");
setStatusBarHidden(true, "none");
```

### Config: `leanback`

**Before**

```json
{
  "androidNavigationBar": {
    "visible": "leanback"
  }
}
```

**After**

```json
{
  "androidStatusBar": {
    "hidden": "true"
  },
  "plugins": [
    [
      "expo-navigation-bar",
      {
        "position": "relative",
        "visibility": "hidden",
        "behavior": "inset-touch"
      }
    ]
  ]
}
```

## `immersive`

> `immersive` results in the navigation bar being hidden until the user swipes up from the edge where the navigation bar is hidden.

<!-- TODO: How to get initial modal? -->
<!-- TODO: Return hidden on app state change -->

```ts
import * as NavigationBar from "expo-navigation-bar";
import { setStatusBarHidden } from "expo-status-bar";

NavigationBar.setPositionAsync("relative");
NavigationBar.setVisibilityAsync("hidden");
NavigationBar.setBehaviorAsync("inset-swipe");
setStatusBarHidden(true, "none");
```

### Config: `immersive`

**Before**

```json
{
  "androidNavigationBar": {
    "visible": "immersive"
  }
}
```

**After**

```json
{
  "androidStatusBar": {
    "hidden": "true"
  },
  "plugins": [
    [
      "expo-navigation-bar",
      {
        "position": "relative",
        "visibility": "hidden",
        "behavior": "inset-swipe"
      }
    ]
  ]
}
```

## `sticky-immersive`

> `sticky-immersive` is identical to `'immersive'` except that the navigation bar will be semi-transparent and will be hidden again after a short period of time.

```ts
import * as NavigationBar from "expo-navigation-bar";
import { setStatusBarHidden } from "expo-status-bar";

NavigationBar.setPositionAsync("absolute");
NavigationBar.setVisibilityAsync("hidden");
NavigationBar.setBehaviorAsync("inset-swipe");
NavigationBar.setBackgroundColorAsync("#00000080"); // `rgba(0,0,0,0.5)`
setStatusBarHidden(true, "none");
```

You can use `setTimeout` to hide the navigation bar after a certain duration:

```ts
import * as NavigationBar from "expo-navigation-bar";

function useStickyImmersiveReset() {
  const visibility = NavigationBar.useVisibility();

  React.useEffect(() => {
    if (visibility === "visible") {
      const interval = setTimeout(() => {
        NavigationBar.setVisibilityAsync("hidden");
      }, /* 3 Seconds */ 3000);

      return () => {
        clearTimeout(interval);
      };
    }
  }, [visibility]);
}
```

<!-- TODO: How to get initial modal? -->
<!-- TODO: Return hidden on app state change -->

### Config: `sticky-immersive`

**Before**

```json
{
  "androidNavigationBar": {
    "visible": "sticky-immersive"
  }
}
```

**After**

```json
{
  "androidStatusBar": {
    "hidden": "true"
  },
  "plugins": [
    [
      "expo-navigation-bar",
      {
        "position": "absolute",
        "visibility": "hidden",
        "behavior": "inset-swipe",
        "backgroundColor": "#00000080"
      }
    ]
  ]
}
```

## Notes

- [Google guide](https://developer.android.com/training/system-ui/immersive)
