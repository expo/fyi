# GitHub Enterprise Server integration

To connect Expo projects to GitHub Enterprise Server repositories, you need to first connect your Expo account to a GitHub App on your GitHub Enterprise Server instance as described below.

1. Navigate to **Account Settings** on [expo.dev](https://expo.dev) and scroll to the **GitHub Enterprise** section. Click **Register**, enter the URL of your GitHub Enterprise Server instance and, optionally, the GitHub organization to register the app under. Leave the organization blank to register the app under your own GitHub account. Click **Register on GitHub Enterprise**.

[<img src="./assets/github-enterprise/01-account-settings-form.png" width="800" />](./assets/github-enterprise/01-account-settings-form.png)

2. You are redirected to your GitHub Enterprise Server instance. Confirm the app name and click **Create GitHub App**.

[<img src="./assets/github-enterprise/02-register-github-app.png" width="800" />](./assets/github-enterprise/02-register-github-app.png)

3. GitHub redirects you back to your account settings on Expo. The **GitHub Enterprise** section should show that the app is registered.

[<img src="./assets/github-enterprise/03-account-settings.png" width="800" />](./assets/github-enterprise/03-account-settings.png)

4. Navigate to **Project Settings > GitHub**. If a github.com account is already connected, open the **GitHub account** dropdown and select **Connect _your-instance_**.

[<img src="./assets/github-enterprise/04-project-settings.png" width="800" />](./assets/github-enterprise/04-project-settings.png)

If no GitHub account is connected yet, click **Connect _your-instance_ instead**.

[<img src="./assets/github-enterprise/05-project-settings-alt.png" width="800" />](./assets/github-enterprise/05-project-settings-alt.png)

5. Your GitHub Enterprise Server account should appear in the **GitHub account** dropdown, so you can now select a repository to connect.

[<img src="./assets/github-enterprise/06-project-settings-connected.png" width="800" />](./assets/github-enterprise/06-project-settings-connected.png)
