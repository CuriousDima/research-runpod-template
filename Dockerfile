# Use Runpod PyTorch base image
FROM runpod/pytorch:1.0.3-dev-feat-sonarqube-cu1281-torch280-ubuntu2404

# Set environment variables
# This ensures Python output is immediately visible in logs
ENV PYTHONUNBUFFERED=1

# Set the working directory
WORKDIR /app

# Install system dependencies if needed
RUN apt-get update --yes && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
        wget \
        curl \
    && rm -rf /var/lib/apt/lists/*

# Install uv package manager
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:${PATH}"

# Install CLI tools with uv
RUN uv tool install kaggle && \
    uv tool install huggingface_hub

# Install Node.js LTS and npm
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install Pi coding agent (https://pi.dev)
RUN npm install -g --ignore-scripts @earendil-works/pi-coding-agent
