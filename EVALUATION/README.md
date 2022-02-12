<h1>Born2beRoot Evaluation</h1>
<h3>Summary</h3>

  - Introduction
  - Full Evaluation Guide
    * Signature
    * How a virtual machine works
    * Choice of Operating System
    * Main differences between CentOS and Debian
    * Purpose of Virtual Machines
    * Differences between APT and Aptitude
    * What is APPArmor
    * Check UFW, SSH and Operating System
    * User and Groups
    * Hostname and Partitions
    * Sudo
    * UFW
    * SSH
    * Script
    * Crontab
  - Good Luck !

<h3>Introduction</h3>

If you are done doing born2beroot, you should take a snapshot of your VM so you don´t have to worry if something goes wrong. <br>
This is a full guide for your born2beroot evaluation. After learning and seeing everything you need to know, study a bit before submitting your project. <br>

<h3>Full Evaluation Guide</h3>

<details><summary>Everything bellow is going to be asked or done during your evaluation.</summary>

<h4>Signature</h4>

Compare your VM signature with the one in your repository. <br>
In the terminal :
  1.  Go to “sngoinfre folder”
  2.  $<b>shasum *yourFilesName*.vdi</b>
  3.  $<b>cat signature.txt</b>
  4.  Compare both

<h4>How a virtual machine works</h4>

  - Virtual environment that works like a computer within a computer
  - Runs on a different partition meaning that the software inside a VM can't interfere with the host computer's primary operating system
  - Can have a different OS installed (Windows, Linux, etc)
  - Uses specific allocated hardware from the primary computer

<h4>Choice of Operating System</h4>

Debian OS
  
  - Easier to use
  - More frequent updates compared with CentOs
  - Debian has vast library of default Packages

<h4>Main differences between CentOS and Debian</h4>
  
  - Debian uses 'APT-get' and CentOS 'Yum' as package manager
  - Debian has frequent updates and CentOS updates and upgrades take time
  - Debian has a user-friendly GUI (graphical user interface) and CentOS has a complicated GUI.

<h4>Purpose of Virtual Machines</h4>

  - Operate multiple operating systems at the same time
  - Operate multiple operating systems from the same piece of hardware
  - Without virtualization, operating multiple systems — like Windows and Linux — would require two separate physical units.

<h4>Differences between APT and Aptitude</h4>

  - Apt-get is a lower level package manager
  - Apt-get is restricted only to command line
  - Aptitude is a higher-level tool
  - Aptitude has a default text-only interactive interface along with option of command-line operation

<h4>What is APPArmor</h4>

  - APPArmor is a Linux kernel security module
  - Restrict programs from certain capabilities
  - Restricts and allows reading, writing and execute certain commands
  - For example one could restrict the web browser to only let users access files in their home directories
  - Check APPArmor Status : 
  
$<b>sudo aa-status</b>

<h4>Check UFW, SSH and Operating System</h4>

  - $<b>sudo service ufw status</b> : Check UFW Status
  - $<b>sudo service ssh status</b> : Check SSH Status
  - $<b>hostnamectl</b> : Check Operating System

<h4>User and Groups</h4>

User Information  
  
  - $<b>groups *rade-sar*</b> : Check groups of user *rade-sar*
  - $<b>getent group user42</b> : Check users from groups “user42”
  - $<b>getent group sudo</b> : Check users from groups “sudo”
  
Creating user and adding to the specified group
  
  - $<b>sudo adduser *username*</b> : Create new user called *username*
  - $<b>sudo vim /etc/login.defs</b> : Show Password Expiration Policy
  - $<b>sudo vim /etc/pam.d/common-password</b> : Show Password Policy
  - $<b>sudo addgroup evaluating</b> : Create new group called *evaluating*
  - $<b>sudo usermod -aG evaluating *username*</b> : Add user *username* to evaluating group

<h4>Hostname and Partitions</h4>

  - $<b>hostnamectl</b> : Check hostname
  - $<b>sudo hostnamectl set-hostname *newHostname*</b> : Change hostname
  - $<b>lsblk</b> : View Partitions
  
<h4>What is LVM</h4>

  - LVM allows for very flexible disk space management
  - It provides features like the ability to add disk space to a logical volume and its filesystem

<h4>Sudo</h4>

  - $<b>sudo adduser *username* sudo</b> : Add a new user to sudo group
  - $<b>cat /etc/sudoers.d/sudoconfig</b> : Check Sudo rules
  - $<b>lsblk</b> : View Partitions

<h4>UFW</h4>

  - $<b>sudo ufw status</b> : Check UFW status
  - $<b>sudo service ufw status</b> : List UFW rules
  - $<b>sudo ufw allow 8080</b> : Create rule for port 8080
  - $<b>sudo ufw delete allow 8080</b> : Delete rule for port 8080

<h4>SSH</h4>

  - $<b>sudo service ssh status</b> : Check that SSH Service is installed
  - $<b>sudo vim /etc/ssh/sshd_config</b> : Check SSH Settings && Port 4242
  - $<b>ssh *username*@127.0.0.1 -p 4242</b> : Login with a new user with SSH

<h4>Script</h4>

If you done this project, you know the commands and how to explain them. If you don't remmeber a command, click <a href="https://github.com/rafaelcoias/42_Born2beRoot/blob/main/GUIDE/README.md#script">here</a>.

<h4>Crontab</h4>

  - $<b>sudo crontab -e</b> : Access Crontab settings

</details>

<h3>I wish you the best luck !</h3>

