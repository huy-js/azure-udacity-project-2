#!/usr/bin/env bash

locust -f locustfile.py --host https://az-devops-project-2.azurewebsites.net/ --users 500 --spawn-rate 5 
