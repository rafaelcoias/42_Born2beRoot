#!/bin/bash

architecture=$(uname -a)
pcpu=$(grep "physical id" /proc/cpuinfo | sort | uniq | wc -l)
vcpu=$(grep "^processor" /proc/cpuinfo | wc -l)

free_memory=$(free -m | grep Mem | awk '{print $4}')
total_memory=$(free -m | grep Mem | awk '{print $2}')
percent_used_memory=$(free -m | grep Mem | awk '{printf("%.2f"), $3/$2*100.0}')

free_disk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{f_disk = f_disk + $4} END {print f_disk}')
total_disk=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{t_disk = t_disk + $2} END {print t_disk}')
percent_used_disk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{u_disk = u_disk + $3} {t_disk = t_disk + $2} END {printf("%.2f"), u_disk/t_disk*100.0}')

percent_used_cpu=$(top -bn1 | grep '^%Cpu' | awk '{printf("%.1f%%"), $2}')
last_reboot=$(who -b | awk '{print $3" "$4}')
lvm_is_active=$(lsblk | grep 'lvm' | awk '{if ($1) {print "Yes"; exit} else {print "No"; exit}}')
connexions=$(ss -t | grep ESTAB | wc -l)
users_in_server=$(who | cut -d " " -f 1 | sort -u | wc -l)
ipv4_addr=$(hostname -I)
mac_addr=$(ip link show | grep ether | awk '{print $2}')
sudo_cmds=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

wall "	#Architecture: $architecture
	#CPU physical: $pcpu
	#vCPU: $vcpu
	#Memory Usage: ${free_memory}/${total_memory}MB (${percent_used_memory}%)
	#Disk Usage: ${free_disk}/${total_disk}Gb (${percent_used_disk}%)
	#CPU load: ${percent_used_cpu}
	#Last boot: $last_reboot
	#LVM use: $lvm_is_active
	#Connexions TCP: $connexions ESTABLISHED
	#User log: $users_in_server
	#Network: IP $ipv4_addr ($mac_addr)
	#Sudo: $sudo_cmds cmd"
