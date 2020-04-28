#!/usr/bin/env bash
#  MassInstallerScript.sh
#  Script version 1.1b
#
#  Created by Ali Sadykov on 01/04/2020.
#
# This is a Debian Installer Script for Products based on Ubuntu 18.04.xx. Script main version 2.2.1551 ©Ali Sadykov
# This script is not supported by ARM64 architecture (Raspberry Pi, etc...), thus preventing the correct Docker and other software functionality.
# If you wish to improve the script by adding logical parts and statements, please send your copy to the following email --> maintenanceos.mos@gmail.com Thank You!
# This software is absolutely free for personal use and any personal modification.
# Current Script version 2.2.92B Improvements Pending <-no commercial use->
# RUN THIS SCRIPT AS ROOT!
#variables:
DIR0="/temp_data01"
DIR1="/temp_data01/Massive-Installer-Script/"
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
if ping -q -c 5 -W 5 google.com >/dev/null;
then
    echo "You have a Stable Internet Connection, The Installer may proceed..."
else
    echo "You don't have a Stable Internet connection, please fix any errors/issues regarding this problem and relaunch this Script again. Thanks!"
    exit 1
fi

 # In order for this script to work another package is needed that generates a beautiful choice screen
 # If a server doesn't have it installed, Script will automatically install it
if dpkg -l | grep '^ii'| grep 'dialog'|  grep '1.3-20171209-1'; then
    echo "The Massive Installer Script will launch shortly..."
    sleep 5
else
    echo "NO (dialog) package is found on this server! "
    echo "installing the package..."
    apt-get install --yes dialog
    dpkg -l | grep dialog
    echo "OK"
fi
# If the script find that connection to the internet is OK then it will download necessary tools to install software on your server/machine
# Otherwise, it will automatically quit.
sleep 2
echo "|=|*|"
sleep .1
echo "|*|=|"
sleep .1
echo "|=|*|"
sleep .1
echo "|*|=|"
sleep .1
echo "|=|*|"
sleep .1
echo "|*|=|"
sleep .1
echo "|=|*|"
sleep .1
echo "|*|=|"
sleep .1
echo "|=|*|"
sleep .1
echo "|*|=|"
sleep 1


if [ -d ~/temp_data01/Massive-Installer-Script ]
    then
        echo "Error,directory: $DIR1 already exists, no need in retreiving new data..."
    else
        echo "Generating Temporary directory..."
        mkdir -p ~/temp_data01
        cd ~/temp_data01/
        echo "Loading Libraries..."
        git clone https://github.com/AliS2018/Massive-Installer-Script.git
        cd ~/temp_data01/Massive-Installer-Script/
        chmod +x DockerInstall.sh
        chmod +x Minecraftv1.4.2.sh
        chmod +x OracleSQLv1.3.2.sh
        chmod +x PMSI\ V2.0.sh
        chmod +x Webmin.sh
        chmod +x VirtualBox.sh
    echo "DONE..."
fi

sleep 10
HEIGHT=20
WIDTH=80
CHOICE_HEIGHT=5
BACKTITLE="Welcome to The Massive Installer Script v.1.0"
TITLE="Install useful packages and software on your Linux Operating System"

MENU="Choose one of the following options:"

OPTIONS=(1 "Install Apache2"
         2 "Install Cockpit Dashboard Manager"
         3 "Install Plex Media Server"
         4 "Install phpVirtualBox"
         5 "Install Minecraft Server"
         6 "Install Docker"
         7 "Install OracleSQL Database"
         8 "Install Webmin"
         9 "Install *UNAVAILABLE*"
         10 "Exit and remove cache")

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
            echo "Your system has Apache2 installed and updated! Skipping>>>>"
            sleep 3
            exit 1
            cd ~/
            ./MIS.sh
        else
        sleep 1
            echo "Apache2 was not found on your system! Continuing>>>>"
            sleep 1
            echo "The system is about to install apache2..."
            sleep 2
            apt-get install --yes apache2
            ufw allow apache
            echo "================DONE====================="
            echo "Returning to the Main page..."
            cd ~/
            ./MIS.sh
            fi
            ;;
        2)
            echo "Installing Cockpit Dashboard Manager is in progress..."
            sleep 4
           if apt list --installed | grep cockpit-dashboard; then
                      echo "Your system has Cockpit Dashboard installed and updated! Skipping>>>>"
                      sleep 3
                      cd ~/
                      ./MIS.sh
                  else
                  sleep 1
                      echo "Cockpit Dashboard was not found on your system! Continuing>>>>"
                      sleep 3
                      apt-get install --yes cockpit
                      echo "================DONE====================="
                      echo "Returning to the Main page..."
                       cd ~/
                      ./MIS.sh
                      fi
            ;;
        3)
            echo "Installing Plex Media Server is in progress..."
            sleep 4
            if apt list --installed | grep plexmediaserver; then
                 echo "Your system has Plex Media Server installed and updated! Skipping>>>>"
                 sleep 3
                 cd ~/
                ./MIS.sh
             else
             sleep 1
                 echo "Plex Media Server was not found on your system! Continuing>>>>"
                 sleep 3
                 cd ~/temp_data01/Massive-Installer-Script/
                 ./PMSI\ V2.0.sh
                 echo "================DONE====================="
                 fi
            ;;
        4) echo "Installing Virtualbox online client is in progress..."
            sleep 4
            if dpkg -l | grep virtualbox; then
                 echo "Your system has phpVirtualbox installed and updated! Skipping>>>>"
                 sleep 3
                cd ~/
                ./MIS.sh
             else
             sleep 1
                 echo "phpVirtualbox was not found on your system! Continuing>>>>"
                 sleep 3
                 cd ~/temp_data01/Massive-Installer-Script/
                 ./VirtualBox.sh
                 echo "================DONE====================="
                 fi
            ;;
        5)
           echo "Installing Minecraft server client is in progress..."
            sleep 4
            if [-d /var/minecraft]
             then
                 echo "Minecraft directory Exists! Skipping>>>>"
                 sleep 3
                cd ~/
                ./MIS.sh
             else
             sleep 1
                 echo "Minecraft Server directory was not found on your system! Continuing>>>>"
                 sleep 3
                 cd ~/temp_data01/Massive-Installer-Script/
                 ./Minecraftv1.4.2.sh
                 echo "================DONE====================="
                 fi
            ;;
        6)
            echo "Installing Docker is in Progress..."
             sleep 4
             if apt list --installed | grep docker-ce-cli && dpkg -l | grep docker; then
                       echo "Your system has Docker/Docker-Compose client installed and updated! Skipping>>>>"
                       sleep 3
                       cd ~/
                      ./MIS.sh
                   else
                   sleep 1
                       echo "Docker and Docker Compose was not found on your system! Continuing>>>>"
                       sleep 3
                       cd ~/temp_data01/Massive-Installer-Script/
                       ./DockerInstall.sh
                       echo "================DONE====================="
                       fi
            ;;
        7)
              echo "Installing OracleSQL is in Progress..."
                       sleep 4
                       if dpkg -l | grep docker; then
                                 echo "Your system has Docker/Docker-Compose client installed and updated! Continuing>>>>"
                                 sleep 2
                                 cd ~/temp_data01/Massive-Installer-Script/
                                    ./OracleSQLv1.3.2.sh
                             else
                             sleep 1
                                 echo "No Docker was found on your system! <!> <!> <!> <!> "
                                 sleep 3
                                 echo "Please Install Docker first and only then start this installer!"
                                 sleep 5
                                 cd ~/
                                    ./MIS.sh
                                 echo "================DONE====================="
                       fi
            ;;
        8)
            echo "Installing Webmin is in Progress..."
                        sleep 4
                        if dpkg -l | grep webmin; then
                                  echo "Your system has Webmin client installed and updated! Skipping>>>>"
                                  sleep 3
                                  cd ~/
                                 ./MIS.sh
                              else
                              sleep 1
                                  echo "Webmin was not found on your system! Continuing>>>>"
                                  sleep 3
                                  cd ~/temp_data01/Massive-Installer-Script/
                                  ./Webmin.sh
                                  echo "================DONE====================="
                                  fi
            ;;
        9)
            echo "NO ENTRIES..."
            exit 3
            ;;
        10)
            echo "Cleaning up..."
            sleep 2
            cd /
            echo "Flushing services and cache..."
            sleep 2
            rm -rf ~/temp_data01/
            docker system prune -a
            sleep 2
            echo "Cleaning Cache completed"
            exit 0
            ;;
esac
