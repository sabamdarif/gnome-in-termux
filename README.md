
<center><img src="images/demo-gnome.png"></center>
<p align="center"><b>Easily Install Gnome Desktop in Termux</b></p>

<div align="center">

[![GitHub stars](https://img.shields.io/github/stars/sabamdarif/gnome-in-termux)](https://github.com/sabamdarif/modded-kali/stargazers)
[![GitHub issues](https://img.shields.io/github/issues/sabamdarif/gnome-in-termux)](https://github.com/sabamdarif/modded-kali/issues)

</div>

### Features:

- :speaker: Fixed Audio Output
- :globe_with_meridians: 2 Browsers (Chromium & Mozilla Firefox)
- :tv: VLC Media Player and MPV media player (VLC Fully work)
- :books: Easy To Setup
- :computer: Vnc Issue Fixed
- :hammer: Gnome Software Preinstalled
- :art: Install Ubuntu Full Gnome Version
- :books: And Much More

### Installation:

1. Firstly install [Termux](https://termux.com) apk from [HERE](https://f-droid.org/repo/com.termux_118.apk)
2. Secondly Install Any Debian Based Proot-distro & pulseaudio For Audio Working

   - `pkg install proot proot-distro pulseaudio -y`
   - `proot-distro install DISTRO-NAME`
   - `proot-distro login DISTRO-NAME`
   - `apt update`
   - `apt install wget -y`
   - `wget https://raw.githubusercontent.com/sabamdarif/gnome-in-termux/main/install-gnome-desktop`
   - `chmod +x install-gnome-in-termux`
   - `./install-gnome-in-termux`
   - Now Select **CORE** Or **FULL** Which You Want
<details>
<summary><b><code>DEMO IMAGES: </code></b></summary>

|CORE|FULL|
|--|--|
|![img](images/gnome-core-ubuntu.png)|![img](image/demo-full-ubuntu.png)|
</details>

3. **You have to note your VNC password !!**
4. **Now Restart Termux And Login Into Your Distro**
5. GNOME is now successfully installed. 👍
6. Install VNC VIEWER Apk on your Device. [Google Play Store](https://play.google.com/store/apps/details?id=com.realvnc.viewer.android&hl=en)
7. Or, Install NetHunter KeX from [Nethunter Store](https://store.nethunter.com/en/packages/com.offsec.nethunter.kex/)

8. Open VNC VIEWER & Click on + Button & Enter the Address `localhost:1` & Name anything you like
9. Set the Picture Quality to High for better Quality
10. Click on Connect & Input the Password
11. Enjoy :smile:

### NOTE:

- **Type `DISTRO-NAME` to login into DISTRO CLI.**
- **Type `vncstart` to run Vncserver**
- **Type `vncstop` to stop Vncserver**
- **Type `fixvnc` if the vnc server not star (for Android 12 users)**

### ISSUES:
- **1:-** *You Can Not Add Items In Desktop*
- **2:-** *Only Debian Based Distro Support Only*

### If you like our work then dont forget to give a Star :)

