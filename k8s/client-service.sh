#!bin/bash

kubectl expose deployment web  --type=LoadBalancer  --name=web-service