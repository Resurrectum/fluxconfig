# fluxconfig
Configuration and parameter sets for running the AI-Dock ComfyUI container

# AI-Dock
The AI dock ComfyYUI repo provides a docker-compose. It can build a container image with Ubuntu, Python, Cuda and ComfyUI. 
AI dock's goal is to provide container images for widely known AI/ML applications. These images are based on "base images". 

The images are pre-built by GitHub Actions, they do not need to be built itself (and it is complicated because your build environment does not neccesariliy have the same hardware like GPUs that would be automatically recognised in the build process).

An AI Dock image still can execute sa "provision script" when a container is started. This is where one can decide which models to download. 

This repo contains my provision script for the AI-Dock ComfyUI Docker Image. This works by having the script called `comfyuiinit.sh` here and set the url parameter in the AI-Dock ComfyUI Docker Image to the raw github link of that file. 
