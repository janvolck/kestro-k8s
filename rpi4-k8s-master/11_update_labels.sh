#!/bin/bash
kubectl label nodes rpi4-k8s-master kestro.home/availability=high
kubectl label nodes rpi4-k8s-master kestro.home/music-library=true
kubectl label nodes rpi4-k8s-master kestro.home/eth0.100=true
kubectl label nodes rpi4-k8s-master kestro.home/eth0.200=true