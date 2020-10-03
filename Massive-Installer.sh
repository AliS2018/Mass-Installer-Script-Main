#!/usr/bin/env bash
#  MassInstallerScript.sh
#  Script version 2.4b
#
#  Created by Ali Sadykov on 01/04/2020.
#
# This is a Debian Installer Script for Products based on Ubuntu 18.04.xx.
# Script main version 2.4.0548 ©Ali Sadykov

# This script is not supported by ARM64 architecture (Raspberry Pi, etc...),
# thus preventing the correct Docker and other software functionality.

# If you wish to improve the script by adding logical parts and statements,
# please send your copy to the following email --> maintenanceos.mos@gmail.com Thank You!

# This software is absolutely free for personal use and the author of this
# piece of software gives exclusive rights to modify and improve uppon this
# script.

# Current Script version 2.4.03B Improvements Pending <-no commercial use->

# RUN THIS SCRIPT AS ROOT!
#variables:
        DIR1="/temp_data01/Massive-Installer-Script/"
        DIR2="cd ~/temp_data01/Massive-Installer-Script/"
        DIR3="cd ~/"
        DIR4="cd ~/temp_data01/Massive-Installer-Script/Docker_Dashboard/"
# Location for Executable Script Loaders <øs>
        SW1="./Launcher.sh"
        SW2="./Massive-Installer.sh"
# Main Scripts to Execute <ex>
        XBLE1="./Minecraftv1.4.2.sh"
        XBLE2="./PMSI-V2.0.sh"
        XBLE3="./Webmin.sh"
        XBLE4="./VirtualBox2.0.sh"

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

    # Checking internet connection by resolving names, hostanmes and/or ips
    # If ping doesn't work as properly this script will display an error
    # and exit the script uppon the aforementioned error.

        if ping -q -c 5 -W 5 google.com >/dev/null; then
            echo "You have a Stable Internet Connection, The Installer may Proceed..."
        else
            echo "You don't have a Stable Internet Connection, Please Fix any
            Inconsistencies regarding this Problem and Relaunch this Script
            Again. Thanks!"
            clear
            echo "Exit, Error 1"
            exit 1
        fi

    # a few packages are needed to run this software, this script Automatically
    # verifies whether the server has these packages installed and if not
    # it installs them automatically


#Package 1 (dialog)
        if dpkg --get-selections | grep 'dialog' \
        | grep 'Displays user-friendly dialog boxes from shell scripts'; then
            echo "The Massive Installer will launch shortly..."
            sleep 3
        else
            echo "Installing the Package..."
            sleep 2
                apt-get install --yes dialog
            sleep 2
            echo "DONE"
            echo ""
            echo ""
            echo "Verifying the package"
        if dpkg -l | grep dialog; then
              sleep 2
            echo "Software is on the system! Verification is completed."
          else
            echo "This script has found some errors, correct them and run this script again"
            exit 1
          fi
        fi
#Package 2 (git)
        if dpkg -l |grep 'git' | \
        grep 'fast, scalable, distributed revision control system'; then
            echo "GIT is Active, Launching the Software. . ."
        else
            echo "GIT is not Installed!"
            sleep 2
            echo "Installing GIT Automatically. . ."
            sleep 3
                apt-get install --yes git
            echo "GIT has been Successfully Installed, Continuing . . . "
        fi
    # If the script finds that connection to the internet is OK then it will
    # download necessary tools to install software on your server/machine
    # Otherwise, it will automatically quit.
sleep 2
echo "|=|*|"
sleep .2
echo "|*|=|"
sleep 1
echo "|=|*|"
sleep .2
echo "|*|=|"
sleep .1
echo "|=|*|"
sleep 1
echo "|*|=|"
sleep 1

# This is command will determine wheather the directory exists or not
# If necessary packages are located in the right location this part of the script
# will skip any kind of data pull, otherwise it will clone data from Git Repo.

if [ -d ~/temp_data01/Massive-Installer-Script ]
    then
        echo "Directory: $DIR1 already exists..."
        sleep 1
        echo "No Updates were found!"
    else
        sleep 2
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
BACKTITLE="Welcome to The Mass Installer Script v.2.4.5"
TITLE="Install Useful Software and Packages on Your Linux Operating System"
MENU="Choose one of the following options:"
OPTIONS=(1 "Install Apache2 <|INSTALL|>"
         2 "Install Cockpit Dashboard Manager <|INSTALL|>"
         3 "Install Plex Media Server <|LAUNCH|>"
         4 "Install phpVirtualBox <|LAUNCH|>"
         5 "Install Minecraft Server <|LAUNCH|>"
         6 "<|LAUNCH|> Docker Installation Manager"
         7 "Install Webmin <|LAUNCH|>"
         8 "Install Pi-Hole ADBlocker <|LAUNCH|>"
         9 "Exit"
         10 "Remove Cache"
         11 "System Information <|LAUNCH|>")
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
        if dpkg -l | grep 'apache2'; then
            echo "Your System has Apache2 Installed and Updated! Skipping > > > > "
            sleep 3
        else
        sleep 1
            echo "Apache2 was Not Found on Your System! Continuing > > > > "
            sleep 1
            echo "The System is About to Install Apache2..."
            sleep 2
            apt-get install apache2 --yes
            echo "================DONE====================="
            echo "Returning to the Main page..."
            $DIR3
            $SW2
            fi
            ;;
        2)
            echo "Cockpit Dashboard Manager Installation is in Progress..."
            sleep 4
            if dpkg -l | grep 'cockpit-dashboard'; then
                echo "Your System has Cockpit Dashboard Installed and Updated! Skipping > > > > "
                sleep 3
                $DIR3
                $SW2
            else
                sleep 1
                echo "Cockpit Dashboard was Not Found on Your System! Continuing > > > > "
                sleep 3
                    apt-get install --yes cockpit
                echo "================DONE====================="
                sleep 2
                echo "Returning to the Main page..."
                $DIR3
                $SW2
                fi
                  ;;
        3)
                  echo "Plex Media Server Installation is in Progress..."
                  sleep 4
                  if apt list --installed | grep 'plexmediaserver'; then
                       echo "Your System has Plex Media Server Installed and Updated! Skipping > > > > "
                       sleep 3
                       $DIR3
                       $SW2
                   else
                   sleep 1
                       echo "Plex Media Server was Not Found on Your System! Continuing > > > > "
                       sleep 3
                       $DIR2
                       $XBLE2
                       echo "================DONE====================="
                       fi
                  ;;
        4) echo "VM VirtualBox Online Client Installation is in Progress..."
                  sleep 4
                  if dpkg -l | grep 'virtualbox'; then
                       echo "Your System has phpVirtualbox Installed and Updated! Skipping > > > > "
                       sleep 3
                       $DIR3
                       $SW2
                   else
                   sleep 1
                       echo "phpVirtualbox was Not Found on Your System! Continuing > > > > "
                       sleep 3
                       $DIR2
                       $XBLE4
                       echo "================DONE====================="
                       fi
                  ;;
        5)
                 echo "Minecraft Server Client Installation is in Progress..."
                  sleep 4
                  if [-d /var/minecraft]
                   then
                       echo "Minecraft Directory Already Exists! Skipping > > > > "
                       sleep 3
                      $DIR3
                      $SW2
                   else
                   sleep 1
                       echo "Minecraft Server directory was Not Found on Your System! Continuing > > > > "
                       sleep 3
                       $DIR2
                       $XBLE1
                       echo "================DONE====================="
                       fi
                  ;;
        6)
                  echo "Launching Docker Management Dashboard. . . "
                   sleep 4
                   if apt list --installed | grep docker-ce-cli && dpkg -l | grep docker; then
                        echo "Your System has Docker/Docker-Compose Client Installed and Updated! Launching the Manager > > > > "
                        sleep 3
                        $DIR4
                        chmod +x Launcher.sh
                        chmod +x Docker-Installer.sh
                        chmod +x OracleSQLv1_4.sh
                        chmod +x WordPress.sh
                        $SW1
                    else
                        sleep 1
                        echo "Docker and Docker Compose were Not Found on Your System! Continuing > > > > "
                        sleep 3
                        RED='\033[0;31m'
                        NC='\033[0m'
                        printf "${RED}Docker Launcher Failed Loading Necessary Tools ! ! ! ${NC}"
                        $DIR4
                        echo "Loading an Auto-Installer Script to Run this Set of Tools!"
                        chmod +x Docker-Installer.sh
                        sleep 2
                        echo "NOTE: Run this script again after the installation has been fully completed!"
                        ./Docker-Installer.sh
                        echo -e "${RED}Docker Launcher Failed Loading Necessary Tools ! ! ! ${NC}"
                        exit 3
                    fi
                  ;;
        7)
                    echo "Webmin Installation is in Progress..."
                        sleep 4
                    if dpkg -l | grep webmin; then
                        echo "Your system has Webmin Client Installed and Updated! Skipping > > > > "
                        sleep 3
                        $DIR3
                        $SW2
                    else
                        sleep 1
                        echo "Webmin was not found on your system! Continuing > > > > "
                        sleep 3
                        $XBLE3
                        echo "================DONE====================="
                    fi
                  ;;
        8)     curl -sSL https://install.pi-hole.net | bash
                  ;;
        9)
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
                         echo " ===== THANKS FOR USING MASSIVE INSTALLER SCRIPT ====="
                               exit 0
                  ;;
        10)
              echo "Cleaning up..."
                        sleep 2
                        cd /
                        echo "Flushing Services and Cache..."
                        sleep 2
                        rm -rf ~/temp_data01/
                        sleep 1
                            sleep 1
                                if systemctl is-active --quiet plexmediaserver
                                    then
                                    echo "Service is currently active"
                                    service plexmediaserver restart
                                    echo "Restarting Plex Media Server..."
                                else
                                    echo "Continuing..."
                                fi
                                if systemctl is-active --quiet webmin
                                    then
                                    echo "Service is currently active"
                                    service webmin restart
                                    echo "Restarting Webmin Server..."
                                else
                                    echo "Continuing..."
                                fi
                                if systemctl is-active --quiet vboxdrv
                                    then
                                    echo "Service is currently active"
                                    service vboxdrv restart
                                    echo "Restarting VirtualBox Drivers..."
                                else
                                    echo "Continuing..."
                                fi
                                if systemctl is-active --quiet docker
                                    then
                                    echo "Service is currently active"
                                    service docker restart
                                    echo "Restarting Docker..."
                                else
                                    echo "Continuing..."
                                fi
                                echo "Restarting Cockpit Dashboard..."
                                sleep 1
                                service cockpit restart
                        echo "Cache Cleanup Completed !!!"
                    exit 0
                  ;;
        11)
              clear
              display_result() {
                dialog --title "$1" \
                  --no-collapse \
                  --msgbox "$result" 0 0
              }
              while true; do
              exec 3>&1
              selection=$(dialog \
                --backtitle "System Management Dashboard" \
                --title "Choose Options <|_|-|>" \
                --clear \
                --cancel-label "Exit" \
                --menu "Please select:" $HEIGHT $WIDTH 4 \
                "1" "System Information" \
                "2" "Disk Storage" \
                "3" "Local Users" \
                "4" "Update the Installer" \
                "5" "<|_| Return |_|>" \
                2>&1 1>&3)

              case $selection in
                0 )
                  clear
                 cd ~/
                 ./Massive-Installer.sh
                  ;;
                1 )
                  result=$(echo "Hostname: $HOSTNAME"; uptime)
                  display_result "System Information"
                  ;;
                2 )
                  result=$(df -h)
                  display_result "Disk Storage"
                  ;;
                3 )
                  if [[ $(id -u) -eq 0 ]]; then
                    result=$(du -sh /home/* 2> /dev/null)
                    display_result "Local Users"
                  else
                    result=$(du -sh $HOME 2> /dev/null)
                    display_result "Local Users ($USER)"
                  fi
                  ;;
                 4 )
                 clear
                 echo "Error Code: 0"
                 sleep 1
                  exit 0
                  ;;
                  5 )
                  clear
                  cd ~/
                  ./Massive-Installer.sh
                   ;;
              esac
              done
                  ;;
esac
