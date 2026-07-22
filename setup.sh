#!/usr/bin/env bash
set -euo pipefail

# Configuration
VENV_DIR="${HOME}/.ansible-venv"
PLAYBOOK="setup_mac.yml"

echo "==> Creating Ansible Python virtual environment..."
if [ ! -d "${VENV_DIR}" ]; then
  python3 -m venv "${VENV_DIR}"
  echo "    Created venv at ${VENV_DIR}"
else
  echo "    Existing venv found at ${VENV_DIR}"
fi

# Activate virtual environment
source "${VENV_DIR}/bin/activate"

echo "==> Installing Ansible..."
pip install --quiet --upgrade pip
pip install --quiet ansible
pip install --quiet ansible-builder

echo "==> Installing required Ansible collections..."
ansible-galaxy collection install community.general 

echo "==> Executing playbook ${PLAYBOOK}..."
ansible-playbook "${PLAYBOOK}"

echo "==> Setup finished successfully!"
