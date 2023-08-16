# Unverified Badge in Expo Go

When a project is run in Expo Go during development, EAS tries its best to sign the code and assets to ensure that a bad actor cannot impersonate your project and to ensure that all projects running in Expo Go can only access their own data.

When EAS is unable to sign your running project, Expo Go still launches the application and isolates the data from other applications, but to do so it uses a random key rather than the one stored on the EAS server and shows a badge in the developer menu. This can happen when developing offline or when a project has not yet been set up on EAS. You may notice things like data loss between runs.