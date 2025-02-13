#!/bin/bash

# fetch_ips.sh
# This script fetches the IP addresses of specified Proxmox LXC containers and outputs them as JSON.

set -e

# Source the secrets file
source "$(dirname "$0")/secrets.sh"

# List of VMIDs passed as arguments
VMIDS=("$@")

# Log files
LOG_FILE="fetch_ips.log"
STATUS_LOG_FILE="full_status_responses.log"

# Initialize log files
echo "=== Starting fetch_ips.sh ===" > "${LOG_FILE}"

# Initialize an empty JSON object
echo "{}" > container_ips.json

# Iterate over each provided VMID to fetch its IP
for vmid in "${VMIDS[@]}"; do
    echo "Fetching IP for container VMID: $vmid" | tee -a "${LOG_FILE}"
    
    # Execute the command on Proxmox to get IP addresses
    status_response=$(ssh -i "${PROXMOX_SSH_KEY}" -o IdentitiesOnly=yes "${PROXMOX_SSH_USER}@${PROXMOX_SSH_HOST}" \
        "pct exec ${vmid} -- ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'" 2>&1) || {
            echo "Error fetching IP for VMID $vmid: $status_response" | tee -a "${LOG_FILE}"
            jq --arg vmid "$vmid" '. + { ($vmid): null }' container_ips.json > tmp.json && mv tmp.json container_ips.json
            continue
        }

    # Log the status response
    echo "Status Response for VMID $vmid:" >> "${STATUS_LOG_FILE}"
    echo "${status_response}" >> "${STATUS_LOG_FILE}"
    echo "----------------------------------------" >> "${STATUS_LOG_FILE}"
    
    # Clean the IP (already clean since we used regex to extract)
    ip_clean="${status_response}"
    
    echo "Cleaned IP for VMID $vmid: ${ip_clean}" >> "${LOG_FILE}"

    if [[ -n "${ip_clean}" ]]; then
        # Append the VMID and IP to the JSON file
        jq --arg vmid "${vmid}" --arg ip "${ip_clean}" '. + { ($vmid): $ip }' container_ips.json > tmp.json && mv tmp.json container_ips.json
    else
        # Append the VMID with null if IP not found
        jq --arg vmid "${vmid}" '. + { ($vmid): null }' container_ips.json > tmp.json && mv tmp.json container_ips.json
    fi
done

echo "container_ips.json created." | tee -a "${LOG_FILE}"

# Validate JSON
echo "Validating container_ips.json..." | tee -a "${LOG_FILE}"
if ! jq empty container_ips.json; then
    echo "Error: container_ips.json contains invalid JSON." | tee -a "${LOG_FILE}"
    exit 1
fi

echo "container_ips.json is valid." | tee -a "${LOG_FILE}"
echo "=== fetch_ips.sh completed successfully ===" | tee -a "${LOG_FILE}"