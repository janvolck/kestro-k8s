#!/bin/bash
if [ -z "$(helm repo list | grep hivemq)" ]; then
    helm repo add hivemq https://hivemq.github.io/helm-charts
fi
