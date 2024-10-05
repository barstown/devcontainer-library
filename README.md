# Devcontainer documentation

A repository to document and save reusable configurations for devcontainers.

## Background

Paraphrasing from official sources,
[development containers](https://containers.dev/) allow the use of a container
as a full-featured development environment and enable developers to quickly
share and reuse container setup steps through
[Features](https://containers.dev/features) and
[Templates](https://containers.dev/templates).

Save a substantial amount of time by simply sharing a
[devcontainer.json](devcontainer.json) file and know that a friend or peer will
have a defined and reproducible environment, in it's simplest form.

## The problem

Only using the predefined templates and features may leave you wanting more.
Although the devcontainer spec supports the use of
[lifecycle scripts](https://containers.dev/implementors/json_reference/#lifecycle-scripts)
to run custom commands at various stages of the build process, defining more
complex configurations can be messy or irritating while sticking to this
framework.

## A solution

Although building a custom container is an option, the goal was to use the
official Features and Templates and only deviate when needed. To accomplish this
task the postCreateCommand lifecycle script runs the
[postCreateCommand.sh](postCreateCommand.sh) bash script after building the
container and applying any Features.

This script looks in the project's .devcontainer directory for a subdirectory
called scripts. Any discovered bash scripts ending in *.sh will have the
execution permission added and then ran in order alphabetically. Pay attention
to the order of operations when needed. Prefix the script names with numbers
to help control the order which they're processed (ex. 01-packages.sh).

When running the devcontainers through VSCode, the remote environment user will
usually be 'vscode' and it will typically have full root privileges. Some
scripts will need ran with super user privileges to complete, such
as installing additional packages through a package manager. To facilitate
this, `postCreateCommand.sh` looks for the variable "REQUIRES_SUDO=true" in the
child scripts. When present the script will be ran as `sudo [script.sh]`, and
when absent it will run as the vscode user directly.

## Scripts

The [scripts](scripts) directory contains reusable bash scripts intended for use
in the [.devcontainer/scripts](.devcontainer/scripts) directory of a project.
These are largely for personal use, but by making this public I hope that at
least a few people find this a little bit helpful.
