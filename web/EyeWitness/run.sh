#!/bin/bash

wget https://raw.githubusercontent.com/FortyNorthSecurity/EyeWitness/master/Dockerfile

docker build --build-arg user=$USER --tag web/eyewitness .
