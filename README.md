
<center><img src="images/demo-gnome.png"></center>
<p align="center"><b>Easily Install Gnome Desktop in Termux</b></p>

<div align="center">

![GitHub stars](https://img.shields.io/github/stars/sabamdarif/gnome-in-termux)
![GitHub issues](https://img.shields.io/github/issues/sabamdarif/gnome-in-termux)

</div>

### Features:

- :speaker: Fixed Audio Output
- :globe_with_meridians: 2 Browsers (Chromium & Mozilla Firefox)
- :tv: VLC Media Player work fine
- :books: Easy To Setup
- :computer: Login Issue Fixed
- :computer: [Termux:x11](https://github.com/termux/termux-x11) For Display Server
- :hammer: Gnome Software Preinstalled (working)
- :books: And Much More

> ***This is just for test so don't think everything will work***

> ***If one distro don't work so try another one***

### Installation:
1. If you are using android 12 or higher then first disable phantom process killer [Tutorial](https://termux.xyz/how-to-fix-termux-error-process-completed-signal-9-press-enter/)
2. Install [Termux](https://termux.com) apk from [HERE](https://f-droid.org/en/packages/com.termux/)
3. Now copy pest this in termux 👇
4. 
   ```
   curl -Lf https://raw.githubusercontent.com/sabamdarif/gnome-in-termux/main/setup.sh -o setup.sh ; bash setup.sh
    ```
   - Now Select **CORE** Or **FULL(recomended)**
       <details>
       <summary><b>DEMO IMAGES:</b></summary>

       |CORE|FULL|
       |--|--|
       |![img](/images/core-gnome.png)|![img](/images/full-gnome.png)|
      </details>
5. Use [Termux:x11](https://github.com/termux/termux-x11/releases) (Better then VNC)
6. Enjoy :smile:

### How To Setup Vnc:

<details>
       <summary><b>Setup Vnc: </b></summary>
       <b>For Debian Based Distro</b>

      sudo apt install  tigervnc-standalone-server tigervnc-tools -y
<br>

      mkdir -p "$HOME/.vnc"
<br>

      nano $HOME/.vnc/xstartup
<br>

      export XDG_CURRENT_DESKTOP="GNOME"
      gnome-shell --x11
<br>
     
      chmod +x "$HOME/.vnc/xstartup"
<br>
      
      sudo echo "$YOUR_USER_NAME ALL=(ALL) NOPASSWD: /usr/sbin/service dbus start" | sudo tee -a /etc/sudoers
<br>
      
      sudo nano /bin/vncstart
<br>
      
      #!/usr/bin/env bash
      sudo service dbus start
      vncserver -geometry 2580x1080 #Add your screen size
<br>
      
      sudo chmod +x /bin/vncstart
<br>
      
      sudo nano /bin/vncstop
<br>
      
      #!/usr/bin/env bash
      if [ "\$1" == "-f" ]; then
      pkill Xtigervnc
      else
      vncserver -kill :*
      fi
      rm -rf /.vnc/localhost:*.pid
      rm -rf /tmp/.X1-lock
      rm -rf /tmp/.X11-unix/X1
<br>
      
      sudo chmod +x /bin/vncstop
       
</details>

### NOTE:

- **Type `DISTRO-NAME` to login into DISTRO CLI.**
- **Type `DISTRO-NAME -r` to login as root user**
- **Type `DISTRO-NAME -tx11` to use gnome with Termux-x11**
- **Type `DISTRO-NAME -remove` to remove the distro**

**Like If You Install Debian So Just Type `debian -r / debian -tx11 / debian -remove`**

### Warning: 
- *In future if you upgarde the system the desktop will fail to launch.*
  #### Fix:
  - **First stop gui and relogin into your distro**
  - **Then run the below command inside your distro then start gui again**
```
for file in $(find /usr -type f -iname "*login1*"); do rm -rf $file
   done
```

### If you like our work then dont forget to give a Star :)
