FROM node:20-slim

# Install additional dependencies
RUN apt-get update && apt-get install -y \
    fzf \
    git \
    neovim \
    ripgrep \
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

ENV USER="Coder"

RUN mkdir -p /home/coder/.local/share/opencode

# Copy entrypoint script
COPY --chown=coder:coder entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Default command
CMD ["/usr/local/bin/entrypoint.sh"]
