sudo apt update
sudo apt upgrade -y
sudo apt install bash-completion telnet htop pcregrep cpu-checker curl -y
sudo apt install iptables ufw iptables-persistent conntrack bridge-utils nfs-kernel-server network-manager -y
sudo apt install software-properties-common -y
sudo apt install apache2-utils git python3 python3-pip python3-netaddr python3-pip -y
sudo apt install mpd mpc ncmpc -y


echo "bridge-nf-call-iptables status $(cat /proc/sys/net/bridge/bridge-nf-call-iptables)"
echo "contrack status: "
sudo conntrack -L

ssh-keygen -f ~/.ssh/id_rsa -t rsa -q -P ""

echo " cgroup_memory=1 cgroup_enable=memory" | sudo tee -a /boot/cmdline.txt


sudo apt remove --purge --auto-remove dhcpcd5 fake-hwclock ifupdown isc-dhcp-client isc-dhcp-common openresolv -y
sudo killall wpa_supplicant
sudo killall dhcpcd

sudo systemctl enable systemd-resolved
sudo systemctl enable systemd-timesyncd

read
sudo raspi-config

sudo nmcli conn add type vlan con-name eth0.100 dev eth0 id 100
sudo nmcli conn mod eth0.100 ethernet.cloned-mac-address dc:a6:32:e0:fe:02

sudo nmcli conn add type vlan con-name eth0.200 dev eth0 id 200
sudo nmcli conn mod eth0.200 ethernet.cloned-mac-address dc:a6:32:e0:fe:03

sudo nmcli conn add type vlan con-name eth0.3 dev eth0 id 3
sudo nmcli conn mod eth0.3 ethernet.cloned-mac-address dc:a6:32:e0:fe:04

# enable cni dhcp daemon
sudo cp ../configs/cni-dhcp-daemon.service /etc/systemd/system
sudo systemctl enable cni-dhcp-daemon.service --now