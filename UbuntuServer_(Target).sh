# update and install required packages
sudo apt update -y
sudo apt install -y nginx ufw fail2ban suricata

# enable/start services
sudo systemctl enable --now nginx fail2ban suricata

# write demo rules (overwrite local.rules)
sudo tee /etc/suricata/rules/local.rules > /dev/null <<'EOF'
alert tcp any any -> $HOME_NET 80 (msg:"SURICATA_TEST_HTTP_PROBE"; sid:1000001; rev:1;)
alert icmp any any -> $HOME_NET any (msg:"SURICATA_TEST_ICMP_PROBE"; sid:1000002; rev:1;)
EOF

# restart suricata so rules load
sudo systemctl restart suricata

# quick checks to show on screen (screenshot these)
ip -4 addr show
curl -I http://localhost
sudo ufw status numbered
sudo fail2ban-client status

# open live alert window — leave this terminal visible
sudo tail -F /var/log/suricata/fast.log