#!/usr/bin/env bash
#  MassInstallerScript.sh
#  Script version 1.1b
#
#  Created by Ali Sadykov on 01/04/2020.
#
# This is a Debian Installer Script for Products based on Ubuntu 18.04.xx. Script main version 2.3.1030 ©Ali Sadykov
# This script is not supported by ARM64 architecture (Raspberry Pi, etc...), thus preventing the correct Docker and other software functionality.
# If you wish to improve the script by adding logical parts and statements, please send your copy to the following email --> maintenanceos.mos@gmail.com Thank You!
# This software is absolutely free for personal use and any personal modification.
# Current Script version 2.4.03B Improvements Pending <-no commercial use->
# RUN THIS SCRIPT AS ROOT!
#variables:
DIR0="$( cd "$( dirname "${/MIS.sh}" )" >/dev/null 2>&1 && pwd )"
DIR1="/temp_data01/Massive-Installer-Script/"

clear

sleep 2
echo "============================================================="
sleep .1
echo "============================================================="
sleep .1
echo "===========  WELCOME TO THE MASS INSTALLER SCRIPT   ========="
sleep .1
echo "====== GIVE ME A SECOND TO CHECK YOUR INTERNET CONNECTION ==="
sleep .2
echo "============================================================="
sleep .2
echo "============================================================="
sleep 3

echo "@@@@@@@@@@@@ CHECKING YOUR INTERNET CONNECTION @@@@@@@@@@@@@@"
#Checking internet connection by resolving names
#If Ping doesn't work correctly this program/script will show an error and exit uppon that mentioned error.

if ping -q -c 5 -W 5 google.com >/dev/null; then
    echo "You have a Stable Internet Connection, The Installer may Proceed..."
else
    echo "You don't have a Stable Internet Connection, Please Fix any Inconsistencies regarding this Problem and Relaunch this Script Again. Thanks!"
    exit 1
fi

# In order for this script to work another package is needed that generates a beautiful choice screen
# If a server doesn't have it installed, Script will automatically install it

if dpkg -l | grep '^ii'| grep 'dialog'|  grep '1.3-20171209-1'; then
    echo "The Massive Installer Script will launch shortly..."
    sleep 3
else
    echo "No Package is Found on This Server! "
    echo "Installing the Package..."
    sleep 2
    for x in {1..100} ; do
        sleep .1    # do some work here
        apt-get install --yes dialog
        printf .
    done | pv -pt -i0.2 -s100 -w 80 > /dev/null
    dpkg -l | grep dialog
    echo "OK"
fi
if dpkg -l |grep 'git' | grep 'fast, scalable, distributed revision control system'; then
    echo "GIT is Active, Launching the Software. . ."
else
    echo "GIT is not Installed!"
    sleep 2
    echo "Installing GIT Automatically. . ."
    sleep 3
    for x in {1..100} ; do
        sleep .1    # do some work here
        apt-get install --yes git
        printf .
    done | pv -pt -i0.2 -s100 -w 80 > /dev/null
    echo "GIT has been Successfully Installed, Continuing . . . "
fi
# If the script finds that connection to the internet is OK then it will download necessary tools to install software on your server/machine
# Otherwise, it will automatically quit.

sleep 2
echo "|=|*|"
sleep .2
echo "|*|=|"
sleep .1
echo "|=|*|"
sleep .2
echo "|*|=|"
sleep .1
echo "|=|*|"
sleep .2
echo "|*|=|"
sleep .1
echo "|=|*|"
sleep .2
echo "|*|=|"
sleep .1
echo "|=|*|"
sleep .2
echo "|*|=|"
sleep 1

# This is command will determine wheather the directory exists or not
# If necessary packages are located in the right location this part of the script
# will skip any kind of data pull, otherwise it will clone data from Git Repo.

if [ -d ~/temp_data01/Massive-Installer-Script ]
    then
        echo "Directory: $DIR1 already exists..."
        sleep 1
        echo "No Updates were Found!"
    else
        echo "Generating Temporary Directory..."
        mkdir -p ~/temp_data01
        cd ~/temp_data01/
        echo "Loading Libraries..."
        git clone https://github.com/AliS2018/Massive-Installer-Script.git
        cd ~/temp_data01/Massive-Installer-Script/
        chmod +x Minecraftv1.4.2.sh
        chmod +x PMSI-V2.0.sh
        chmod +x Webmin.sh
        chmod +x VirtualBox2.0.sh
    echo "DONE..."
fi
echo "Loading Tools..."
sleep 5

HEIGHT=20
WIDTH=80
CHOICE_HEIGHT=5
BACKTITLE="Welcome to The Mass Installer Script v.1.2.4"
TITLE="Install Useful Software and Packages on Your Linux Operating System"

MENU="Choose one of the following options:"

OPTIONS=(1 "Install Apache2"
         2 "Install Cockpit Dashboard Manager"
         3 "Install Plex Media Server"
         4 "Install phpVirtualBox"
         5 "Install Minecraft Server"
         6 "Launch Docker Installation Manager"
         7 "Install Webmin"
         8 "Exit"
         9 "Remove Cache"
         10 "Check Data?")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
clear
case $CHOICE in
# Choices from N1 and N2 are just basic commands that come from Ubuntu's Repository,
# which is why we only need to make sure the packages are installed on the system or not.
# However when a person needs a software that was not initially added in a system's repo we use a script that add everything automatically
        1)
        if apt list --installed | grep apache2; then
            echo "Your System has Apache2 Installed and Updated! Skipping > > > > "
            sleep 3
        else
        sleep 1
            echo "Apache2 was Not Found on Your System! Continuing > > > > "
            sleep 1
            echo "The System is About to Install Apache2..."
            sleep 2
            for x in {1..100} ; do
                sleep .1    # do some work here
                apt-get install --yes apache2
                sleep 2
                ufw allow apache
                printf .
            done | pv -pt -i0.2 -s100 -w 80 > /dev/null
            echo "================DONE====================="
            echo "Returning to the Main page..."
            cd ~/temp_data01/Massive-Installer-Script/
            ./Mass-Installer.sh
            fi
            ;;
       2)
            echo "Installing Cockpit Dashboard Manager is in Progress..."
            sleep 4
            if apt list --installed | grep cockpit-dashboard; then
                echo "Your System has Cockpit Dashboard Installed and Updated! Skipping > > > > "
                sleep 3
                cd ~/temp_data01/Massive-Installer-Script/
                ./Mass-Installer.sh
            else
                sleep 1
                echo "Cockpit Dashboard was Not Found on Your System! Continuing > > > > "
                sleep 3
                for x in {1..100} ; do
                    sleep .1    # do some work here
                    apt-get install --yes cockpit
                    printf .
                done | pv -pt -i0.2 -s100 -w 80 > /dev/null
                echo "================DONE====================="
                sleep 2
                echo ""
                echo "*.."
                sleep 1
                echo ".*."
                sleep 1
                echo "..*"
                sleep 1
                echo "Returning to the Main page..."
                cd ~/temp_data01/Massive-Installer-Script/
                    ./Mass-Installer.sh
                fi
                  ;;
              3)
                  echo "Installing Plex Media Server is in Progress..."
                  sleep 4
                  if apt list --installed | grep plexmediaserver; then
                       echo "Your System has Plex Media Server Installed and Updated! Skipping > > > > "
                       sleep 3
                      cd ~/temp_data01/Massive-Installer-Script/
                       ./Mass-Installer.sh
                   else
                   sleep 1
                       echo "Plex Media Server was Not Found on Your System! Continuing > > > > "
                       sleep 3
                       cd ~/temp_data01/Massive-Installer-Script/
                       ./PMSI\ V2.0.sh
                       echo "================DONE====================="
                       fi
                  ;;
              4) echo "Installing VM VirtualBox Online Client is in Progress..."
                  sleep 4
                  if dpkg -l | grep virtualbox; then
                       echo "Your System has phpVirtualbox Installed and Updated! Skipping > > > > "
                       sleep 3
                      cd ~/
                      ./Mass-Installer.sh
                   else
                   sleep 1
                       echo "phpVirtualbox was Not Found on Your System! Continuing > > > > "
                       sleep 3
                       cd ~/temp_data01/Massive-Installer-Script/
                       ./VirtualBox.sh
                       echo "================DONE====================="
                       fi
                  ;;
              5)
                 echo "Installing Minecraft Server Client is in Progress..."
                  sleep 4
                  if [-d /var/minecraft]
                   then
                       echo "Minecraft Directory Already Exists! Skipping > > > > "
                       sleep 3
                      cd ~/
                      ./Mass-Installer.sh
                   else
                   sleep 1
                       echo "Minecraft Server directory was Not Found on Your System! Continuing > > > > "
                       sleep 3
                       cd ~/temp_data01/Massive-Installer-Script/
                       ./Minecraftv1.4.2.sh
                       echo "================DONE====================="
                       fi
                  ;;
              6)
                  echo "Launching Docker Management Panel. . . "
                   sleep 4
                   if apt list --installed | grep docker-ce-cli && dpkg -l | grep docker; then
                        echo "Your System has Docker/Docker-Compose Client Installed and Updated! Launching the Manager > > > > "
                        sleep 3
                        cd ~/temp_data01/Massive-Installer-Script/DockerManager/
                        chmod +x Launcher.sh
                        chmod +x Docker-Installer.sh
                        chmod +x OracleSQLv1.3.2.sh
                        chmod +x WordPress.sh
                        ./Launcher.sh
                    else
                        sleep 1
                        echo "Docker and Docker Compose was Not Found on Your System! Continuing > > > > "
                        sleep 3
                        RED='\033[0;31m'
                        NC='\033[0m'
                        printf "${RED}Docker Launcher Failed Loading Necessary Tools ! ! ! ${NC}"
                        cd ~/temp_data01/Massive-Installer-Script/DockerManager/
                        echo "Loading an Auto-Installer Script to Run this Set of tools!"
                        sleep 2
                        echo "NOTE: Restart this script after The installation has been fully completed!"
                        ./Docker-Installer.sh
                        echo -e "${RED}Docker Launcher Failed Loading Necessary Tools ! ! ! ${NC}"
                        exit 3
                    fi
                  ;;
              7)
                    echo "Installing Webmin is in Progress..."
                        sleep 4
                    if dpkg -l | grep webmin; then
                        echo "Your system has Webmin client installed and updated! Skipping > > > > "
                        sleep 3
                       cd ~/temp_data01/Massive-Installer-Script/
                        ./Mass-Installer.sh
                    else
                        sleep 1
                        echo "Webmin was not found on your system! Continuing > > > > "
                        sleep 3
                        cd ~/temp_data01/Massive-Installer-Script/
                        ./Webmin.sh
                        echo "================DONE====================="
                    fi
                  ;;
              8)
                        echo "Exit Sequence has been Initiated..."
                             echo "Restarting Plex Media Server..."
                             sleep 1
                               service plexmediaserver restart
                             echo "Restarting Webmin Server..."
                             sleep 1
                               service webmin restart
                             echo "Restarting VirtualBox Drivers..."
                             sleep 1
                               service vboxdrv restart
                             echo "Restarting Docker..."
                             sleep 1
                               service docker restart
                             echo "Restarting Cockpit Dashboard..."
                             sleep 1
                               service cockpit restart
                         echo " ===== THANKS FOR USING MASS INSTALLER SCRIPT ====="
                               exit 0
                  ;;
              9)
              echo "Cleaning up..."
                        sleep 2
                        cd /
                        echo "Flushing Services and Cache..."
                        sleep 2
                        rm -rf ~/temp_data01/
                        sleep 2
                        echo "Cache Cleanup Completed !!!"
                    exit 0
                  ;;
              10)
            echo "NOT AVAILABLE YET !"
            echo "MAYBE ADD SOME UPDATE MECHANISM?"
                  ;;
esac
