sudo apt update
sudo apt upgrade -y
sudo apt install bash-completion telnet htop pcregrep cpu-checker curl -y
sudo apt install iptables ufw iptables-persistent conntrack bridge-utils -y
sudo apt install software-properties-common -y
sudo apt install apache2-utils git python3 python3-pip python3-netaddr python3-pip -y


echo "bridge-nf-call-iptables status $(cat /proc/sys/net/bridge/bridge-nf-call-iptables)"
echo "contrack status: "
sudo conntrack -L

ssh-keygen -f ~/.ssh/id_rsa -t rsa -q -P ""
