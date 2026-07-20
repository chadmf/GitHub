# macOS Developer Environment Setup

This repository contains an automated setup for configuring a fresh macOS (Apple Silicon) development environment. It uses an isolated Ansible environment to ensure stability and uses direct Homebrew commands to handle installation statuses and unicode terminal output as the community brew module doesnt.

## Included Tools

**CLI Tools (Homebrew Formulae):**
* `gh` - GitHub CLI
* `uv` - Fast Python package installer & resolver written in Rust

**GUI Applications (Homebrew Casks):**
* `iterm2` - Terminal replacement
* `github` - GitHub Desktop
* `cursor` - AI-first code editor
* `claude` - Claude Desktop App
* `claude-code` - Anthropic's Claude command-line AI assistant
* `google-cloud-sdk` - Google Cloud CLI (`gcloud`)

**Additional Configuration:**
* Automatically installs **Homebrew** for Apple Silicon (`/opt/homebrew/bin/brew`) if it is not found.
* Automatically creates a default Python virtual environment at `~/.venv` utilizing the blazing-fast `uv` tool.

## Files Overview

* `setup_mac.yml`
  The main Ansible playbook. It loops through your defined lists of tools and safely installs them. It bypasses typical Ansible `community.general.homebrew` parsing bugs by natively using the `brew install` CLI commands, meaning it will elegantly handle "already installed" states without failing.

* `setup.sh`
  A wrapper shell script that manages dependencies. It automatically creates an isolated Python virtual environment just for Ansible (`~/.ansible-venv`), installs Ansible if missing, downloads required collections, and runs the playbook. This keeps your system Python completely clean.

## How to Run

1. Place both `setup_mac.yml` and `setup.sh` in the same directory.
2. Open your terminal and navigate to that folder.
3. Make the wrapper script executable:
   ```bash
   chmod +x setup.sh
   ```
4. Execute the setup script:
   ```bash
   ./setup.sh
   ```

> **Note:** During the setup, you may be prompted to enter your Mac system password (e.g., if Homebrew needs to be installed natively or if specific casks require admin permissions to link into `/Applications`).

## Customization

To add more tools to your Mac, simply open `setup_mac.yml` and add the package names to the lists under `vars`:

```yaml
    # Add to this list for CLI tools
    homebrew_formulae:
      - gh
      - uv
      - jq    # Example addition

    # Add to this list for GUI Apps
    homebrew_casks:
      - iterm2
      - github
      - slack # Example addition
```
README.md
Displaying README.md.