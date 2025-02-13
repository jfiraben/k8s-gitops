import json

# Load container IPs
with open('container_ips.json') as f:
    container_ips = json.load(f)

# Define groups
groups = {
    'vault': [container_ips['vault']],
    'wazuh': [container_ips['wazuh']]
}

# Write to inventory.ini
with open('inventory.ini', 'w') as f:
    for group, hosts in groups.items():
        f.write(f'[{group}]\n')
        for host in hosts:
            f.write(f'{host}\n')
        f.write('\n')