# "It's not working"

The words "not working" are a ["smell"](https://en.wikipedia.org/wiki/Code_smell) in issue reports. If the best you can do when reporting an issue is to say "it's not working", you either haven't done the work required to understand the issue properly, or you haven't explained yourself well enough. Unless your goal is to play a round of [20 questions](https://en.wikipedia.org/wiki/Twenty_questions), you might want to reconsider your approach, especially if you're asking for someone else's time and expertise.

Let's look at an example.

> I recently migrated my app to SDK 50 and deep linking is not working for some users. Has anyone run into this issue? Very strange. I wasted 2 days on it.

- What do you mean by "not working"? Does the app not open? Do you not receive the deep link params? If the latter, what do you receive instead? What are you trying to do exactly and what precisely is not happening as expected?
- What do you mean by "deep linking"? Are you referring to universal links / app links, custom URL schemes, launching the app via notifications, or something else?
- What platform is this happening on? iOS or Android?
- Have you been able to reproduce it? If so, what steps can we take to reproduce the issue? If not, what have you tried?
- Are there any error messages? Do you have any debug logs?

The more context you provide, the easier it is for someone to help you. If you're not sure what information is relevant, provide as much as you can and someone will ask for more if needed.

## Additional resources

- [How to ask good questions](https://stackoverflow.com/help/how-to-ask)
- [How to create a Minimal, Reproducible Example](https://stackoverflow.com/help/minimal-reproducible-example)
- [How to narrow down the source of an error: a step by step guide to good old fashioned manual debugging](https://expo.fyi/manual-debugging)