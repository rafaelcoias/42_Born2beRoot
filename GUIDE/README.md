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
      - Architecture
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

Now I am going to explain every single command that I used in my script.

-COMMANDS

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

<h3>Evaluation</h3>

After you done everything, it's time for you to know some concepts and study.

I also have a guide for the <a href="https://github.com/rafaelcoias/42_Born2beRoot/tree/main/EVALUATION">evaluation</a> and you can use it to prepare!

<h3>Good Luck !</h3>
