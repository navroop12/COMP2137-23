datetime=$(date)
echo "System Report genrated by $USER, $datetime" 

echo "System Information"
echo "------------------"
echo "Hostname: $(hostname)"
osname=$(hostnamectl | awk '/Operating/ {print $3,$4}')
echo "OS: $osname"
runtime=$(uptime -p)
echo "uptime: $runtime"
echo "------------------"

echo "Hardware Information"
echo "------------------"
cpu=$(lscpu | awk '/Model name/ {print $3,$4,$5,$6}')
speed=$(lscpu | awk '/CPU MHz/ {print $3}')
ram=$(cat /proc/meminfo | awk '/MemTotal/ {print $2}')
disk=$(df -T | awk '/dev/ {print $1"                  "$2"               "$3}')
video=$(lspci -v | awk '/VGA/ {print $5,$6,$7,$8}')
echo "CPU: $cpu"
echo "Speed: $speed MHz"
echo "RAM: $ram kb"
echo "Disk"
echo "Name                  Type                  Size"
echo "$disk"
echo "Video: $video"
echo "------------------"

echo "Network INformation"
echo "------------------"
ip=$(hostname -I)
ipr=$(ip r | awk '/default/ {print $3}')
dns=$(cat /etc/resolv.conf | awk '/nameserver/ {print $2}')
iname=$(ip link show | awk ' !/link/ {print $2}')
echo "FQDN: $dnsdomainname"
echo "Host address: $ip"
echo "Gateway IP: $ipr"
echo "Dns Server: $dns"

echo "Interface name:"
echo "$iname"
echo "------------------"

echo "System Status"
echo "------------------"
echo "User logged in: $(who | awk '{print $1}')"
echo "Free Space: "
echo "$(df | awk '/dev/ {print $1, $4}')"
echo "Process count: $(ps -e | wc -l)"
echo "Load avarage: $(w | awk '/average/ {print $8,$9,$10}')"
echo "Memory allocation: $(cat /proc/meminfo | awk '/MemFree/ {print $2}')"
echo "Listning network port: "
echo "$(ss -tuln | awk 'NR>1 {print $5}')"
echo "UFW rules: "
sudo ufw status
echo "------------------"
