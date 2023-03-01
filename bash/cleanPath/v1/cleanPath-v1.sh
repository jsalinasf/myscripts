#!/bin/bash

# This script would delete all the files from a specific path
# The goal is to use this script with crontab to run it periodically
# and avoid filling up the disk
# This script will be used to delete log files generated by VCC

# Version Specific Comments
#
# Trying some basic logging options
# Right now the path to clean is static; later on, it will be specified in a script variable

rm -rf /home/testUser/test/*
if [ $? -eq 0 ]; then
  logger "SUCCESS /var/crash folder has been cleaned up"
else
  logger "ERROR while deleting /var/crash folder"
fi
