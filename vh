#!/bin/bash
###############################################
##  server scripts vhosts for IRC            ##
##  (c) bolton                               ##
###############################################

# color
LIGHT_BLUE='\033[1;34m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
YELLOW="\033[1;33m"
NC='\033[0m' # No color

PRM="${GREEN} *@*|${NC} "

# Info 
ILOSC_IPv6=`lsof -n -iTCP:6660-6669 | grep IPv6 | wc -l`
ILOSC_IPv4=`lsof -n -iTCP:6660-6669 | grep IPv4 | wc -l`
MOJE=`lsof -n -iTCP:6660-6669 | grep $USER | wc -l`
PROCESY=`lsof -n -iTCP:6660-6669 | grep $USER |awk '{print $1}' |sort`

# Get all external ^third party IPv4 and IPv6 addresses available on the server
ipv4_addresses=$(ip -4 addr show | grep 'inet ' | awk '{print $2}' | cut -d/ -f1 | grep -vE '^127\..*|^10\..*|^172\.(1[6-9]|2[0-9]|3[0-1])\..*|^192\.168\..*')
ipv6_addresses=$(ip -6 addr show | grep 'inet6 ' | awk '{print $2}' | cut -d/ -f1 | grep -vE '^::1|^fe80.*|^fd.*|^fc.*')

# Download ^eca reverse DNS function
get_reverse_dns() {
    rev_dns=$(host -W 1 "$1" | awk '/pointer/ {print $5}')
    if [ -z "$rev_dns" ]; then
        echo -e "${YELLOW}bad reverse DNS record${NC}"
    else
        echo -e "${CYAN}$rev_dns${NC}"
    fi
}
# My addresses IPv4
echo
echo -e "\\033[1;33mStats: \\033[1;37m"
echo -e "My connections ipv4: ${GREEN}$ILOSC_IPv4${NC}"
echo -e "My connections ipv6: ${GREEN}$ILOSC_IPv6${NC}"
echo
echo -e "addresses IPv4:"
echo
for ip in $ipv4_addresses; do
    reverse_dns=$(get_reverse_dns "$ip")
    echo -e "${PRM} ${GRN}$ip${NC} - $reverse_dns"
done
echo -e "\n\n"
echo -e "\\033[1;33mIRCnet IPv4 servers:\\033[m"
echo -e "\\033[1;31m-> \\033[1;37mirc.atw-inter.net        = 94.125.182.253"
echo -e "\\033[1;31m-> \\033[1;37mopenirc.snt.utwente.nl   = 192.87.173.10"
echo -e "\\033[1;31m-> \\033[1;37mtngnet.ircnet.io         = 45.88.6.140"
echo -e "\\033[1;31m-> \\033[1;37mircnet.hostsailor.com    = 185.198.56.40"
echo -e "\\033[1;31m-> \\033[1;37mirc.spadhausen.com       = 154.62.195.2"
echo -e "\\033[1;31m-> \\033[1;37mirc.nlnog.net            = 165.254.255.132"
echo -e "\\033[1;31m-> \\033[1;37mirc.psychz.net           = 108.181.56.253"
echo -e "\\033[1;31m-> \\033[1;37mtempest.ircnet.io        = 205.178.182.159"
echo -e "\\033[1;31m-> \\033[1;37mirc.swepipe.net          = 188.240.145.20"
echo -e "\\033[1;31m-> \\033[1;37mirc.us.ircnet.net        = 170.178.184.37"
echo
echo -e "\n\n"
# My addresses IPv6
echo -e "addresses IPv6:"
echo
for ip in $ipv6_addresses; do
    reverse_dns=$(get_reverse_dns "$ip")
    echo -e "${PRM} ${GRN}$ip${NC} - $reverse_dns"
done
echo -e "\n\n"
echo -e "\\033[1;33mIRCnet IPv6 servers:\\033[m"
echo -e "\\033[1;31m-> \\033[1;37mirc.atw-inter.net          = 2a01:270:0:6668::2"
echo -e "\\033[1;31m-> \\033[1;37mirc.man-da.de              = 2001:41b8:205::250"
echo -e "\\033[1;31m-> \\033[1;37mopenirc.snt.utwente.nl     = 2001:610:1908:8010::10"
echo -e "\\033[1;31m-> \\033[1;37mtngnet.ircnet.io           = 2a05:e4c1:2001::6667"
echo -e "\\033[1;31m-> \\033[1;37mircnet.hostsailor.com      = 2a06:3d81:9::6667"
echo -e "\\033[1;31m-> \\033[1;37mirc.spadhausen.com         = 2a05:9d40:8000::2"
echo -e "\\033[1;31m-> \\033[1;37mirc.psychz.net             = 2604:6600:2002:b::6667"
echo -e "\\033[1;31m-> \\033[1;37mirc.swepipe.net            = 2001:6b0:78::20"
echo
echo
printf "\\033[1;37mStarting Console. Please wait\\033[1;37m";sleep 0.21;printf ".";sleep 0.21;printf ".";sleep 0.21;printf "."
echo -e "${GREEN}DONE${NC}!."
echo
