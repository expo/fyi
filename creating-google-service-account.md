# Creating Google Service Account

If you'd like to submit your Android app to Google Play Store with `expo upload:android` you need to create a Google Service Account key. This page will guide you through this process.

1. Open [Google Play Console](https://play.google.com/apps/publish/) and go to the **Settings** tab.

[<img src="./assets/creating-google-service-account/01-open-google-play-console.png" width="800" />](./assets/creating-google-service-account/01-open-google-play-console.png)

2. Choose **API access** from the sidebar. If you see a message saying API access is not enabled for your account, you must first link your Google Play developer account with a Google Developer Project. On this page, either link it to an existing project if you have one, or click **CREATE NEW PROJECT** to link with a new one.

[<img src="./assets/creating-google-service-account/02-api-access.png" width="800" />](./assets/creating-google-service-account/02-api-access.png)

3. Click **CREATE SERVICE ACCOUNT** and follow the Google API Console link in the dialog.

[<img src="./assets/creating-google-service-account/03-service-account-dialog.png" width="800" />](./assets/creating-google-service-account/03-service-account-dialog.png)

4. Click another **CREATE SERVICE ACCOUNT** button.

[<img src="./assets/creating-google-service-account/04-google-cloud-platform.png" width="800" />](./assets/creating-google-service-account/04-google-cloud-platform.png)

5. Enter the name of this service account in the field titled "Service account name". We recommend a name that will make it easy for you to remember that it is for your Google Play Console account. Also, enter the service account ID and description of your choice. Click the **CREATE** button.

[<img src="./assets/creating-google-service-account/05-service-account-name.png" width="800" />](./assets/creating-google-service-account/05-service-account-name.png)

6. Click **Select a role** and choose **Service Accounts > Service Account User**. Submit the form.

[<img src="./assets/creating-google-service-account/06-service-account-permissions.png" width="800" />](./assets/creating-google-service-account/06-service-account-permissions.png)

7. Click **CREATE KEY**, choose **JSON** and then the **CREATE** button. Download the `.json` file and store it in a safe place.

[<img src="./assets/creating-google-service-account/07-create-key.png" width="800" />](./assets/creating-google-service-account/07-create-key.png)
[<img src="./assets/creating-google-service-account/08-create-json-key.png" width="800" />](./assets/creating-google-service-account/08-create-json-key.png)

8. Return to the **API access page** on the Google Play Console and ensure it shows your new service account. Click on **GRANT ACCESS** for the newly added service account.

[<img src="./assets/creating-google-service-account/09-grant-access.png" width="800" />](./assets/creating-google-service-account/09-grant-access.png)

9. Choose **Release Manager** and then **ADD USER**.

[<img src="./assets/creating-google-service-account/10-add-user-modal.png" width="800" />](./assets/creating-google-service-account/10-add-user-modal.png)

10. That's all! From now on, you can use the generated Google Service Account to upload your app with `expo upload:android`.
