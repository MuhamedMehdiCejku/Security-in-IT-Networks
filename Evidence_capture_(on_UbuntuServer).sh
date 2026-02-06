sudo tail -n 200 /var/log/suricata/fast.log | sudo tee ~/suricata_fast_last200.log
sudo tail -n 200 /var/log/nginx/access.log | sudo tee ~/nginx_access_last200.log
sudo ufw status numbered | sudo tee ~/ufw_status.txt
sudo fail2ban-client status | sudo tee ~/fail2ban_status.txt
sudo journalctl -u suricata --no-pager -n 200 | sudo tee ~/suricata_journal_last200.log