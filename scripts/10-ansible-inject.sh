#!/bin/bash
set -e

# Define an array of venv targets and their corresponding packages to inject with
# space separated
declare -A venv_packages=(
    ["ansible-core"]="pywinrm package2 package3"
    ["ansible-lint"]="requests another-package"
)

# Loop over the associative array
for venv in "${!venv_packages[@]}"; do
    packages="${venv_packages[$venv]}"

    # Check if the virtual environment exists using pipx
    if pipx list | grep -q "package $venv"; then
        echo "Injecting $packages into $venv..."
        pipx inject "$venv" $packages
    else
        echo "Skipping $venv: not installed via pipx."
    fi
done

echo "Done."
