#!/data/data/com.termux/files/usr/bin/bash
R="$(printf '\033[1;31m')"
G="$(printf '\033[1;32m')"
Y="$(printf '\033[1;33m')"
W="$(printf '\033[0m')"
C="$(printf '\033[1;36m')"

banner() {
    clear
printf "\033[33m╭━━━╮╱╱╱╱╱╱╱╱╱╱╱╱╭━━╮╱╱╱╭━━━━╮\033[0m\n"
printf "\033[33m┃╭━╮┃╱╱╱╱╱╱╱╱╱╱╱╱╰┫┣╯╱╱╱┃╭╮╭╮┃\033[0m\n"
printf "\033[33m┃┃╱╰╋━╮╭━━┳╮╭┳━━╮╱┃┃╭━╮╱╰╯┃┃┣┻━┳━┳╮╭┳╮╭┳╮╭╮\033[0m\n"
printf "\033[33m┃┃╭━┫╭╮┫╭╮┃╰╯┃┃━┫╱┃┃┃╭╮╮╱╱┃┃┃┃━┫╭┫╰╯┃┃┃┣╋╋╯\033[0m\n"
printf "\033[33m┃╰┻━┃┃┃┃╰╯┃┃┃┃┃━┫╭┫┣┫┃┃┃╱╱┃┃┃┃━┫┃┃┃┃┃╰╯┣╋╋╮\033[0m\n"
printf "\033[33m╰━━━┻╯╰┻━━┻┻┻┻━━╯╰━━┻╯╰╯╱╱╰╯╰━━┻╯╰┻┻┻━━┻╯╰╯\033[0m\n"
echo "${C}${BOLD} Install Gnome Desktop In Termux"${W}
echo                                                   
}

package_install_and_check() {
	packs_list=($@)
	for package_name in "${packs_list[@]}"; do
    echo "${R}[${W}-${R}]${G}${BOLD} Installing package: ${C}$package_name "${W}
    pkg install "$package_name" -y
	if [ $? -ne 0 ]; then
    apt --fix-broken install -y
	dpkg --Configuring -a
    fi
	if dpkg -s "$package_name" >/dev/null 2>&1; then
    echo "${R}[${W}-${R}]${G} $package_name installed successfully "${W}
	else
	if
    type -p "$package_name" &>/dev/null || [ -e "$PREFIX/bin/$package_name"* ] || [ -e "$PREFIX/bin/"*"$package_name" ]; then
        echo "${R}[${W}-${R}]${C} $package_name ${G}installed successfully "${W}
	fi
    fi
done

}

get_latest_release() {
	local repo_woner="$1"
	local repo_name="$2"
  curl -s "https://api.github.com/repos/$repo_woner/$repo_name/releases/latest" |
  grep '"tag_name":' |
  sed -E 's/.*"([^"]+)".*/\1/'
}

questions() {
	banner
	echo 
	echo "${R} [${W}-${R}]${G} Select Distro "${W}
	echo
	echo "${Y}1. Debian (Default)"${W}
	echo
	echo "${Y}2. Ubuntu"${W}
	echo
    echo "${Y}3. Kali"${W}
    echo
    echo "${Y}4. Pardus (bad support)"${W}
	echo
    echo "${Y}5. Arch"${W}
	echo
    echo "${Y}6. Fedora"${W}
	echo
    echo "${Y}7. Alpine"${W}
	echo
	read -p "${Y}select a distro: "${W} answer_distro
	answer_distro="${answer_distro:-1}"
    echo "${R}[${W}-${R}]${G}Continuing with answer: $answer_distro"${W}
    sleep 0.2
}

basic_task() {
    banner
    echo "${R}[${W}-${R}]${G}${BOLD} Updating System...."${W}
	echo
    pkg update -y -o Dpkg::Options::="--force-confold"
	pkg upgrade -y -o Dpkg::Options::="--force-confold"
    clear
    echo "${R}[${W}-${R}]${G}${BOLD} Configuring Storage..."${W}
	echo
	while true; do
	termux-setup-storage
	sleep 4
    if [[ -d ~/storage ]]; then
        break
    else
        echo "${R} Storage permission denied"${W}
    fi
    sleep 3
    done
    clear
    echo "${R} [${W}-${R}]${G} Installling Required Packages... "${W}
    package_install_and_check "wget proot proot-distro pulseaudio"
}

install_distro() {
    banner
    if [[ ${answer_distro} == "1" ]]; then
        proot-distro install debian
    elif [[ ${answer_distro} == "2" ]]; then
        proot-distro install ubuntu
    elif [[ ${answer_distro} == "3" ]]; then
    echo "${R} [${W}-${R}]${G} Uses Modded-Kali Script To Install Kali In Termux..."${W}
    sleep 0.5
    wget -O kaliinstaller.sh https://raw.githubusercontent.com/sabamdarif/modded-kali/main/setup.sh ; bash kaliinstaller.sh 
    rm kaliinstaller.sh
    elif [[ ${answer_distro} == "4" ]]; then
        proot-distro install pardus
    elif [[ ${answer_distro} == "5" ]]; then
        proot-distro install archlinux
    elif [[ ${answer_distro} == "6" ]]; then
        proot-distro install fedora
    elif [[ ${answer_distro} == "7" ]]; then
        proot-distro install alpine
    else
        proot-distro install debian
    fi
}

setup_tx11() {
    banner
    echo "${G}Setup Termux:X11 "${W}
    echo
    package_install_and_check "x11-repo termux-x11-nightly"
    local repo_owner="termux"
    local repo_name="termux-x11"
    local latest_tag
    latest_tag=$(get_latest_release "$repo_owner" "$repo_name")
    local termux_x11_url="https://github.com/$repo_owner/$repo_name/releases/download/$latest_tag/"
    local assets
    assets=$(curl -s "https://api.github.com/repos/$repo_owner/$repo_name/releases/latest" | grep -oP '(?<="name": ")[^"]*')
    deb_assets=$(echo "$assets" | grep termux-x11.*all.deb)
    wget -O $current_path/termux-x11.deb $termux_x11_url/$deb_assets
    apt install $current_path/termux-x11.deb -y
    rm $current_path/termux-x11.deb
    sed -i '12s/^#//' $HOME/.termux/termux.properties
}

setup_installer() {
    banner
    distro_path="/data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs"
    echo "${G} Setup Installer... "${W}
    cd ~
    if [[ ${answer_distro} == "1" ]]; then
    wget -O $HOME/gnome-installer.sh https://raw.githubusercontent.com/sabamdarif/gnome-in-termux/main/install-gnome-desktop
    setup_tx11
    mv gnome-installer.sh $distro_path/debian/root
    proot-distro login debian -- /bin/sh -c 'bash gnome-installer.sh'

    elif [[ ${answer_distro} == "2" ]]; then
    wget -O $HOME/gnome-installer.sh https://raw.githubusercontent.com/sabamdarif/gnome-in-termux/main/install-gnome-desktop
    setup_tx11
    mv gnome-installer.sh $distro_path/ubuntu/root
    proot-distro login ubuntu -- /bin/sh -c 'bash gnome-installer.sh'

    elif [[ ${answer_distro} == "3" ]]; then
    wget -O $HOME/gnome-installer.sh https://raw.githubusercontent.com/sabamdarif/gnome-in-termux/main/install-gnome-desktop
    setup_tx11
    mv gnome-installer.sh $distro_path/kali/root
    proot-distro login kali -- /bin/sh -c 'bash gnome-installer.sh'

    elif [[ ${answer_distro} == "4" ]]; then
    wget -O $HOME/gnome-installer.sh https://raw.githubusercontent.com/sabamdarif/gnome-in-termux/main/install-gnome-pardus-desktop
    setup_tx11
    mv gnome-installer.sh $distro_path/pardus/root
    proot-distro login pardus -- /bin/sh -c 'bash gnome-installer.sh'

    elif [[ ${answer_distro} == "5" ]]; then
    wget -O $HOME/gnome-installer.sh https://raw.githubusercontent.com/sabamdarif/gnome-in-termux/main/install-arch-gnome-desktop
    setup_tx11
    mv gnome-installer.sh $distro_path/archlinux/root
    proot-distro login archlinux -- /bin/sh -c 'bash gnome-installer.sh'

    elif [[ ${answer_distro} == "6" ]]; then
    wget -O $HOME/gnome-installer.sh https://raw.githubusercontent.com/sabamdarif/gnome-in-termux/main/install-fedora-gnome-desktop
    setup_tx11
    mv gnome-installer.sh $distro_path/fedora/root
    proot-distro login fedora -- /bin/sh -c 'bash gnome-installer.sh'

    elif [[ ${answer_distro} == "7" ]]; then
    wget -O $HOME/gnome-installer.sh https://raw.githubusercontent.com/sabamdarif/gnome-in-termux/main/install-alpine-gnome-desktop
    setup_tx11
    mv gnome-installer.sh $distro_path/alpine/root
    proot-distro login alpine -- /bin/sh -c 'bash gnome-installer.sh'

    else
    wget -O $HOME/gnome-installer.sh https://raw.githubusercontent.com/sabamdarif/gnome-in-termux/main/install-gnome-desktop
    setup_tx11
    mv gnome-installer.sh $distro_path/debian/root
    proot-distro login debian -- /bin/sh -c 'bash gnome-installer.sh'
    fi
}

current_path=$(pwd)
questions
basic_task
install_distro
setup_installer