#!/bin/bash
dstDir=$1
numberOfBackupsToStay=$2
ls -1td $dstDir/* | tail -n +$numberOfBackupsToStay| xargs rm -f  
