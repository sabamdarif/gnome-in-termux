#!/bin/bash

R="$(printf '\033[1;31m')"
G="$(printf '\033[1;32m')"
Y="$(printf '\033[1;33m')"
W="$(printf '\033[1;37m')"
C="$(printf '\033[1;36m')"

function banner() {
    clear
printf "\033[33m╭━━━╮╱╱╱╱╱╱╱╱╱╱╱╱╭━━╮╱╱╱╭━━━━╮\033[0m\n"
printf "\033[33m┃╭━╮┃╱╱╱╱╱╱╱╱╱╱╱╱╰┫┣╯╱╱╱┃╭╮╭╮┃\033[0m\n"
printf "\033[33m┃┃╱╰╋━╮╭━━┳╮╭┳━━╮╱┃┃╭━╮╱╰╯┃┃┣┻━┳━┳╮╭┳╮╭┳╮╭╮\033[0m\n"
printf "\033[33m┃┃╭━┫╭╮┫╭╮┃╰╯┃┃━┫╱┃┃┃╭╮╮╱╱┃┃┃┃━┫╭┫╰╯┃┃┃┣╋╋╯\033[0m\n"
printf "\033[33m┃╰┻━┃┃┃┃╰╯┃┃┃┃┃━┫╭┫┣┫┃┃┃╱╱┃┃┃┃━┫┃┃┃┃┃╰╯┣╋╋╮\033[0m\n"
printf "\033[33m╰━━━┻╯╰┻━━┻┻┻┻━━╯╰━━┻╯╰╯╱╱╰╯╰━━┻╯╰┻┻┻━━┻╯╰╯\033[0m\n"
printf "\033[32m code by @sabamdrif \033[0m\n"
printf "\033[32m subscribe my YouTube Channel Hello Android \033[0m\n"                                                     
}

questions() {
	banner
	echo 
	echo "${G} Select Distro "${W}
	echo
	echo "${Y}1. Debian (Default)"${W}
	echo
	echo "${Y}2. Ubuntu"${W}
	echo
    echo "${Y}2. Kali"${W}
	echo
	read -p "${Y}select a distro: "${W} answer_distro
	echo
}

basic_task() {
    banner
    echo "${G} Updating Termux... "${W}
    pkg update -y
    clear
    echo "${G} Setting Up Storage... "${W}
    termux-setup-Storage
    clear
    echo "${G} Installling Required Packages... "${W}
     packs=(wget proot proot-distro pulseaudio)
    for pack in "${packs[@]}"; do
        type -p "$pack" &>/dev/null || {
            echo -e "\n${R} [${W}-${R}]${G} Installing package : ${Y}$pack${C}"${W}
             pkg install "$pack" -y
        }
    done
}

install_distro() {
    banner
    if [[ ${answer_distro} == "1" ]]; then
        proot-distro install debian
    elif [[ ${answer_distro} == "2" ]]; then
        proot-distro install ubuntu
    elif [[ ${answer_distro} == "3" ]]; then
    echo "${G} Using Modded-Kali Script To Install Kali In Termux..."${W}
    sleep 0.5
    wget -O kaliinstaller.sh https://raw.githubusercontent.com/sabamdarif/modded-kali/main/setup.sh ; bash kaliinstaller.sh 
    rm kaliinstaller.sh
    else
        proot-distro install debian
    fi
}

setup_installer() {
    banner
    distro_path="/data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs"
    echo "${G} Setup Installer... "${W}
    cd ~
    wget -O gnome-installer.sh https://raw.githubusercontent.com/sabamdarif/gnome-in-termux/main/install-gnome-desktop
    if [[ ${answer_distro} == "1" ]]; then
        mv gnome-installer.sh $distro_path/debian/root
        proot-distro login debian -- /bin/sh -c 'bash gnome-installer.sh'
    elif [[ ${answer_distro} == "2" ]]; then
        mv gnome-installer.sh $distro_path/ubuntu/root
        proot-distro login ubuntu -- /bin/sh -c 'bash gnome-installer.sh'
    elif [[ ${answer_distro} == "3" ]]; then
        mv gnome-installer.sh $distro_path/kali/root
        proot-distro login kali -- /bin/sh -c 'bash gnome-installer.sh'
    else 
        mv gnome-installer.sh $distro_path/debian/root
        proot-distro login debian -- /bin/sh -c 'bash gnome-installer.sh'
    fi
}

questions
basic_task
install_distro
setup_installer