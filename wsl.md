## Prereqs
- WSL2 setup on Windows 11
- Using Ubuntu
- Chrome installed
- Visual Studio Code installed

## Steps
1. Install a Node environment on WSL. When done, you should have:
- Windows Terminal
- Node.js, NVM, and NPM installed

If you setup NVM, but you're just doing Expo projects, this helps:
```
nvm install 18
nvm alias default 18
```

2. Setup Visual Studio Code
- Install Visual Studio Code
- Install the WSL extension: https://code.visualstudio.com/blogs/2019/09/03/wsl2

3. Setup Git
- Follow the directions here: https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-git
- Install git on Linux
- Install git on Windows
- Setup Git credential manager

Goal:
- Visual Studio Code should be this shell where everything happens on Linux, in the Linux filesystem and with the Linux git instance.

4. Create or clone a project
- Open an Ubuntu tab in Windows terminal
- Run `npx create-expo-app`
- Run `code my-app`

It'll work. You can open it in web and it'll open in your Windows Chrome browser. But it'll send you a 172.x IP

5. Setup a PowerShell script to open up the Expo ports from Linux to Windows

This script: https://gist.github.com/kendallroth/1f4871febffa0577338214f58673cc1a#file-forward_wsl2_ports-ps1
(consider adding additional ports for additional instances, e.g. 8082)

Save it to a wsl2_ports.ps1 file

Open Windows Terminal in Adminstrator mode, Open a PowerShell tab, and run:
`powershell -ExecutionPolicy Bypass -f C:\Users\keith\OneDrive\Desktop\wsl2_ports.ps1`

Goal:
- In theory, the ports forward, and you could manually type in your Windows IP address into Expo Go / Dev Build and it'd work. But, let's fix those QR codes.

6. Update Expo CLI QR codes
- Add a script to your project's package.json:
```
"start:wsl": "REACT_NATIVE_PACKAGER_HOSTNAME=$(netsh.exe interface ipv4 show addresses 'Wi-Fi' | awk -F'IP Address:' '{print $2}') expo start",
```

This should update your packager hostname to your Windows IP address, instead of the WSL VM IP address. You may need to fiddle with this slightly, as it is grepping your Windows IF config for your network adapter.

You can extract that inner command and test it in Windows Terminal (Ubuntu) until you get it right. I had to change the network adapter name.

TODO: I think this would go better in .bashrc, since it can change depending on the developer's machine.

7. Schedule the port opening to happen on reboot
- Open Windows task scheduler
- Add a task to run the script after log on
(see screenshots)

Other stuff:
Run the script:
```
powershell -ExecutionPolicy Bypass -f C:\Users\keith\OneDrive\Desktop\wsl2_ports.ps1 
```

-------
.wslconfig file

Write to %USERPROFILE%/.wslconfig

```
[wsl2]
networkingMode=mirrored
```

Open up the firewall (powershell):
```
 Set-NetFirewallHyperVVMSetting -Name ‘{40E0AC32-46A5-438A-A0B2-2B479E8F2E90}’ -DefaultOutboundAction Allow                
```

```
wsl --list
wsl --shutdown
```

-------

Debugging

LaunchBrowserImplWindows

isSupportedBrowser() errors with spawn powershell.exe ENOENT or whatever

workaround around that by commenting out `env`
but not sure if it was just that or that I added
`%SystemRoot%\system32\WindowsPowerShell\v1.0` to windows path

But that lead to crash with `spawn chrome ENOENT` 
at openWithSystemRootEnvironment

This could be related: https://github.com/sindresorhus/open/issues/198
But wslu didn't help

Removing IS_WSL (https://github.com/expo/expo/issues/23678) did work once I got Chrome for linux installed:
https://learn.microsoft.com/en-us/windows/wsl/tutorials/gui-apps

I had to do the missing packages thing, but with sudo

Also tried:
```
 /mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe --app="https://chrome-devtools-frontend.appspot.com/serve_rev/@d9568d04d7dd79269c5a655d7ada69650c5a8336/devtools_app.html?panel=console&ws=192.168.2.106%3A8081%2Finspector%2Fdebug%3Fdevice%3Da3b9654402cf71d316fe9793c4b89780a477bb9f%26page%3D-1" --allow-running-insecure-content --user-data-dir=C:\Users\keith\AppData\Local\Temp\expo-inspector --no-first-run --no-default-browser-check
```
and it opened the devtools window but didn't connect to anything