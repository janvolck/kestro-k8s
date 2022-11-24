#!/bin/bash
kubectl label nodes kestro-server kestro.home/media-library=true
kubectl label nodes kestro-server kestro.home/availability=low