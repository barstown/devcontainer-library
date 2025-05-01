#!/bin/bash
set -e

# Configuration
PNPM_CMD="pnpm"
GLOBAL=true  # Set to false to install locally

# List of packages to install
NODE_PACKAGES=(
    @marp-team/marp-cli
)

# Ensure pnpm is installed
check_pnpm() {
    if ! command -v $PNPM_CMD &> /dev/null; then
        echo "Error: pnpm is not installed. Install it first."
        exit 1
    fi
}

# Run pnpm setup to configure global path and shell env
run_pnpm_setup() {
    echo "🛠️ Running 'pnpm setup' to configure environment..."
    $PNPM_CMD setup
}

# Add packages using pnpm
install_node_packages() {
    echo "📦 Installing Node packages with pnpm..."
    if [ "$GLOBAL" = true ]; then
        $PNPM_CMD add -g "${NODE_PACKAGES[@]}"
    else
        $PNPM_CMD add "${NODE_PACKAGES[@]}"
    fi
}

# Main execution
main() {
    check_pnpm
    run_pnpm_setup
    install_node_packages
    echo "✅ Node packages installed successfully."
}

main "$@"
