#!/bin/bash

# Check for typical home directory structures
HOME_INDICATORS=(.ssh .config .local .bashrc .zshlocal .zshrc)

for dir in "${HOME_INDICATORS[@]}"; do
    if [ -e "$dir" ]; then
        echo "Error: Typical home directory structure detected (found '$dir')."
        echo "This appears to be a home directory. Please run opencode in a project directory instead."
        echo "To override this check, run: docker run -it <image> opencode"
        exit 1
    fi
done

# No home directory indicators found, start opencode
exec opencode
