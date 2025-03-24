#!/bin/bash

cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

if (( $(echo "$cpu_usage > 75" | bc -l) )); then
    echo "High CPU Usage: $cpu_usage%"
    gcloud compute instances create vccassg-3 --source-instance-template projects/vccassingment3/regions/us-central1/instanceTemplates/instancetemplate
else
    echo "CPU Usage is Normal: $cpu_usage%"
fi
