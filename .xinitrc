#!/bin/bash
# ---------------------------------------------------------------------
# Bash script for modifying xinit behavior
# Written as part of an assignment during the BPC-SOS course at FEEC BUT
# Authors: Jakub Lepik, Martin Moncek, Matej Baranyk
#
# This script is released under the GNU General Public License v3.0.
# For more details, see: https://www.gnu.org/licenses/gpl-3.0.html
# ---------------------------------------------------------------------

echo "Executing .xinitrc"

# Run /root/.rundoom
/root/.rundoom &

# Run Xterm
xterm -geometry 50x3+1+200 -n main_window -display :0

echo "Executing .xinitrc done."
