sudo apt update
sudo apt upgrade -y
sudo apt install bash-completion telnet htop pcregrep cpu-checker curl -y
sudo apt install iptables ufw iptables-persistent conntrack bridge-utils nfs-kernel-server -y
sudo apt install software-properties-common -y
sudo apt install apache2-utils git python3 python3-pip python3-netaddr python3-pip -y
sudo apt install pigpio mpd mpc ncmpc -y


echo "bridge-nf-call-iptables status $(cat /proc/sys/net/bridge/bridge-nf-call-iptables)"
echo "contrack status: "
sudo conntrack -L

ssh-keygen -f ~/.ssh/id_rsa -t rsa -q -P ""

echo " cgroup_memory=1 cgroup_enable=memory" | sudo tee -a /boot/cmdline.txt


sudo apt remove --purge --auto-remove dhcpcd5 fake-hwclock ifupdown isc-dhcp-client isc-dhcp-common openresolv -y
sudo killall wpa_supplicant
sudo killall dhcpcd

cp network/eth0.* /etc/systemd/network

sudo systemctl enable systemd-networkd
sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
sudo systemctl enable systemd-resolved
sudo systemctl enable systemd-timesyncd


echo "Press enter and enable remote gpio in raspi-config"

read
sudo raspi-config

sudo systemctl enable pigpiod.service --now

sudo mkdir -p /etc/exports.d
sudo mkdir -p /srv/nfs/music
sudo mkdir -p /media/music

cp etc/exports.d/* /etc/exports.d/
