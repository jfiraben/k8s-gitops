#!/usr/bin/env python3
import json
import os
import sys

# Path to the container_ips.json file
CONTAINER_IPS_FILE = os.path.join(os.path.dirname(__file__), "../../terraform/environments/dev/container_ips.json")

# Mapping of VMIDs to service names and their corresponding private keys
VMID_SERVICE_MAP = {
    "400": {"name": "vault", "key": "~/.ssh/id_ed25519_vault"},
    "401": {"name": "wazuh", "key": "~/.ssh/id_ed25519_wazuh"}
}

def load_container_ips():
    with open(CONTAINER_IPS_FILE, 'r') as f:
        return json.load(f)

def generate_inventory():
    container_ips = load_container_ips()
    inventory = {
        "_meta": {
            "hostvars": {}
        },
        "all": {
            "hosts": [],
            "children": []
        }
    }

    for vmid, service in VMID_SERVICE_MAP.items():
        host = container_ips.get(vmid)
        if not host:
            continue
        hostname = f"prox-{service['name']}"
        inventory["_meta"]["hostvars"][host] = {
            "ansible_host": host,
            "ansible_user": "root",
            "ansible_ssh_private_key_file": service["key"],
            "ansible_ssh_common_args": "-o IdentitiesOnly=yes"
        }
        inventory["all"]["hosts"].append(host)
        if hostname not in inventory:
            inventory[hostname] = {
                "hosts": []
            }
        inventory[hostname]["hosts"].append(host)

    print(json.dumps(inventory, indent=2))

if __name__ == "__main__":
    generate_inventory()