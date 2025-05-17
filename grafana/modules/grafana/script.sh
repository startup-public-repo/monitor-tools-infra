#!/bin/bash

# Define log file
LOG_FILE="/var/log/startup_script.log"
sudo touch "$LOG_FILE"
sudo chmod 666 "$LOG_FILE"

# Redirect stdout and stderr for the entire script
exec >> "$LOG_FILE" 2>&1

echo "========== Script started at $(date) =========="

# Set environment variables safely
export AWS_USER="${AWS_USER}"
export AWS_PASSWORD="${AWS_PASSWORD}"
export role_name="${role_name}"
export ANSIBLE_HOST_KEY_CHECKING=False

# Install dependencies
echo "[INFO] Installing required packages..."
sudo dnf install -y git sshpass rsyslog ansible-core

# Enable and start rsyslog
echo "[INFO] Starting rsyslog..."
sudo systemctl enable rsyslog
sudo systemctl start rsyslog

# Update SSH config for password authentication
echo "[INFO] Updating SSH configuration..."
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?ChallengeResponseAuthentication.*/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?UsePAM.*/UsePAM yes/' /etc/ssh/sshd_config

# Also patch cloud-init SSH config if it exists
if [ -f /etc/ssh/sshd_config.d/50-cloud-init.conf ]; then
    sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/50-cloud-init.conf
fi

# Update cloud-init config
echo "[INFO] Updating cloud-init config..."
sudo sed -i 's/^ssh_pwauth: false/ssh_pwauth: true/' /etc/cloud/cloud.cfg

# Reinitialize cloud-init
echo "[INFO] Cleaning and reinitializing cloud-init..."
sleep 5
sudo cloud-init clean
sudo cloud-init init
sleep 10

# Restart SSH
echo "[INFO] Restarting sshd..."
sudo systemctl restart sshd
sudo systemctl daemon-reexec
sleep 5

# Set user password
echo "[INFO] Setting password for user $AWS_USER"
echo "${AWS_USER}:${AWS_PASSWORD}" | sudo chpasswd

# Run Ansible pull
echo "[INFO] Running ansible-pull..."
ansible-pull -i localhost, \
  -U https://github.com/manupanand-freelance-developer/aws-devops.git \
  grafana/ansible/playbook.yml \
  -e ansible_user="${AWS_USER}" \
  -e ansible_password="${AWS_PASSWORD}" \
  -e role_name="${role_name}"

echo "========== Script completed at $(date) =========="
