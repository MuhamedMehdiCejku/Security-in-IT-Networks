TARGET=192.168.100.4   # <- set to your UbuntuServer IP

# sanity checks
ip -4 addr show
ping -c 3 $TARGET

# safe TCP connect scan (fast & non-privileged)
nmap -sT -Pn $TARGET -oN ~/nmap_sT.txt
cat ~/nmap_sT.txt

# service/version detection
nmap -sV -Pn $TARGET -oN ~/nmap_sV.txt
cat ~/nmap_sV.txt

# quick top ports
nmap --top-ports 100 -Pn $TARGET -oN ~/nmap_top100.txt
cat ~/nmap_top100.txt

# HTTP banner grab (should trigger http rule)
curl -I http://$TARGET || true

# ICMP test (should trigger icmp rule)
ping -c 3 $TARGET