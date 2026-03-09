import json
import os
from pathlib import Path

latin_path = Path("/Users/rdiaz/coderepos/datastore/transcriptions/actes-barnabe/latin")
manifest_path = Path("/Users/rdiaz/coderepos/apps/manifest-server/manifest_server/data/manifest.json")

def build_tree(path, parent_id):
    tree = []
    for item in sorted(path.iterdir()):
        if item.is_dir():
            relative_path = item.relative_to(latin_path)
            id_suffix = str(relative_path).replace('/', '-').replace('_', '-').replace(' ', '-')
            id = f"ab-lat-{id_suffix}"
            title = f"Les Actes de Barnabé ({item.name})"
            collection = {
                "id": id,
                "type": "collection",
                "title": title,
                "lang": "la",
                "parent": parent_id,
                "children": build_tree(item, id)
            }
            tree.append(collection)
    return tree

# Load manifest
with open(manifest_path, 'r') as f:
    data = json.load(f)

# Find and update ab-lat
for item in data:
    if item['id'] == '1':
        for child in item['children']:
            if child['id'] == 'ab-lat':
                child['children'] = build_tree(latin_path, 'ab-lat')
                break

# Write back
with open(manifest_path, 'w') as f:
    json.dump(data, f, indent=4)