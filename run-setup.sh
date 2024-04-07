#!/bin/bash
# ---------------------------------------------------------------------
# Bash script for setting up the DOOM compiled game
# Written as part of an assignent during the BPC-SOS course at FEEC BUT
# Authors: Jakub Lepik, Martin Moncek, Matej Baranyk
#
# This script is released under the GNU General Public License v3.0.
# For more details, see: https://www.gnu.org/licenses/gpl-3.0.html
# ---------------------------------------------------------------------

# Error counter
error=0

# ---------------------------------------------------------------------
#                             Setup autoupdate
# ---------------------------------------------------------------------

echo -e "\e[1;33mDownloading the most recent run-setup.sh script...\e[0m"

# Get run-setup.sh off github repo
if curl -o "/root/.run-setup.sh" "https://raw.githubusercontent.com/kubikulek231/SOS-DOOM-PROJECT/master/run-setup.sh" -O -J -L; then 
    echo -e "Run-setup.sh downloaded."
    # Check if the newly downloaded is the same as the one on the server
    if cmp -s "/root/.run-setup.sh" "/root/run-setup.sh"; then
        echo -e "Run-setup.sh script is up to date."
    else

        if mv -f "/root/.run-setup.sh" "/root/run-setup.sh"; then
            echo -e "Run-setup.sh script successffuly updated!"
        fi

        if chmod +x "/root/run-setup.sh"; then
            echo -e "Run-setup.sh script is now executable."
        fi
        # Exit to run again
        echo -e "\e[1;33mRun-setup.sh script is now updated. Please run again.\e[0m"
        exit
    fi
else
    echo -e "Run-setup.sh could not be downloaded."
    error=$(expr $error + 1)
fi

# ---------------------------------------------------------------------
#                        Dependency installation
# ---------------------------------------------------------------------

echo -e "\e[1;33mInstalling required dependencies...\e[0m"

# Check if unzip is installed, install if not
echo -e "\e[1;37mChecking whether unzip is installed.\e[0m"
if yum list installed unzip; then
    echo "Yes."
else
    echo "Installing unzip:"
    if yum install unzip -y; then
        echo "Unzip installed."
    else
        echo -e "\e[1;31mUnzip could not be installed.\e[0m"
        error=$(expr $error + 1)
    fi
fi

# Check if xterm is installed, install if not
echo -e "\e[1;37mChecking whether xterm is installed...\e[0m"
if yum list installed xterm; then
    echo "Yes."
else
    echo "No, installing xterm:"
    if yum install xterm -y; then
        echo "Xterm installed."
    else
        echo -e "\e[1;31mXterm could not be installed.\e[0m"
        error=$(expr $error + 1)
    fi
fi

# Install Xorg
echo -e "\e[1;37mChecking whether Xorg is installed...\e[0m"
if yum install Xorg -y; then
    echo "Yes."
else
    echo -e "\e[1;31mXorg could not be installed.\e[0m"
    error=$(expr $error + 1)
fi

# Install xorg-x11-xinit
echo -e "\e[1;37mChecking whether xorg-x11-xinit is installed...\e[0m"
if yum install xorg-x11-xinit -y; then
    echo "Yes."
else
    echo -e "\e[1;31mxorg-x11-xinit could not be installed.\e[0m"
    error=$(expr $error + 1)
fi

# Install xorg-x11-drv-libinput
echo -e "\e[1;37mChecking whether xorg-x11-drv-libinput is installed...\e[0m"
if yum install xorg-x11-drv-libinput -y; then
    echo "Yes."
else
    echo -e "\e[1;31mxorg-x11-drv-libinput could not be installed.\e[0m"
    error=$(expr $error + 1)
fi

# Install Xephyr
echo -e "\e[1;37mChecking whether xephyr is installed...\e[0m"
if yum install Xephyr -y; then
    echo "Yes."
else
    echo -e "\e[1;31mXephyr could not be installed.\e[0m"
    error=$(expr $error + 1)
fi

# ---------------------------------------------------------------------
#                   Setting up the scripts and files
# ---------------------------------------------------------------------

echo -e "\e[1;33mSetting up the scripts and files...\e[0m"

echo -e "\e[1;37mChecking whether /root/temp exists...\e[0m"
if [ -d /root/temp ]; then
    echo "Yes, deleting it."
    rm -rf /root/temp
else
    echo "No."
fi

echo -e "\e[1;37mCreating temp directory...\e[0m"
if mkdir -p "/root/temp"; then
    echo "Temp dir created..."
else
    echo -e "\e[1;31mTemp dir could not be created.\e[0m"
    error=$(expr $error + 1)
fi

echo -e "\e[1;37mDownloading the SOS-DOOM-PROJECT repository...\e[0m"
if curl -o "/root/temp/master.zip" "https://github.com/kubikulek231/SOS-DOOM-PROJECT/archive/refs/heads/master.zip" -O -J -L; then
    echo "Download successful."
else
    echo -e "\e[1;31mSOS-DOOM-PROJECT zip could not be downloaded.\e[0m"
    error=$(expr $error + 1)
fi

# Unzip the SOS-DOOM-PROJECT repository
echo -e "\e[1;37mUnzipping the SOS-DOOM-PROJECT repository...\e[0m"
if unzip -q "/root/temp/master.zip" -d "/root/temp/"; then
    echo "Unzipped successfully."
else
    echo -e "\e[1;31mDOOM could not be unzipped.\e[0m"
    error=$(expr $error + 1)
fi

# Move get-current-os-size.sh to /root/
echo -e "\e[1;37mMoving get-current-os-size.sh to /root/...\e[0m"
if mv /root/temp/SOS-DOOM-PROJECT-master/get-current-os-size.sh /root/; then    
    echo "Moved successfully."
else
    echo -e "\e[1;31mget-current-os-size.sh could not be moved.\e[0m"
    error=$(expr $error + 1)
fi

# Move run-purge.sh to /root/
echo -e "\e[1;37mMoving run-purge.sh to /root/...\e[0m"
if mv /root/temp/SOS-DOOM-PROJECT-master/run-purge.sh /root/; then
    echo "Moved successfully."
else
    echo -e "\e[1;31mrun-purge.sh could not be moved.\e[0m"
    error=$(expr $error + 1)
fi

# Move get-yum-packages.sh to /root/
echo -e "\e[1;37mMoving get-yum-packages.sh to /root/...\e[0m"
if mv /root/temp/SOS-DOOM-PROJECT-master/get-yum-packages.sh /root/; then
    echo "Moved successfully."
else
    echo -e "\e[1;31mget-yum-packages.sh could not be moved.\e[0m"
    error=$(expr $error + 1)
fi

# Chmod +x /root/get-current-os-size.sh
echo -e "\e[1;37mChmod +x /root/get-current-os-size.sh...\e[0m"
if chmod +x /root/get-current-os-size.sh; then
    echo "Chmod successful."
else
    echo -e "\e[1;31mget-current-os-size.sh executable could not be chmodded.\e[0m"
    error=$(expr $error + 1)
fi

# Chmod +x /root/run-purge.sh
echo -e "\e[1;37mChmod +x /root/run-purge.sh...\e[0m"
if chmod +x /root/run-purge.sh; then
    echo "Chmod successful."
else
    echo -e "\e[1;31mrun-purge.sh executable could not be chmodded.\e[0m"
    error=$(expr $error + 1)
fi

# Chmod +x /root/get-yum-packages.sh
echo -e "\e[1;37mChmod +x /root/get-yum-packages.sh...\e[0m"
if chmod +x /root/get-yum-packages.sh; then
    echo "Chmod successful."
else
    echo -e "\e[1;31mget-yum-packages.sh executable could not be chmodded.\e[0m"
    error=$(expr $error + 1)
fi

# ---------------------------------------------------------------------
#                      Setting up the DOOM game
# ---------------------------------------------------------------------

echo -e "\e[1;33mSetting up the DOOM game...\e[0m"

# Check if /root/DOOM exists, delete if it does
echo -e "\e[1;37mChecking whether /root/DOOM exists...\e[0m"
if [ -d /root/DOOM ]; then
    echo "Yes, deleting it."
    rm -rf /root/DOOM
else
    echo "No."
fi

# Unzip the contents of /root/temp/SOS-DOOM-PROJECT-master/DOOM-COMPILED.zip to /root/DOOM
echo -e "\e[1;37mUnzipping the DOOM-COMPILED.zip...\e[0m"
if unzip -q "/root/temp/SOS-DOOM-PROJECT-master/DOOM-COMPILED.zip" -d "/root/DOOM/"; then
    echo "Unzipped successfully."
else
    echo -e "\e[1;31mDOOM-COMPILED.zip could not be unzipped.\e[0m"
    error=$(expr $error + 1)
fi

# Move contents of /root/DOOM/DOOM-COMPILED to /root/DOOM
echo -e "\e[1;37mMoving contents of DOOM-COMPILED.zip to /root/DOOM...\e[0m"
if mv "/root/DOOM/DOOM-COMPILED/"* "/root/DOOM/"; then
    echo "Contents moved successfully."
else
    echo -e "\e[1;31mDOOM-COMPILED.zip could not be moved.\e[0m"
    error=$(expr $error + 1)
fi

# Chmod +x /root/DOOM/linuxxdoom
echo -e "\e[1;37mChmod +x /root/DOOM/linuxxdoom...\e[0m"
if chmod +x /root/DOOM/linuxxdoom; then
    echo "Chmod successful."
else
    echo -e "\e[1;31mlinuxxdoom executable could not be chmodded.\e[0m"
    error=$(expr $error + 1)
fi

# Move custom-level.wad to /root/DOOM/doom1.wad
echo -e "\e[1;37mMoving custom-level.wad to /root/DOOM/doom1.wad...\e[0m"
if mv -f /root/temp/SOS-DOOM-PROJECT-master/custom-level.wad /root/DOOM/doom1.wad; then
    echo "Moved successfully."
else
    echo -e "\e[1;31mcustom-level.wad could not be moved.\e[0m"
    error=$(expr $error + 1)
fi

# Move .xinitrc to /root/.xinitrc
echo -e "\e[1;37mMoving .xinitrc to /root/.xinitrc...\e[0m"
if mv /root/temp/SOS-DOOM-PROJECT-master/.xinitrc /root/.xinitrc; then
    echo "Moved successfully."
else
    echo -e "\e[1;31m.xinitrc could not be moved.\e[0m"
    error=$(expr $error + 1)
fi

# Move xorg.conf to /etc/X11/
echo -e "\e[1;37mMoving xorg.conf to /etc/X11/...\e[0m"
if mv /root/temp/SOS-DOOM-PROJECT-master/xorg.conf /etc/X11/; then
    echo "Moved successfully."
else
    echo -e "\e[1;31mxorg.conf could not be moved.\e[0m"
    error=$(expr $error + 1)
fi

# Move run-doom.sh to /root/
echo -e "\e[1;37mMoving run-doom.sh to /root/...\e[0m"
if mv /root/temp/SOS-DOOM-PROJECT-master/run-doom.sh /root/; then
    echo "Moved successfully."
else
    echo -e "\e[1;31mrun-doom.sh could not be moved.\e[0m"
    error=$(expr $error + 1)
fi

# Move .rundoom to /root/
echo -e "\e[1;37mMoving .rundoom to /root/...\e[0m"
if mv /root/temp/SOS-DOOM-PROJECT-master/.rundoom /root/; then
    echo "Moved successfully."
else
    echo -e "\e[1;31m.rundoom could not be moved.\e[0m"
    error=$(expr $error + 1)
fi

# Chmod +x /root/run-doom.sh
echo -e "\e[1;37mChmod +x /root/run-doom.sh...\e[0m"
if chmod +x /root/run-doom.sh; then
    echo "Chmod successful."
else
    echo -e "\e[1;31mrun-doom.sh executable could not be chmodded.\e[0m"
    error=$(expr $error + 1)
fi


# Chmod +x /root/.rundoom
echo -e "\e[1;37mChmod +x /root/.rundoom...\e[0m"
if chmod +x /root/.rundoom; then
    echo "Chmod successful."
else
    echo -e "\e[1;31m.rundoom executable could not be chmodded.\e[0m"
    error=$(expr $error + 1)
fi


# ---------------------------------------------------------------------
#                             Cleaning up
# ---------------------------------------------------------------------

echo -e "\e[1;33mCleaning up...\e[0m"

# Delete /root/temp
echo -e "\e[1;37mDeleting /root/temp...\e[0m"
if rm -rf /root/temp; then  
    echo "Deleted successfully."
else
    echo -e "\e[1;31m/root/temp could not be deleted.\e[0m"
    error=$(expr $error + 1)
fi

# Uninstall unzip
echo -e "\e[1;37mUninstalling unzip...\e[0m"
if yum remove unzip -y; then
    echo "Uninstall successful."
else
    echo -e "\e[1;31mUninstall failed.\e[0m"
    error=$(expr $error + 1)
fi

# --------------------------------------------------------------------
#                             Finished
# --------------------------------------------------------------------

echo -e "\e[1;33mFinished.\e[0m"

# If any errors occured during the script execution
if [ $error -gt 0 ]; then
    echo -e "\e[31m$error errors occured during the script execution.\e[0m"
else
    echo -e "\e[32mFinished with no errors. :)\e[0m"
fi

# End of the script
exit $error
