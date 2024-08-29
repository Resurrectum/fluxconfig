# fluxconfig
Configuration and parameter sets for running the AI-Dock ComfyUI container

# AI-Dock
The AI dock ComfyYUI repo provides a docker-compose. It can build a container image with Ubuntu, Python, Cuda and ComfyUI. 
AI dock's goal is to provide container images for widely known AI/ML applications. These images are based on "base images". 

The images are pre-built by GitHub Actions, they do not need to be built itself (and it is complicated because your build environment does not neccesariliy have the same hardware like GPUs that would be automatically recognised in the build process).
On runpod, one must define a template, that uses a NVIDIA GPU (if one wants to use a NVIDIA GPU obviously)
I take:
ghcr.io/ai-dock/comfyui:v2-cuda-12.1.1-base-22.04-v0.0.8
as stated here: 
https://github.com/ai-dock/comfyui/pkgs/container/comfyui/258663853?tag=v2-cuda-12.1.1-base-22.04-v0.0.8

An AI Dock image still can execute sa "provision script" when a container is started. This is where one can decide which models to download. 

This repo contains my provision script for the AI-Dock ComfyUI Docker Image. This works by having the script called `comfyuiinit.sh` here and set the url parameter in the AI-Dock ComfyUI Docker Image to the raw github link of that file. 

On runpod that means, one has to set the environment variable:
PROVISIONING_SCRIPT = https://raw.githubusercontent.com/Resurrectum/fluxconfig/main/comfyuiinit.sh

## Persistent storage
The AI Docker container downloads models into `/workspace`. In order not to loose the downloaded data on container startup, mount the external drive to this folder on runpod. Prior to downloading, the AI Docker container image is probably checking if that images already exists. 
The path can be set as an environment variable. 
