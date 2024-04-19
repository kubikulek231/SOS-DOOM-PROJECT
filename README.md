# SOS-DOOM-PROJECT

<p align="center">
  <img src="doom-logo-ds.png" alt="DOOM game logo" />
</p>

This repository contains setup and purge scripts and a slightly modified and compiled version of [original DOOM game](https://github.com/id-Software/DOOM). Our modified source code is available [here](https://github.com/kubikulek231/SOS-DOOM-SOURCE).

Part of an assignment in the BPC-SOS course at FEEC BUT.

### Consists of several scripts ###

***run-setup.sh***
> When put into /root/, it downloads this repo and updates itself. It sets up the DOOM game, its dependencies, and other scripts from here. If the -a or --autopurge parameter is specified, it runs the run-purge.sh script when finished.

***run-purge.sh***
> Purges (removes anything redundant) the whole system and reboots it (in case -n is not specified). It can be run automatically by run-setup.sh or executed separately. Also accepts -s as a parameter, which will run the script in safe mode.

***run-doom.sh***
> Essentially a wrapper for xinit.

***.run-doom***
> Script that runs the DOOM game in Xephyr on x server.

***.xinitrc***
> Script that modifies the xinit behavior to run xterm terminal emulator with custom size on x server start and execute the .run-doom script.

***get-current-os-size.sh***
> For debugging purposes: Gets the current size of the whole OS, excluding some directories. It retrieves the size in MiB and sorts the files by size.

***get-yum-packages.sh***
> For debugging purposes: Lists every yum package installed by size and saves the output to packages.txt.
