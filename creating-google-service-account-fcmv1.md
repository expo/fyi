# Uploading a Google Service Account Key for Android notifications via FCM v1

> **Note:** Beginning in June 2024, all Android notifications must be sent using the FCM v1 protocol.

A Google Service Account Key is a credential in the form of a JSON file that you can obtain via Google Cloud for a particular Google Service Account.

EAS requires a Google Service Account Key to be uploaded and configured for sending Android push notifications via `https://exp.host/--/api/v2/push/send` using the FCM v1 protocol.

> You can configure separate Google Service Account Keys for [Play Store Submissions](/creating-google-service-account.md) and sending Android Push notifications with FCM v1 protocol or you can upload a single Google Service Account Key and use it for both use cases (provided that the correct authorizations are in place for that Service Account in Google Cloud Console).

To learn how to **create a new Google Service Account Key** or **use an existing one**, see [Add Google Service Account Keys using FCM V1](https://docs.expo.dev/push-notifications/fcm-credentials/) guide for more details.
