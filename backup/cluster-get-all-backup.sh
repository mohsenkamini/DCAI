#!/bin/bash
dstDir=$1
mkdir -p $dstDir
kubectl get all --all-namespaces -o yaml > $dstDir/`date "+%F-%T"`.yml
