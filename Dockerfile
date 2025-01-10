# Load base image from AI-dock github container repository
FROM ghcr.io/ai-dock/comfyui:v2-cuda-12.1.1-base-22.04-v0.0.8

# Set environment variables (if needed)
ENV WORKSPACE="/workspace"
ENV PROVISIONING_SCRIPT="/app/comfyuiinit.sh"

# Copy any necessary files from your repository
COPY comfyuiinit.sh /app/comfyuiinit.sh

# Run the commands that were previously executed during startup
#RUN apt-get update && apt-get install -y \
#    package1 \
#    package2 \
#    && rm -rf /var/lib/apt/lists/*

# Execute any additional setup scripts
RUN /app/setup_scripts/setup.sh

# Set the working directory (if needed)
WORKDIR /workspace

# Remove the command to run when the container starts if inherited from the base container
# CMD ["your-start-command"]
