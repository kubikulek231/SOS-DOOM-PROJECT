# SOS-DOOM-PROJECT

<p align="center">
  <img src="doom-logo-ds.png" alt="DOOM game logo" style="width: 50%;" />
</p>

This repository contains setup, purge, and additional scripts along a slightly modified and compiled version of [original DOOM game](https://github.com/id-Software/DOOM). Our modified source code is available in the [source repo](https://github.com/kubikulek231/SOS-DOOM-SOURCE).

The focus of our project is to compile and run the DOOM game on the CentOS Linux operating system (available to download from [here](https://www.centos.org/download/)) with as limited disk space as possible. With the approach specified in our scripts, we achieve around 92 megabytes of the total OS disk space while preserving the OS's core functions and the DOOM game's playability.

Part of an assignment during the BPC-SOS course at FEEC BUT.

<p align="center">
  <img src="doom-game.png" alt="DOOM game screenshot" style="width: 50%;" />
</p>

> A screenshot taken while running the X window with the game on the shrunk OS. In the bottom part, there is the Xterm terminal emulator, which can be used even while the game is running, for example, for exiting the whole graphic environment.

### Scripts description ###

***run-setup.sh***
> When put into /root/, it downloads this repo and updates itself. It sets up the DOOM game, its dependencies, and other scripts from here. If the -a or --autopurge parameter is specified, it runs the run-purge.sh script when finished.

***run-purge.sh***
> Purges eg. removes everything redundant for running the OS and the game and reboots it (in case -n is not specified). It can be run automatically by run-setup.sh or executed separately. Also accepts -s as a parameter, which will run the script in safe mode.

***run-doom.sh***
> Essentially a wrapper for xinit command.

***.run-doom***
> Script that runs the DOOM game in Xephyr on the X server.

***.xinitrc***
> Script that modifies the xinit command behavior to run Xterm terminal emulator with custom size on x server start and execute the .run-doom script.

***get-current-os-size.sh***
> For debugging purposes: gets the current size of the whole OS, excluding some directories. It retrieves the size in MiB and sorts the files by size.

***get-yum-packages.sh***
> For debugging purposes: lists every yum package installed by size and saves the output to packages.txt.
