# Evaluating app config on EAS Build workers

Part of the build process on EAS Build is evaluation of the content of **app.json/app.config.js** file. In some cases, if the project is misconfigured, the resulting config object may contain incorrect values e.g. the build is running under project A, but `extra.projectId` refers to project B.


### Building from EAS CLI

When building from EAS CLI we are using both environment variables from your local environment and values from **eas.json**, but on the EAS Build worker only values from **eas.json** and EAS Secrets will be present. It's common to use dynamic app config (**app.config.js/app.config.ts**) to switch between different configuration based on environment variables. When building on EAS, users need to make sure that environment on the EAS Build will match what was set locally.

If you have **app.config.js**:

```js
let projectId;
if (process.env.APP === 'app1') {
  projectId = '23847707-bf15-424c-b1dc-7a57fc34a23d';
} else if (process.env.APP === 'app2') {
  projectId = 'db096609-2c67-431d-b83d-88cabf8511b1';
}
export default {
  name: 'testapp',
  slug: process.env.APP
  extra: {
    projectId,
  }
}
```

It's not correct to run `APP=app1 eas build --profile production` where **eas.json** is:

```json
{
  "build": {
    "production": {}
  }
}
```


Instead you should run `eas build --profile production-app1` where **eas.json** is:

```json
{
  "build": {
    "production-app1": {
      "env": {
        "APP": "app1"
      }
    },
    "production-app2": {
      "env": {
        "APP": "app2"
      }
    }
  }
}
```

> NOTE: The above advice only applies to the build command and other commands that accept the build profile as a parameter — for other commands that run entirely locally, you will still need to pass environment variable in the cli e.g. `APP=app1 eas update`.


### Building from GitHub (manual builds triggered from expo.dev website)

When running builds from GitHub there is no local environment that might cause inconsistencies, but it's still possible that you might connect a repository to the wrong EAS project or misconfigure a connection to multiple projects.

If you are connecting single GitHub repository to multiple EAS projects you need to make sure that the `projectId`/`slug`/`owner` all match the correct value for a project that build is executed on.

Example configuration could look like this:

- **app.config.js**

```js
let projectId;
if (process.env.APP === 'app1') {
  projectId = '23847707-bf15-424c-b1dc-7a57fc34a23d';
} else if (process.env.APP === 'app2') {
  projectId = 'db096609-2c67-431d-b83d-88cabf8511b1';
}
export default {
  name: 'testapp',
  slug: process.env.APP
  extra: {
    projectId,
  }
}
```

- **eas.json**

```json
{
  "build": {
    "production-app1": {
      "env": {
        "APP": "app1"
      }
    },
    "production-app2": {
      "env": {
        "APP": "app2"
      }
    }
  }
}
```


With above configuration you can only start GitHub builds for `app1` with profile `production-app1` and for `app2` with profile `production-app2`. Any other combination would start a build for one project while embedding wrong projectId inside the resulting app.

This example configures different projects on the same account depending on the build profile, but you can also use this pattern to build an app from the same repository on different accounts, by conditionally setting owner value.
