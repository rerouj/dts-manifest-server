import json
from pathlib import Path

latin_path = Path("/Users/rdiaz/coderepos/datastore/transcriptions/actes-barnabe/latin")
manifest_path = Path("/Users/rdiaz/coderepos/apps/manifest-server/manifest_server/data/manifest.json")

def find_object_by_id(obj, target_id):
    if isinstance(obj, dict):
        if obj.get('id') == target_id:
            return obj
        for key, value in obj.items():
            if isinstance(value, (dict, list)):
                result = find_object_by_id(value, target_id)
                if result:
                    return result
    elif isinstance(obj, list):
        for item in obj:
            result = find_object_by_id(item, target_id)
            if result:
                return result
    return None

def add_resources():
    # Load manifest
    with open(manifest_path, 'r') as f:
        data = json.load(f)

    # Collect all xml files
    xml_files = list(latin_path.rglob('*.xml'))

    for xml_file in xml_files:
        relative_path = xml_file.relative_to(latin_path)
        parent_relative = relative_path.parent
        if str(parent_relative) == '.':
            parent_relative = Path('')
        id_suffix = str(parent_relative).replace('/', '-').replace('_', '-').replace(' ', '-')
        collection_id = f"ab-lat-{id_suffix}" if id_suffix else "ab-lat"

        # Find the collection
        collection = find_object_by_id(data, collection_id)
        if not collection:
            print(f"Collection {collection_id} not found for {xml_file}")
            continue

        # Compute resource id
        file_id_suffix = str(relative_path).replace('/', '-').replace('_', '-').replace(' ', '-').replace('.xml', '')
        resource_id = f"ab-lat-{file_id_suffix}"

        # Title
        filename = xml_file.stem
        title = f"{collection['title']} - {filename}"

        # Location
        location = f"https://raw.githubusercontent.com/unilenlac/actes-barnabe/refs/heads/main/latin/{relative_path}"

        # Create resource
        resource = {
            "id": resource_id,
            "type": "Resource",
            "title": title,
            "lang": "la",
            "parent": collection_id,
            "description": "----------------",
            "depth": 2,
            "location": location,
            "CitationTrees": [
                {
                    "name": "default",
                    "position": 0
                }
            ],
            "dublinCore": {}
        }

        # Add to collection's children
        if 'children' not in collection:
            collection['children'] = []
        collection['children'].append(resource)

    # Write back
    with open(manifest_path, 'w') as f:
        json.dump(data, f, indent=4)

if __name__ == "__main__":
    add_resources()