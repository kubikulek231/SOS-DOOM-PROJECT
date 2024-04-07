#!/bin/bash

# Get current OS size
du / --exclude=/{proc,sys,dev} -abc | sort -n | numfmt --to=iec-i --suffix=B --padding=7
