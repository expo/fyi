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