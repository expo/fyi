# expo.fyi

**tl;dr:** it's a tool to link people to markdown files in [https://github.com/expo/fyi](https://github.com/expo/fyi) with a concise and pretty link, eg: [https://expo.fyi/bundle-identifier](https://expo.fyi/bundle-identifier) 

## **What is it?**

This website is a useful URL shortener that users to a markdown file on the [https://github.com/expo/fyi](https://github.com/expo/fyi) repository. For example, [https://expo.fyi/bundle-identifier](https://expo.fyi/bundle-identifier) will redirect the user to [https://github.com/expo/fyi/blob/master/bundle-identifier.md](https://github.com/expo/fyi/blob/master/bundle-identifier.md).

It is useful to remove any friction to creating a shareable link to a persistent explanation of some piece of knowledge that is useful to developers using Expo tools.

## Why might I want to use this?

Imagine that you're working on expo-cli and want to add more context on some terminology that you are using in a prompt to the user. Maybe you need to ask them for a "bundle identifier". You want to make sure that the user has easy access to more information about what that means, but you don't want to inline a whole explanation of it and crowd the interface. At the same time, you can't be bothered to create a docs page for this, or maybe the existing docs page doesn't provide the most relevant context for the situation the user is in. That's understandable. So instead let's just create a FYI!

## How do I create a FYI?

- Go to [https://github.com/expo/fyi](https://github.com/expo/fyi)
- Click "Create a new file"
- Pick a name for it and include the `.md` extension. If you are teaching people about the "tunnel" connection type in expo-cli, maybe you would call it `[tunnel-connection.md](http://tunnel-connection.md)` and then the url would be [https://expo.fyi/](https://expo.fyi/bundle-identifier)tunnel-connection

## 💡**FYI**

- You can add any arbitrary string like `this-does-not-exist` to the URL and it will just bring you to the GitHub 404 pages: [https://expo.fyi/this-does-not-exist](https://expo.fyi/this-does-not-exist). You probably do not want to do this, so instead create a file and link to it, and don't delete the file if it's linked to from somewhere already.
- If you go to [https://expo.fyi](https://expo.fyi) it will just redirect you to the GitHub repo
- You can create your own domain like this by cloning [https://github.com/expo/expo-fyi](https://github.com/expo/expo-fyi) - a small service that you can deploy to now.sh. Customize the URLs it uses in [index.js](https://github.com/expo/expo-fyi/blob/master/index.js).
