# check rule file
sudo cat /etc/suricata/rules/local.rules

# test suricata parsing
sudo suricata -T -c /etc/suricata/suricata.yaml

# manually start suricata on interface enp0s3
sudo suricata -c /etc/suricata/suricata.yaml -i enp0s3

# check systemd status
sudo systemctl status suricata --no-pager

#Show only the VM’s IPv4 address
hostname -I

#Check if your Suricata rules are still there
sudo grep 100000 /etc/suricata/rules/local.rules