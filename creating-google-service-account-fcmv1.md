# Uploading a Google Service Account Key for Android notifications via FCM v1

> **Note:** Beginning in June 2024, all Android notifications must be sent using the FCM v1 protocol.

A Google Service Account Key is a credential in the form of a JSON file that you can obtain via Google Cloud for a particular Google Service Account.

EAS requires a Google Service Account Key to be uploaded and configured for sending Android push notifications via `https://exp.host/--/api/v2/push/send` using the FCM v1 protocol.

> You can configure separate Google Service Account Keys for [Play Store Submissions](/creating-google-service-account.md) and sending Android Push notifications with FCM v1 protocol or you can upload a single Google Service Account Key and use it for both use cases (provided that the correct authorizations are in place for that Service Account in Google Cloud Console).

The steps for each use case are detailed below.

1. (If you already have a Firebase project for your app, continue to the next step.) Create a new Firebase project for your app in the [Firebase Console](https://console.firebase.google.com)

[<img src="./assets/creating-google-service-account/fcm-v1/new-service-account/01-new-firebase-project.png" width="800" />](./assets/creating-google-service-account/fcm-v1/new-service-account/01-new-firebase-project.png)

2. In the Firebase console, open Settings > [Service Accounts](https://console.firebase.google.com/project/_/settings/serviceaccounts/adminsdk) for your project

[<img src="./assets/creating-google-service-account/fcm-v1/new-service-account/02-manage-service-accounts.png" width="800" />](./assets/creating-google-service-account/fcm-v1/new-service-account/02-manage-service-accounts.png)

3. Click **Generate New Private Key**, then confirm by clicking **Generate Key**. Securely store the JSON file containing the private key.

[<img src="./assets/creating-google-service-account/fcm-v1/new-service-account/03-generate-key.png" width="800" />](./assets/creating-google-service-account/fcm-v1/new-service-account/03-generate-key.png)

4. Upload the JSON file to EAS and configure it for sending Android notifications. This can be done in EAS CLI or via [expo.dev](https://expo.dev).

- using EAS CLI: run `eas credentials` → choose `Android` → choose `production` → choose `Google Service Accounts` → choose `FCM v1`
- using [expo.dev](https://expo.dev): navigate to the [credentials page](https://expo.dev/accounts/[account]/projects/[project]/credentials) for your project → click on the Android application ID → find the section entitled "FCM v1 service account key" → click **Add a service account key** → upload your JSON credential and click **Save**

[<img src="./assets/creating-google-service-account/fcm-v1/new-service-account/04-upload-credential-1.png" width="800" />](./assets/creating-google-service-account/fcm-v1/new-service-account/04-upload-credential-1.png)
[<img src="./assets/creating-google-service-account/fcm-v1/new-service-account/04-upload-credential-2.png" width="800" />](./assets/creating-google-service-account/fcm-v1/new-service-account/04-upload-credential-2.png)
[<img src="./assets/creating-google-service-account/fcm-v1/new-service-account/04-upload-credential-3.png" width="800" />](./assets/creating-google-service-account/fcm-v1/new-service-account/04-upload-credential-3.png)

5. You're all set! You can now send notifications to Android devices via the Expo push notification service using the FCM v1 protocol.
   [<img src="./assets/creating-google-service-account/fcm-v1/new-service-account/05-upload-credential-complete.png" width="800" />](./assets/creating-google-service-account/fcm-v1/new-service-account/05-upload-credential-complete.png)

### Using an existing Google Service Account Key to Send Android Notifications using FCM v1

1. Open the [IAM Admin page](https://console.cloud.google.com/iam-admin/iam?authuser=0) in Google Cloud Console. In the Permissions tab, locate the Principal you intend to modify and click the pencil icon for **Edit Principal**.

[<img src="./assets/creating-google-service-account/fcm-v1/existing-service-account/01-iam-admin-page.png" width="800" />](./assets/creating-google-service-account/fcm-v1/existing-service-account/01-iam-admin-page.png)

2. Click **Add Role** and select the `Firebase Messaging API Admin` role from the dropdown. Click **Save**.

[<img src="./assets/creating-google-service-account/fcm-v1/existing-service-account/02-add-role-1.png" width="800" />](./assets/creating-google-service-account/fcm-v1/existing-service-account/02-add-role-1.png)
[<img src="./assets/creating-google-service-account/fcm-v1/existing-service-account/02-add-role-2.png" width="800" />](./assets/creating-google-service-account/fcm-v1/existing-service-account/02-add-role-2.png)
[<img src="./assets/creating-google-service-account/fcm-v1/existing-service-account/02-add-role-3.png" width="800" />](./assets/creating-google-service-account/fcm-v1/existing-service-account/02-add-role-3.png)

3. Tell EAS which JSON credential file to use for sending FCM v1 notifications, either via EAS CLI or the [expo.dev](https://expo.dev) website. You can upload a new JSON file or select a previously uploaded file.

- using EAS CLI: run `eas credentials` → choose `Android` → choose `production` → choose `Google Service Accounts` → choose `FCM v1`
- using [expo.dev](https://expo.dev): navigate to the [credentials page](https://expo.dev/accounts/[account]/projects/[project]/credentials) for your project → click on the Android application ID → find the section entitled "FCM v1 service account key" → click **Add a service account key** → upload your JSON credential and click **Save**

[<img src="./assets/creating-google-service-account/fcm-v1/existing-service-account/03-upload-credential-1.png" width="800" />](./assets/creating-google-service-account/fcm-v1/existing-service-account/03-upload-credential-1.png)
[<img src="./assets/creating-google-service-account/fcm-v1/existing-service-account/03-upload-credential-2.png" width="800" />](./assets/creating-google-service-account/fcm-v1/existing-service-account/03-upload-credential-2.png)
[<img src="./assets/creating-google-service-account/fcm-v1/existing-service-account/03-upload-credential-3.png" width="800" />](./assets/creating-google-service-account/fcm-v1/existing-service-account/03-upload-credential-3.png)

4. You're all set! You can now send notifications to Android devices via the Expo push notification service using the FCM v1 protocol.
   [<img src="./assets/creating-google-service-account/fcm-v1/existing-service-account/04-upload-credential-complete.png" width="800" />](./assets/creating-google-service-account/fcm-v1/existing-service-account/04-upload-credential-complete.png)
