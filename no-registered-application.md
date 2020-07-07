You have stumbled upon a very frequent source of errors - something went wrong before we were able to start your application. 

This often means that we tried to load your application JavaScript code and it threw an error before we could render the root component. There are an infinite number of reasons why this may happen, so we can't give you an exact set of steps to resolve the issue. You should refer to the red screen that you likely see in your application for a hint towards what the issue may be in your case.

Some common reasons for this type of error:

- Multiple versions of a JavaScript package that includes native dependencies. You may see an error like "Invariant violation: Tried to register two views with the same name ....." if this is the case.
- The entry point of your application was modified and you are calling `AppRegistry.registerComponent` manually, rather than depending on the default app entry configuration. You should use [registerRootComponent](https://docs.expo.io/versions/latest/sdk/register-root-component/) instead of `AppRegistry`.
- A runtime error occurred in your code before mounting the application, for example `JSON.parse(undefined);` will throw an exception, and any code that does this at the top level of your application code will lead to this situation.

To resolve the issue, follow the debugging instructions that we provided in the [debugging documentation](https://docs.expo.io/workflow/debugging/#development-errors).
