# What is new in the Android R

### Does it concern me?

If you're using or want to update to the **SDK 41** or **higher**, you should check if you're using location or media library and follow the instruction below.

You may also observe that some functionalities in `Expo Go` don't work as intended when using a device with Android R or higher. That's because we didn't add changes required by the newest Android to the older SDKs. Therefore, when you're building your app using older SKD via our build service, everything should work as it used to.
We didn't want to break existing applications and force developers to change their code even when they didn't update SDK.

## A new way of handling location permissions

Android team to protect user privacy changed how the app is getting access to location in the background. To address those changes in the Expo SDK, we split location permissions into `foreground` and `background`.

### The foreground permission

If your app contains a feature that shares or receives location information only once, or for a defined amount of time, then that feature requires foreground location access.

#### Requesting permission

When your application requests the foreground permission, users will see modal that looks like this:

[<img src="./assets/android-r/foreground_permissions_modal.png" width="300" />](./assets/asc-app-id/finding-app-id.png)

#### Differences in the way it works across all Android versions

The flow for that permission is the same across all android versions.

### The background permission

An app requires background location access if a feature within the app constantly shares location with other users or uses the Geofencing API.

#### Requesting permission

When your application requests the foreground permission, users won't see modal. He will be redirect to the settings screen which should look like this:

[<img src="./assets/android-r/background_permissions_modal.png" width="300" />](./assets/asc-app-id/finding-app-id.png)

That's why before that, you should inform the user why your application requires background permissions.

**You can request the background permission only if the foreground permission was granted.**

#### Differences in the way it works across all Android versions

- On Android lower than Q, the background permission resolves to the foreground permission and the application won't redirect the user to the settings screen when asked.

- On Android Q, the background permission will show up a similar system modal to the foreground permissions instead of redirecting to the settings screen.

> If you want to know more about location permissions on Android, please check out this [article](https://medium.com/@ty2/understanding-permissions-for-background-location-on-android-11-and-below-bc3ad9be320a).

## Scoped Storage

It’s a concept of storing files, images, etc. separately, called Collections, which restrict the conventional access of the whole storage.

The scoped storage was introduce in Android 10. However, we encouraged to opt-out from this feature in that version by using `requestLegacyExternalStorage` flag. This option is not available anymore when you're targeting Android 11.

### What was changed?

Some of the media library functions will ask the user for permissions before they perform any actions. You should be prepared that any of those functions may be rejected when the user doesn't grant the required permissions.

[<img src="./assets/android-r/modifying_media_request.png" width="400" />](./assets/asc-app-id/finding-app-id.png)

If your app created an album using an older SDK than 41 and you want to add more assets to this album, you need to migrate it to the new scoped directory. Otherwise, your app won't have access to the old album directory and the media library can't add new assets there. However, all other functions will work without problems. That's why you only need to migrate the old album if you want to add something to it.

### Album migration

To make the migration as easy as possible, we introduced two new functions into the media library:

- `checkIfAlbumShouldBeMigratedAsync` which checks if the album should be migrated. In other words, if add operation, won't fail due to the lack of permissions.
- `migrateAlbumIfNeededAsync` which tries to migrate your album automatically to the new directory.

Unfortunately, it not always possible to migrate automatically. For example, if the album contains incompatible file types, the migration method will be rejected, because the media library couldn't figure out where files should be saved.

**Remember to migrate only those albums which were created by your app!**

### Incompatible file types:

- music and pictures or movies
- documents and music, pictures or movies
- not multimedia types

> Note: **movies** and **pictures** are compatible with each other.

### What can I do when the migration failed?

If the `migrateAlbumIfNeededAsync` won't meet your needs, you can always try to migrate files manually. To do it, you can use new method from the file system module - `askForDirectoryPermissionsAsync`. This function allows users to select a specific directory, granting your app access to all of the files and sub-directories within that directory.

[<img src="./assets/android-r/ask_for_dir_permissions.png" width="300" />](./assets/asc-app-id/finding-app-id.png)

After the user selects the folder, you will receive a URI which is compatible with the Scoped Storage Framework. You can use that URI to manually copy files from the external album directory into internal storage via the file system. Then using the media library, you can create a new album or do whatever you want.

> **Note**: The user can select any folder on his phone, so you need to be prepared for a situation where the application won't have access to the wanted folder.

> If you want to know more about scoped storage on Android, please check out the [documentation](https://developer.android.com/about/versions/11/privacy/storage).

> To get more information about the new API, check out [media library](https://docs.expo.io/versions/latest/sdk/media-library/) and [file system](https://docs.expo.io/versions/latest/sdk/filesystem/) documentation.
