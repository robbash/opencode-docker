# OpenCode in Docker

[OpenCode](https://opencode.ai) is a great tool to support you codeing. While it
aims to contain everything in the working directory, the AI _could_ get
outside the folder using tools.

**_It does feel strange allowing AI full access to your file system, with
credentials, secrets but maybe also your private content._**

To truely contain the AI within a folder, we run OpenCode inside a Docker
container and only mount the directory we want to grant access to.

## Building

Simply build with docker, no need to push to a repo:

```
docker build -t opencode-docker .
```

## Executung

When running the Docker container, make sure to mount the OpenCode config/cache
folders:

```
# Minimal
docker run -it --rm \
    -v .:/workspace \
    -v ~/.config/opencode:/home/coder/.config/opencode \
    -v ~/.local/share/opencode:/home/coder/.local/share/opencode \
    --name opencode-docker \
    opencode-docker

# For different project folders and username in prompt use the following (recommended)
docker run -it --rm \
    -e "USER=$USER" \
    -w "/workspace/$(basename "$PWD")" \
    -v ~/.gitconfig:/home/coder/.gitconfig \
    -v ~/.config/opencode:/home/coder/.config/opencode \
    -v ~/.local/share/opencode:/home/coder/.local/share/opencode \
    -v ".:/workspace/$(basename "$PWD")" \
    --name "opencode-docker-$(basename "$PWD")" \
    opencode-docker
```

I had OpenCode installed on my computer, therefore the folders above were
already in place. You can also just use any folder to persist config and cache
beyond container recreation.

I've created an alias called `opencode` so I can pretty much work with is as if
it was installed.

### Preventing in HOME

To avoid accidentally starting opencode in your home directory, there's a check
for certain files. If they are present, you will get an error message. For false
positives, you can get around overwriting the CMD.

### Authenticating a provider

According to the [OpenCode docs](https://opencode.ai/docs/#configure) you can
OAuth sign-in to Anthropic (or others), and use your Pro/Max account
subscription. To do so, start another session with your container and run:

```
docker exec -it opencode-docker opencode auth login
```
