#!/bin/bash

# Get current OS size
du / --exclude=/{proc,sys,dev} -abc | sort -n
