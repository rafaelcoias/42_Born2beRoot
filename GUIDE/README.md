<h1>Born2beRoot Guide</h1>
<h3>Summary</h3>

  - Introduction
  - Create VM
  - VM Installation
  - Full Command Guide
    * Basic Set Up
    * UFW and SSH Configuration
    * Password Policy Configuration
    * Sudo Configuration
    * Script
    * Crontab Commands
  - Digital Signature
  - Evaluation

<h3>Introduction</h3>

There are a lot of new commands that you are going to use. I recommend you to take notes and study. <br>
If you use this guide from the beginning to end, you have born2beroot done.

<h3>Create VM</h3>

Choose one (I recommend Debian as this guide is about Debian).

Get Debian <a href="https://www.debian.org/download">here</a> <br>
Get CentOS <a href="https://www.centos.org/download/">here</a>
<hr>
After downloading Debian it is time to create your VM.

![image](https://user-images.githubusercontent.com/91686183/153648968-b38b94d2-80b8-4c40-bce1-fad6efd0f866.png)
> ⬆ Click in New

If you want to continue creating your VM click <a href="https://github.com/rafaelcoias/42_Born2beRoot/blob/main/GUIDE/CreateVM.md">here</a>.

<h3>VM Installation</h3>

After creating your Virtual Machine with Debian, run it and click in <i>Install</i>

![image](https://user-images.githubusercontent.com/91686183/153640306-edc42c9d-6c78-4333-89c2-b8faa8bb9aae.png)

If you want to continue the installation click <a href="https://github.com/rafaelcoias/42_Born2beRoot/blob/main/GUIDE/Installation.md">here</a>.

<h3>Full Command Guide</h3>

This Guide shows every single command and its use.
After you start the VM, write your encryption password and login with your new user, it is time to set up the basics.

NOTE: <br>
The '$' char marks the beginning of a command. <br>
Everything in <b>bolt</b> is a command. <br>
Everything in <i>italic</i> means it does not belong to the command, it's most likely a name or a user-name. <br>
Everything after ':' is the explanation of the written command. <br>
If you use this guide from the beginning to end, you have born2beroot done.
<hr>

<h4>Basic Set Up</h4>

$<b>su</b> : Login as root<br>
$<b>apt update</b> : Update system<br>
$<b>apt upgrade</b> : Upgrade system<br>
$<b>apt install sudo</b> : Install sudo and its commands<br>
$<b>sudo apt install vim</b> : Install vim and its commands<br>
$<b>sudo usermod -aG <i>sudo</i> <i>rade-sar</i></b> : Add user to sudo group (-a for '--append', -G for '--groups')<br>
$<b>getent group <i>sudo</i></b> : See group info (check if user is in group sudo)<br>
$<b>su - <i>rade-sar</i></b> : Leave root and log as user<br>
$<b>sudo groupadd <i>user42</i></b> : Add a group<br>
$<b>sudo usermod -aG <i>user42</i> <i>rade-sar</i></b> : Add user to a group (in this case to user42 group)<br>

<h4>UFW and SSH Configuration</h4>

$<b>sudo apt install openssh-server</b> : Install OpenSSH server<br>
$<b>sudo systemctl status ssh</b> : Verify ssh service<br>
$<b>ip a</b> : Get yours and VM ip<br>
$<b>cd /etc/ssh</b><br>
$<b>sudo vim sshd_config</b> : Open and edit sshd_config file<br>
  - Here edit the line where '#Port 22' is and instead of '#Port 22' write 'Port 4242' (without '#'). <br>

$<b>cd</b> : Go to the main directory<br>
$<b>sudo apt install ufw</b> : Install UFW Firewall<br>
$<b>sudo ufw enable</b> : Activate UFW<br>
$<b>sudo ufw status</b> : Check if its enable <br>
  - In VirtualBox app, go to Settings -> Network -> Adapt 1 -> Advanced -> Port Forwarding and check if you have a rule 1 for Port 4242. If not, create a new Rule and write 4242 in Host Port and in Guest Port. 

$<b>sudo reboot</b> : Reboot (restart) the machine<br>
$<b>sudo ufw allow 4242/tcp</b> : Allow the port 4242 on the Firewall<br>
  - Now you can use your VM in your terminal. Write the following command in your terminal if you want to connect your VM with the terminal through ssh.

$<b>ssh <i>rade-sar</i>@127.0.0.1 -p 4242</b> <br>

<h4>Password Policy Configuration</h4>

$<b>sudo apt install libpam-pwquality</b> : Install libpam-pwquality<br>
$<b>cd /etc/</b><br>
$<b>sudo vim login.defs</b> : Open and edit login.defs file<br>
  - Find the line that has 'PASS_MAX_DAYS 99999' and edit it to 'PASS_MAX_DAYS 30'.
  - Then edit 'PASS_MIN_DAYS 0' to 'PASS_MIN_DAYS 2'.

$<b>cd ./pam.d</b><br>
$<b>sudo vim common-password</b> : Open and edit common-password file<br>
<details><summary>
  Find the line that has 'password    requisite         pam_pwquality.so retry=3' and add after 'retry=3' the following rules : </summary>
  
  - ucredit=-1 : at least 1 UPPER case letter;
  - lcredit=-1 : at least 1 lower case letter;
  - dcredit=-1 : at least 1 digit;
  - maxrepeat=3 : it only lets you repeat a letter/number 3 times;
  - minlen=10 : minimum 10 chars password;
  - usercheck=0 : checks if your username is in your password;
  - difok=7 : it doesn't allow you to have more than 7 straight chars equals to your last password;
  - enforce_for_root : aply this settings for root.
  - At the end it should look like this
</details>
  
![image](https://user-images.githubusercontent.com/91686183/153658379-a29f47ae-aef0-4d39-9368-dba86826a2a8.png)

$<b>sudo reboot</b> : Reboot (restart) the machine<br>

Learn more : <a href="https://linux.die.net/man/8/pam_pwquality">man pw-quality</a>. 

<h4>Sudo Configuration</h4>

$<b>cd /etc/sudoers.d</b><br>
$<b>sudo visudo</b> :  Open and edit sudoers file<br>
<details><summary>
  Find the Defaults section and add the following Defaults : </summary>
  
  - Defaults  requiretty : Enable TTY;
  - Defaults  logfile="/var/log/sudo/sudo.log" : Selects a folder for saving your log files;
  - Defaults  log_input, log_output : Archives your log inputs and outputs;
  - Defaults  passwd_tries=3 : set your password retries number;
  - Defaults  baspass_message="*Try Again.*" : set your display message when a written password is incorrect;
  
</details>

![image](https://user-images.githubusercontent.com/91686183/153660311-6dd81d1f-750e-4dec-9540-809d4d446dfb.png)

<h4>Script</h4>

$<b>sudo vim /usr/local/bin/monitoring.sh</b><br>
  - Create a script that displays the info asked in born2beroot_subject.
  - Every bash script starts with '#!/bin/bash'.
  - Do a wall " ... " (just what you put inside the wall is going to be shown when we run the script).
<details><summary>
Now I am going to explain every single command that I used in my script. </summary>

<h4>Architecture</h4>

  - $<b>uname -a</b> : Print certain system information (-a flag stands for 'all'). So this command prints all the info about the system.

<h4>Physical CPU</h4>
  
$<b>grep "physical id" /proc/cpuinfo</b> : Select everything (inside the /cpuinfo/ directory) that has "physical id" in its name.<br> 
$<b>sort</b> : Organizes the information.<br>
$<b>uniq</b> : Displays the information in an uniq line.<br>
$<b>wc -l</b> : wc stands for 'word counting' and the flag -l for 'every line' (so this command counts every line of its search).<br>
  
Full command
  - $<b>grep "physical id" /proc/cpuinfo | sort | uniq | wc -l</b> : Counts every name that has 'physical id' inside the /proc/cpuinfo directory, then sorts and displays it in an uniq line.
  
<h4>Virtual CPU</h4>
  
$<b>grep "^processor" /proc/cpuinfo | sort | uniq | wc -l</b> : Counts every name that BEGINS (thats what '^' does) with 'processor' inside the /proc/cpuinfo directory, then sorts and displays it in an uniq line.<br> 
  
<h4>Usage RAM Percentage</h4>

  1. **Free RAM**
  
$<b>free -m</b> : Displays all the free memory information (-m flag makes the output in MegaBits like we want).<br> 
$<b>grep Mem</b> : Selects the Mem row.<br> 
$<b>print $4</b> : Prints the 4th column (4th column is the column of the available memory).<br>
Learn about <a href="https://linux.die.net/man/1/awk">awk</a>. 
  
Full command
  - $<b>free -m | grep Mem | awk '{print $4}'</b>
  
  2. **Total RAM**
  
Is basically the same but instead of $4 its $2 ($2 is the second column). <br>
Full command
  - $<b>free -m | grep Mem | awk '{print $2}'</b>
  
  3. **Usage RAM Percentage**
  
We have to get the usage that is in the column $3 and we will have to divide $3/$2 and multiply by 100 (to get the percentage). <br>
Full command
  - $<b>free -m | grep Mem | awk '{printf("%.2f"), $3/$2*100}'</b>
  
<h4>Usage Disk Percentage</h4>
   
  1. **Free Disk**  

$<b>df -Bm</b> : Displays all the server and disk space information (-B flag shows the block size and -m flag makes the output in MegaBits like we want).<br> 
$<b>grep '^/dev/'</b> : Selects every line that begins with /dev/.<br> 
$<b>grep -v '/boot$'</b> : Discards (thats what the -v flag does) every line that ends (thats what the '$' char does) with /boot.<br> 
The END command determines the main and last command.

We are going to need a variable because we have to sum every line that has free disk info (awk command is very usefull here).<br>
Full command
  - $<b>df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{free_disk += $4} END {print free_disk}'</b>
  
  2. **Total Disk**
  
Is basically the same but instead of $4 its $2 ($2 is the second column). And the -Bg flag makes the output in GB (as we want).<br>
Full command
  - $<b>df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{total_disk += $2} END {print total_disk}'</b>  

  3. **Usage Disk Percentage**
  
We need to get the usage that is in the column $3 and we will have to divide $3/$2 and multiply by 100 (to get the percentage). <br>
Full command
  - $<b>df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{free_disk += $3} {total_disk += $2} END {printf("%.2f"), free_disk/total_disk*100.0}'</b>  
  
<h4>Usage CPU Percentage</h4>
  
$<b>top -b</b> : Gives us yhe Cpu% as we want. The -b flag is to start in batch mode.<br> 
$<b>top -n1</b> :  Gives us yhe Cpu% as we want. The -n1 flag specifys the max number of iterations or frames (one in this case).<br> 
$<b>grep '^%Cpu'</b> : Selects the one row that matters (%Cpu).<br>
$<b> awk '{printf("%.1"), $2}'</b> : The values we want are in the column $2 so we display that in percentage with 1 decimal number.<br>
  
Full command
  - $<b>top -bn1 | grep '^%Cpu' | awk '{printf("%.1f%%"), $2}'</b>  
  
<h4>Last Reboot</h4>
  
$<b>who -b</b> : Displays information about users who are currently loggend in. The -b flag shows the time of last system boot.<br> 

We need to get the date and time and they are in the columns $3 and $4. I am adding a space (" ") to print both columns separately.<br>
Full command
  - $<b>who -b | awk '{print $3" "$4}'</b>    
  
<h4>LVM is active</h4>
  
$<b>lsblk</b> : Shows the partitions.<br> 
$<b>grep 'lvm'</b> : Selects only lvm part.<br>
$<b>exit</b> : Stop and end the command.<br>
  
To check we do an if : if I the column $1 is different from NULL print an yes and exit, otherwise print a no.<br>
Full command
  - $<b>lsblk | grep 'lvm' | awk '{if ($1) {printf "Yes";exit} else {print "No"; exit}}'</b>    
  
<h4>Number of Connections</h4>
  
$<b>ss -t</b> : Displays network socket related information. The -t flag lists only the tcp connections.<br> 
$<b>grep ESTAB</b> : Selects only the active ones.<br>
$<b>wc -l</b> : Counts it.<br>
  
Full command
  - $<b>ss -t | grep ESTAB | wc -l</b>      
  
<h4>Number of Users</h4>
  
$<b>who</b> : Displays information about users who are currently loggend in.<br> 
$<b>cut -d " " -f 1</b> : Cuts until the first space (cut -d " "). The -d flag use delimiter instead of TAB for field delimite. The flag -f to select only these fields and add 1<br>
$<b>sort -u</b> : Outputs only the first of an equal run (so it doesn't repeat).<br>
$<b>wc -l</b> : Counts it.<br>
  
Full command
  - $<b>who | cut -d " " -f 1 | sort -u | wc -l</b>        
  
<h4>IPv4 & MAC Address</h4>
  
  1. **IP Address**
  
  - $<b>hostname -I</b> : Displays the system's DNS name. The -I flag displays all network addresses of the host.<br>
  
  2. **MAC Address**  
  
$<b>ip link show</b> : Displays MAC (Media Access Control) and the network device.<br>
$<b>grep ether</b> : Selects only the parts that have 'ether'.<br>
  
We just need the second column $2.<br>
Full command
  - $<b>ip link show | grep ether | awk '{print $2}'</b>     
  
<h4>Numbers of Sudo Commands</h4>

$<b>journalctl</b> : Displays the record of journal and history logs.<br>
$<b>grep COMMAND</b> : Selects only logs that are Commands.<br>  
$<b>wc -l</b> : Counts it.<br>  
  
Full command
  - $<b>journalctl | grep COMMAND | wc -l</b>       
  
</details>

<hr>

*Commands Summary*
1. grep : Selects/searchs for a group of strings/parts/names.
2. grep '^example' : Selects/searchs for a group of strings/parts/names that begins with 'example'.
3. grep 'example$' : Selects/searchs for a group of strings/parts/names that ends with 'example'.
4. sort : Organizes and sorts the information collected.
5. uniq : Displays in an uniq line.
6. wc -l : Counts each line which a word appears in.
7. free : Displays current free memory information.
8. df : Displays current amount of free disk.
9. top : Displays every Cpu information.
10. who : Displays information about users who are currently loggend in.
11. lsblk : Displays partitions
12. ss : Displays network information.
13. ss -t : Displays network info (just tcp connections)
14. cut -d " " : Cuts information until it founds a space.
15. hostname -I : Displays all network information about the addresses of the host.
16. ip : Shows routing (mac address).
17. ip link show : Shows network device. 
18. journalctl : Displays the record journal and history that are archived in logs.

<hr>

You can see my final script <a href="https://github.com/rafaelcoias/42_Born2beRoot/tree/main/born2beroot_script">here</a>. 

Now lets add a rule for the script execute with sudo permissions without the sudo password. 

$<b>sudo visudo</b><br>
  - Add the following command in the "Allow members of group sudo to execute any command"

*rade-sar*  ALL=(ALL) NOPASSWD: /usr/local/bin/monitoring.sh

<h4>Crontab Commands</h4>

$<b>sudo crontab -e</b> :  Open and edit crontab commands (-e for '--edit')<br>
  - Add at the end of the file 2 commands :
  - To make a command (in this case your script) run every 10 mins

*/10 * * * * /usr/local/bin/monitoring.sh

  - To make a command (in this case your script) run after a reboot

@reboot sleep 10; /usr/local/bin/monitoring.sh

Learn more : <a href="https://linux.die.net/man/5/crontab">man crontab</a>. 

<hr>

<h3>Digital Signature</h3>

If you did everthing and want to submit your project, first thing you need to do is your digital signature. <br>

1. Open in your terminal the directory where your virtual machine is located (normally is in /sgoinfre/ or /goinfre/).
2. Run a command that creates your VM signature.
  - $<b>shasum <i>yourFilesName.dvi</i></b>

3. Copy the created key to a file with the name 'signature.txt' and submit it.

You can do all of this using just the following command :
  -  $<b>shasum <i>yourFilesName.dvi</i> > signature.txt && mv signature.txt <i>yourRepositoryPath</i></b>

<h3>Evaluation</h3>

After you done everything, it's time for you to know some concepts and study.

I also have a guide for the <a href="https://github.com/rafaelcoias/42_Born2beRoot/tree/main/EVALUATION">evaluation</a> and you can use it to prepare!

<h3>Good Luck !</h3>
