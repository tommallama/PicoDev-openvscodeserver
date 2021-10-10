#!/bin/bash

workDir="/home/workspace/picotools/"
RPiGithub="https://github.com/raspberrypi/"
projName=(pico-sdk pico-examples pico-extras pico-playground)

# Create local addresses and remotes 
for i in ${!projName[@]}; do
  localRepo[$i]="${workDir}${projName[$i]}"
  githubRepo[$i]="${RPiGithub}${projName[$i]}.git"
done

# TODO: Add 'if they exist' check
# Delete folders for a clean start
printf "\n********* Cleaning Up Existing Repos *********\n"
for i in "${localRepo[@]}"; do
    rm -rf $i
done

# Clone repos
for i in "${!githubRepo[@]}"; do
    printf "\n********* Cloning *********\n"
    git clone --depth 1 ${githubRepo[i]} ${localRepo[i]}
done

# Prep submodules
printf "\n******** Prepping Submodules*********\n"
for i in "${localRepo[@]}"; do
    cd $i
    git submodule update --init
done

printf "\n******** Done! *********\n" 
