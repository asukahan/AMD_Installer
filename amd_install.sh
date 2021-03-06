#!/bin/bash
#Script for the easy installation of AMD Drivers on HiveOS/Ubuntu based OS
#Script By CryptoLuigi (Michael Ruperto)
#Edit by Asukahan (Xu Han)
#Date: 2020-12-05
#Contributors: miabo Cryptonuffe

systemctl stop hivex
miner stop

echo
#mkdir /hive-drivers-pack/
cd /hive-drivers-pack/
echo "Please note Drivers with the 18.04 suffix require Hive OS 0.6-61 image or after."
PS3='Please enter your choice: '

options=("onda-6-18.40-673869-ubuntu-16.04" "18.40-697810-ubuntu-18.04" "18.50-725072-ubuntu-18.04" "19.50-967956-ubuntu-18.04" "Quit")

select opt in "${options[@]}"
do
case $opt in
    "18.40-673869-ubuntu-16.04")
	wget -c http://download.hiveos.farm/drivers/amdgpu-pro-18.40-673869-ubuntu-16.04.tar.xz
        version="18.40-673869-ubuntu-16.04";break
    ;;
    "18.40-697810-ubuntu-18.04")
	wget -c http://download.hiveos.farm/drivers/amdgpu-pro-18.40-697810-ubuntu-18.04.tar.xz
        version="18.40-697810-ubuntu-18.04";break
	;;
    "18.50-725072-ubuntu-18.04")
	wget -c http://download.hiveos.farm/drivers/amdgpu-pro-18.50-725072-ubuntu-18.04.tar.xz
        version="18.40-697810-ubuntu-18.04";break
    ;;
	"19.50-967956-ubuntu-18.04")
	wget -c http://download.hiveos.farm/drivers/amdgpu-pro-19.50-967956-ubuntu-18.04.tar.xz
        version="19.50-967956-ubuntu-18.04";break
	;;
	"Quit")
	exit
        break
    ;;
    *)
        echo "Invalid option $REPLY"
    ;;
    esac
done

echo
read -p "Do you want have RX4xx/RX5xx?(y/n)" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    tar -Jxvf amdgpu-pro-$version.tar.xz
    echo
    read -p "Do you want remove current AMD Drivers?(y/n)" -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
		/usr/bin/amdgpu-pro-uninstall
		#apt-get remove vulkan-amdgpu-pro*
	fi
	cd amdgpu-pro-$version
    apt-get -f install
    ./amdgpu-pro-install --opencl=legacy -y
    dpkg -l amdgpu-pro
    exit
fi

tar -Jxvf amdgpu-pro-$version.tar.xz
cd amdgpu-pro-$version
./amdgpu-pro-install -y
dpkg -l amdgpu-pro
