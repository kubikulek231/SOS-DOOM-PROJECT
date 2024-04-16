#!/bin/bash
# ---------------------------------------------------------------------
# Script for getting current OS size
# Written as part of an assignment during the BPC-SOS course at FEEC BUT
# Authors: Jakub Lepik, Martin Moncek, Matej Baranyk
#
# This file is released under the GNU General Public License v3.0.
# For more details, see: https://www.gnu.org/licenses/gpl-3.0.html
# ---------------------------------------------------------------------

# Get current OS size
du / --exclude=/{proc,sys,dev} -abc | sort -n | numfmt --to=iec-i --suffix=B --padding=7
