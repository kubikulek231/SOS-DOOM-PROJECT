#!/bin/bash
# ---------------------------------------------------------------------
# Bash script for listing yum packages by size
# Written as part of an assignment during the BPC-SOS course at FEEC BUT
# Authors: Jakub Lepik, Martin Moncek, Matej Baranyk
#
# This script is released under the GNU General Public License v3.0.
# For more details, see: https://www.gnu.org/licenses/gpl-3.0.html
# ---------------------------------------------------------------------

# ---------------------------------------------------------------------
#                      Save yum packages by size
# ---------------------------------------------------------------------

echo -e "\e[1;33mRetrieving yum package list to packages.txt...\e[0m"
yum list installed | awk '{print $1}' | xargs -I {} rpm -q --queryformat '%10{size} - %{name}\n' {} | sort -nr > packages.txt
