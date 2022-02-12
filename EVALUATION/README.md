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
  - Important Commands

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

  - $<b>groups *rade-sar*</b> : Check groups of user *rade-sar*
  - $<b>getent group user42</b> : Check users from groups “user42”
  - $<b>getent group sudo</b> : Check users from groups “sudo”
  


<h4>Hostname and Partitions</h4>



<h4>Sudo</h4>



<h4>UFW</h4>



<h4>SSH</h4>



<h4>Script</h4>



<h4>Crontab</h4>


</details>

<h3>Important Commands</h3>



