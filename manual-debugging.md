# How to narrow down the source of an error: a step by step guide to good old fashioned manual debugging

You’re stuck. You keep getting an error and you have no idea why. Debugging tools have failed you. Error messages are vague and unhelpful. Ideally your development tools would help you out, but right now they’re just not giving you what you need. Google yields no helpful results. You don’t know how to proceed. Should you quit software development? Should you copy and paste the error message into StackOverflow, forums, Twitter, Slack, Discord, and every other resource you can think of? Not yet! First, let’s find exactly what lines of code are the perpetrators of this crime.

## 1. Verify that you can run your app on a previously working commit

First, you should find out if you can get an old version of your code working. Save your current changes to a branch, then check out the last known working commit. Reinstall your dependencies and clear out anything from your git index if it’s dirty (maybe some leftover files from some work you were doing before that you didn’t want to commit, for example).

Ok, does that work? It should, because modern package managers like npm and yarn both include lockfiles and so you should be installing the exact same versions of your dependencies, and git is pretty good at ensuring that your code is the same as you left it when you committed it.

If it does not work, it’s time to debug your system environment or an external service. Did you change versions of any software recently? Did you change the redirect URI on your OAuth provider endpoint? Did you sign in to a different account in your development tool? Your gut reaction will be to say “no” - you’re frustrated and looking for something external to blame, I know this very well because this is often me. Fight that and take a step back and verify anything that seems relevant. Maybe you updated to a new version of Node, npm, or yarn, or maybe you installed a new version of a CLI tool.

You know at this point that the issue is not with the code in your project, but you may still find the “disassemble and reassemble” section below to be useful to trace it further if you’re not sure where to look.

## 2. Narrow down the specific changes that cause your error

If you were able to get a previously working commit running, then you can pat yourself on the back because your project is working again. It’s comforting to know that at the end of the day you can always go back to this state.

But that is often not so helpful, because presumably you had made some changes that you wanted. So we have two options for how to proceed now: incrementally add or remove changes, or disassemble reassemble. Over time and repeated application, you’ll get an intuition for which situations are best suited for a particular approach. Regardless of the strategy, you should always be able to identify the specific changes that cause the error. You may not understand the root cause, but this information is vital for your next research steps and for getting help or reporting a bug if needed.

### Incrementally and or remove changes

Incrementally introducing changes by finding some small chunk of code in your diff and adding it to your app and then loading your app and ensuring it still works. You will have to use some judgement to determine what order you should try introducing changes in to try to keep things working at each step. At some point, you should hit the exact same error as before. If the last change you applied was big enough that you’re not exactly sure what line(s) caused the error, then undo the change and add it back line-by-line until you see the error again. You now have some incredibly useful information for reproducing the error. If you can’t figure out what is wrong with your app from this, then certainly someone will be able to help you when you file an issue.

Incrementally removing changes is the same approach but done in reverse. Check out your branch and reproduce the error. Now, slowly roll back changes piece by piece until you no longer see the error message.

### Disassemble and reassemble

If incrementally adding or removing changes isn’t working for you, we can use a slightly different approach: disassemble your app until it’s working again, then add back pieces until you see the error. For a concrete example of how you might do this, imagine that every time you start your app you get a red screen error, and you’re at a loss for how to figure out where that is coming from.

One way to proceed here is to remove everything from App.js except the minimal amount of code you need for “Hello, world!”. Then add it back bit by bit. As you do this, you may find that a specific import causes the error. Go into that file and apply this same technique: remove as much as you need to in order for it to run again without errors, then add back code as needed. Repeat this process until you know the precise lines of code that cause the error.

If you’re unable to even get a simple “Hello, world” app running, then you can start from scratch to identify the cause. Initialize a new project, and copy your source over to the new project directory in small chunks, keeping the project working along the way. Note that if a brand new project produces the same error as your existing project, then you can be confident that the issue lies in system configuration.

## 3. What to do after you know what specific changes cause your error

You now have some a line or a few lines of code that you know for certain are baddies. In most cases, you will probably quickly be able to identify why that is the case. If not, you will likely need to double check your understanding of the code in the appropriate documentation.

If you’re not sure whether you understand the code well enough to say whether it’s a bug or expected behavior, then open an issue to ask for clarification in the documentation. Include the code in question, explain what you expect to be happening, and what the result is.

If you are certain that what you have found is a bug, then it’s time to go about creating a new repository that reproduces the issue without any other extraneous code or dependencies. This is often called a MCVE - a Minimal, Reproducible Example: https://stackoverflow.com/help/minimal-reproducible-example. If you are unable to reproduce the problem in a new repository, you have gained some more valuable information, and you can compare the configuration of your app and the MCVE attempt to see where they differ, and adjust accordingly.