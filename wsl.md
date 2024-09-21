# Running a local Expo development environment in Windows Subsystem for Linux (WSL)

You can use Expo tools in Windows via the Powershell terminal, but many developers appreciate being able to develop in a Linux environment via Windows Subsystem for Linux (WSL).

WSL 2 enables Windows users to run a full Linux environment alongside their Windows applications. As Expo tools support Linux, they can run inside of WSL. The primary challenge with using Expo tools inside of WSL is that WSL is a virtual machine with its own separate IP address internal to your machine, and the Expo CLI runs a development server that you may want to connect to via a development build running on a mobile device on your local network.

This guide provides steps on how to configure WSL so the Expo CLI's dev server is accessible from your LAN even when running in WSL, as it would be if you were running Linux or another operating system directly.

## Recommended setup

These instructions may work with other Linux distributions, text editors, and so on. However, this setup is well-documented by Microsoft, and we have been able to successfully configure WSL 2 to work well with Expo local development under these conditions.

- WSL 2 is installed on Windows 11 using the default Linux distribution (Ubuntu):
  - [Follow Microsoft's guide for installing WSL](https://learn.microsoft.com/en-us/windows/wsl/install)
- Your WSL environment is setup to use a supported LTS version of Node.js and Git:
  - [Follow Microsoft's guide for using Node.js in WSL](https://learn.microsoft.com/en-us/windows/dev-environment/javascript/nodejs-on-wsl). If you install a Node version manager as they recommend, set up a **.nvmrc** in your project or set a default version (for example, `nvm alias default 18`).
  - [Follow Microsoft's guide for using Git in WSL](https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-git)
- Visual Studio Code installed in Windows with the [WSL Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl):
  - [Follow Microsoft's guide for using Visual Studio Code with WSL](https://code.visualstudio.com/docs/remote/wsl)
- [Windows Terminal](https://apps.microsoft.com/detail/9N0DX20HK701?hl=en-US&gl=US) is installed

## Important: Your Expo project must be entirely on the Linux filesystem

Your Windows and WSL environments each have their own filesystems, and it is possible to interact with files on the Windows side from the WSL terminal prompt. However, once you are using WSL, your Expo project needs to exist on the Linux filesystem, and any source control operations must be performed via the Linux version of git.

To start a new Expo project in WSL, open Windows Terminal, open a WSL tab, and run `npx create-expo-app`. If you're working with an existing Expo project committed to a git repo, run `git clone` from a WSL terminal tab.

If you use Visual Studio Code with the WSL extension and do all your git interactions via Visual Studio Code's git integration, Visual Studio Code will detect that the project files are on the Linux filesystem and will open the appropriate terminal and use the Linux git installation. While Visual Studio Code is a Windows app, in this scenario, it is effectively remoting into the WSL Linux environment to perform these operations.

### Warning signs that you're probably mixing Windows and Linux:

- You run `pwd` and you see paths that start with `/mnt`.
- You are in a WSL prompt interacting with a project that you originally cloned with GitHub Desktop for Windows.

## Running your Expo project in WSL with no additional config

If you have completed the setup above, `npx expo start` should work in a WSL terminal. You can even run the web version in your browser at this point. However, you will not yet be able to connect to a development build.

Notice that the development server URL / QR code starts with a `172.x` IP address, while normally you would expect an IP address on your LAN (192.168.x, typically). This IP address is internal to your machine, an address on the private network of which your Linux VM inside the WSL environment is a part of. By default, this IP address is not accessible outside of your machine. Therefore, mobile devices running development builds cannot connect the dev server, even if those devices are on your LAN.

One zero-config workaround is to run `npx expo start --tunnel`. This will install ngrok and forward your development server to a publicly-accessible web address. However, this is slower to refresh, so it would be ideal if we could connect to the development server from the LAN.

## Connecting to an Expo dev server running from WSL (LAN-compatible)

To make Expo work from WSL just like it would on any other machine connected directly to your LAN, we need to forward traffic from the WSL virtual machine to the host Windows environment

### Forwarding traffic from the WSL VM

WSL 2 now supports a dedicated "mirrored" mode that will forward traffic from WSL to Windows. This is the easiest way to enable outside connections to your local development environment.

> Be sure to update to the latest WSL version to ensure that mirrored mode is supported.

#### Enable mirrored mode

To enable mirrored mode, add/update the **.wslconfig** file in your **%USERPROFILE%** directory (usually **c:/Users/[username]**):

```
[wsl2]
networkingMode=mirrored
```

WSL will need to shut down and restart for this setting to take effect. You can see if WSL is still running by opening a Powershell terminal and running:

```
wsl --list
```

If any are still open, run `wsl --shutdown` and reopen a WSL terminal (via Windows Terminal or VS Code) to restart WSL.

> [!TIP]
> If mirrored mode is configured correctly, when you run `npx expo start` in your project, the IP address for the QR code should match the IP address you would see if you ran `ipconfig` in PowerShell. If you see a `172.x.x.x` IP address in your WSL terminal, mirrored mode is likely not configured correctly.

#### Opening up the Hyper-V firewall

On recent Windows/WSL updates, you may also need to open up inbound connections on the Hyper-V firewall. [Microsoft documents a few options for this](https://learn.microsoft.com/en-us/windows/wsl/networking#mirrored-mode-networking). One option is to right-click on Windows Terminal in the Start menu, click "Open as Administrator", open a Powershell tab, and run the following command:

```
Set-NetFirewallHyperVVMSetting -Name ‘{40E0AC32-46A5-438A-A0B2-2B479E8F2E90}’ -DefaultOutboundAction Allow
```

> [!TIP]
> To test the firewall configuration, run `npx expo start` from your project and scan the QR code with your mobile device to run in either Expo Go or a development build. If you only see a blue spinner on your device, and do not see the bundling process begin in the tutorial, it's likely that this firewall change did not take effect. You can try running the above command again, consult Microsoft's documentation, or open the Firewall settings from the Start Menu to investigate further.

These commands may change with software updates. If this does not work, check [Microsoft's documentation](https://learn.microsoft.com/en-us/windows/wsl/networking#mirrored-mode-networking).

> If you do not want to enable mirrored mode, it is also possible to [setup per-port forwarding of traffic from WSL to Windows manually](https://learn.microsoft.com/en-us/windows/wsl/networking#accessing-a-wsl-2-distribution-from-your-local-area-network-lan).

## Using the JS Debugger

We are currently looking into an [issue](https://github.com/expo/expo/issues/23678) with opening the browser for the debugger from WSL. In the meantime, you can run still debug from WSL by installing Chrome or another compatible browser inside the WSL Linux environment and patching the Expo CLI to force it to open the Linux-based browser when running in WSL instead of the Windows browser:

1. Install Chrome or another compatible browser in the Linux environment, using [Microsoft's instructions for installing GUI apps in WSL](https://learn.microsoft.com/en-us/windows/wsl/tutorials/gui-apps) as a guide.
2. Use `patch-package` to remove the `IS_WSL` condition [as described here](https://github.com/expo/expo/issues/23678#issuecomment-1699253619).
