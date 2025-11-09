FROM node:20-slim

# Install additional dependencies
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install OpenCode globally
RUN npm install -g opencode-ai

# Create a working directory
WORKDIR /workspace

# Set up a non-root user
RUN groupadd -g 1001 coder && \
    useradd -u 1001 -g coder -m coder && \
    chown -R coder:coder /workspace

USER coder

RUN mkdir -p /home/coder/.local/share/opencode

# Default command
CMD ["opencode"]
