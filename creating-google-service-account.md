# Creating a Google Service Account

If you’d like to submit your Android app to Google Play Store with `eas submit` you need to create a Google Service Account key. To do this, the following steps are required:

- Create a Google Cloud project (optional if you already have one)
- Create a Google Service Account and create and download the JSON key file
- Enable the Google Play Android Developer API
- Invite the Google Service Account to your Google Play Console account

1. If you don't have a Google Cloud project yet, create one in the [Google Cloud Console](https://console.cloud.google.com/projectcreate). If you already have a project, you can skip this step.

[<img src="./assets/creating-google-service-account/01-new-google-cloud-project.png" width="800" />](./assets/creating-google-service-account/01-new-google-cloud-project.png)

2. Open the [Service Accounts page](https://console.cloud.google.com/iam-admin/serviceaccounts) in the Google Cloud Console and click **CREATE SERVICE ACCOUNT**.

[<img src="./assets/creating-google-service-account/02-service-accounts.png" width="800" />](./assets/creating-google-service-account/02-service-accounts.png)

3. Enter a name for your service account. We recommend a name that will make it easy for you to remember that it is for your Google Play Console account. Optionally, enter the service account ID and description of your choice. Click the **DONE** button.

[<img src="./assets/creating-google-service-account/03-create-service-account.png" width="800" />](./assets/creating-google-service-account/03-create-service-account.png)

4. On the newly created service account, select **Manage keys** from the options button, then **Create new key**. Choose **JSON** and then the **CREATE** button. Download the `.json` file and store it in a safe place.

[<img src="./assets/creating-google-service-account/04-manage-keys.png" width="800" />](./assets/creating-google-service-account/04-manage-keys.png)
[<img src="./assets/creating-google-service-account/05-create-new-key.png" width="800" />](./assets/creating-google-service-account/05-create-new-key.png)
[<img src="./assets/creating-google-service-account/06-key-type.png" width="800" />](./assets/creating-google-service-account/06-key-type.png)
[<img src="./assets/creating-google-service-account/07-key-saved.png" width="800" />](./assets/creating-google-service-account/07-key-saved.png)

5. Open the [Google Play Android Developer API](https://console.cloud.google.com/apis/library/androidpublisher.googleapis.com) page and click **ENABLE**.

[<img src="./assets/creating-google-service-account/08-play-developer-api.png" width="800" />](./assets/creating-google-service-account/08-play-developer-api.png)

6. In the Google Play Console, open the [Users & permissions](https://play.google.com/console/users-and-permissions) page and click **Invite new users**.

[<img src="./assets/creating-google-service-account/09-users-permissions.png" width="800" />](./assets/creating-google-service-account/09-users-permissions.png)

7. Enter the email address of the service account you created in step 3. On the **App permissions** tab, select your app(s). If you want to apply the permissions to all apps, you can also select the permissions on the **Account permissions** tab instead

[<img src="./assets/creating-google-service-account/10-invite-user.png" width="800" />](./assets/creating-google-service-account/10-invite-user.png)

8. Select the required permissions to upload and manage your app, and click **Invite user**

[<img src="./assets/creating-google-service-account/11-set-permissions.png" width="800" />](./assets/creating-google-service-account/11-account-permissions.png)

9. That's all! From now on, you can use the generated Google Service Account key to upload your app with `eas submit`.
