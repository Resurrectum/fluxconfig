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
The path can be set as an **environment variable**. 

## Pod start command
In the template on runpod, the default docker command is 
`bash -c '/start.sh'
as stated here:
https://docs.runpod.io/pods/templates/overview

There is no need to change the default startup command. 

The first time starting will take a long time. First the container image is pulled from `ghcr`. Then the provisionning script is executed which downloads all models (safetensor files) from Huggingface. 

## 1111 AI Dock portal
The user can connect to the user portal. The username is `user`. The password is stored in the environment variable `WEB_PASSWORD` inside the docker container. So one can connect via ssh to the docker, readout that variable `echo $WEB_PASSWORD` and connect. 
In the next page there are all services and their port. ComfyUI can be selected. At this stage, although the AI Dock is already working, it will still take time to download and run `ComfyUI`. The progress can be observed by clicking on Cloudflare Quick Tunnel. 

## Issues with the flux1-dev.safetensors
When selected as a model in ComfyUI I get the error message that the model **type** was not recognised. 
I assume this file is corrupted or so. 
So I download it again using `curl`
```
curl -L -H "Authorization: Bearer $HF_TOKEN" https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/flux1-dev.safetensors -o flux1-dev.safetensors
```
the `-L` tells curl to follow redirect URLs. 
`H` is for Huggingface to pass the HF_Token which is pulled from the `ENV` variables. It is followed by the link and the name of the file. 
that command is to be executed in the correct folder:
`/workspace/storage/stable_diffusion/models/ckpt`