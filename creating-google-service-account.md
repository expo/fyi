# Uploading a Google Service Account Key for Play Store Submissions with EAS

A Google Service Account Key is a credential in the form of a JSON file that you can get via Google Cloud for a particular Google Service Account.

**EAS requires you to upload and configure a Google Service Account Key** to submit your Android app to the Google Play Store with `eas submit`.

> [!NOTE]
> Beginning in June 2024, all Android notifications must be sent using the FCM v1 protocol. EAS requires a Google Service Account Key to be uploaded and configured for sending Android push notifications via `https://exp.host/--/api/v2/push/send` using the FCM v1 protocol. You can configure separate Google Service Account Keys for Play Store Submissions and [sending Android Push notifications with FCM v1 protocol](https://docs.expo.dev/push-notifications/fcm-credentials/) or you can upload a single Google Service Account Key and use it for both use cases (provided that the correct authorizations are in place for that Service Account in Google Cloud Console).

## Setup Service Account Key

To set up a Google Service Account Key for Play Store Submissions via `eas submit`, the following steps are required:

- Create a Google Cloud project (optional if you already have one)
- Create a Google Service Account and create and download the JSON key file
- Enable the Google Play Android Developer API
- Invite the Google Service Account to your Google Play Console account

1. If you don't have a Google Cloud project yet, create one in the [Google Cloud Console](https://console.cloud.google.com/projectcreate). If you already have a project, skip this step.

[<img src="./assets/creating-google-service-account/01-new-google-cloud-project.png" width="800" />](./assets/creating-google-service-account/01-new-google-cloud-project.png)

2. Open [**Service Accounts**](https://console.cloud.google.com/iam-admin/serviceaccounts) in the Google Cloud Console and click **Create Service Account**.

[<img src="./assets/creating-google-service-account/02-service-accounts.png" width="800" />](./assets/creating-google-service-account/02-service-accounts.png)

3. Enter a name for your service account. We recommend a name that will make it easy for you to remember that it is for your Google Play Console account. Optionally, enter the service account ID and description of your choice. Click the **Done** button.

[<img src="./assets/creating-google-service-account/03-create-service-account.png" width="800" />](./assets/creating-google-service-account/03-create-service-account.png)

4. From **Service Accounts**, copy the email ID for your account. You will need this in _step 8_.

[<img src="./assets/creating-google-service-account/12-copy-service-account-email.png" width="800" />](./assets/creating-google-service-account/12-copy-service-account-email.png)

5. Select **Manage keys** from the options button, then **Create new key**. Choose **JSON** and then click **Create**. Download the **.json** file and store it in a safe place.

[<img src="./assets/creating-google-service-account/04-manage-keys.png" width="800" />](./assets/creating-google-service-account/04-manage-keys.png)
[<img src="./assets/creating-google-service-account/05-create-new-key.png" width="800" />](./assets/creating-google-service-account/05-create-new-key.png)
[<img src="./assets/creating-google-service-account/06-key-type.png" width="800" />](./assets/creating-google-service-account/06-key-type.png)
[<img src="./assets/creating-google-service-account/07-key-saved.png" width="800" />](./assets/creating-google-service-account/07-key-saved.png)

6. Open the [Google Play Android Developer API](https://console.cloud.google.com/apis/library/androidpublisher.googleapis.com) and click **Enable**.

[<img src="./assets/creating-google-service-account/08-play-developer-api.png" width="800" />](./assets/creating-google-service-account/08-play-developer-api.png)

7. In the Google Play Console, open the [**Users and permissions**](https://play.google.com/console/users-and-permissions) and click **Invite new users**.

[<img src="./assets/creating-google-service-account/09-users-permissions.png" width="800" />](./assets/creating-google-service-account/09-users-permissions.png)

8. Enter the email address of the service account you created in _step 4_. On the **App permissions** tab, select your app(s). If you want to apply the permissions to all apps, you can also select the permissions on the **Account permissions** tab instead.

[<img src="./assets/creating-google-service-account/10-invite-user.png" width="800" />](./assets/creating-google-service-account/10-invite-user.png)

9. Select the following required permissions to upload and manage your app, and click **Invite user**.

[<img src="./assets/creating-google-service-account/11-set-permissions.png" width="800" />](./assets/creating-google-service-account/11-account-permissions.png)

10. Now you can upload your newly created Google Service Account Key to EAS servers and upload your app's release archive to Google Play Store using `eas submit`.

## Download key from an existing service account

If you have already created a Google Service Account, you can create a new **JSON** key and download it.

1. Open [Google Cloud Console](https://console.cloud.google.com/) and select your project.

2. From the sidebar, click **Service Accounts** > click the existing service account **Email**.

[<img src="./assets/creating-google-service-account/13-select-existing-service-account.png" width="800" />](./assets/creating-google-service-account/13-select-existing-service-account.png)

3. Click **Keys** > **ADD KEY** > **Create new key**.

[<img src="./assets/creating-google-service-account/14-create-new-key.png" width="800" />](./assets/creating-google-service-account/14-create-new-key.png)

4. Under **Key type**, make sure **JSON** is selected, and click **Create**.

[<img src="./assets/creating-google-service-account/15-select-json-key-type.png" width="800" />](./assets/creating-google-service-account/15-select-json-key-type.png)

5. A **.json** file will download on your computer. You can repeat _steps 7 to 10_ from the previous section to use this downloaded key.

[<img src="./assets/creating-google-service-account/16-service-key-created.png" width="800" />](./assets/creating-google-service-account/16-service-key-created.png)

## Further reading

To learn more about how to use `eas submit` to create an internal test or a production release archive, or automate subsequent releases to Google Play Store with `--auto-submit` flag, see [Android Production build](https://docs.expo.dev/tutorial/eas/android-production-build/) chapter in the EAS Tutorial.

For managing multiple service account keys, see Google's documentation on [Best practices for using service accounts](https://cloud.google.com/iam/docs/best-practices-service-accounts).
