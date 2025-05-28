import os
import xml.etree.ElementTree as ET

# Directory containing the metadata
BASE_DIR = os.path.join('Salesforce', 'force-app', 'main', 'default', 'classes')

THRESHOLD_VERSION = 45.0

def find_low_api_version_files(base_dir=BASE_DIR, threshold=THRESHOLD_VERSION):
    low_version_files = []
    for root, _, files in os.walk(base_dir):
        for f in files:
            if f.endswith('.cls-meta.xml'):
                full_path = os.path.join(root, f)
                try:
                    tree = ET.parse(full_path)
                    api_version = tree.findtext('.//apiVersion')
                    if api_version is None:
                        continue
                    version = float(api_version)
                    if version < threshold:
                        low_version_files.append((full_path, version))
                except Exception as e:
                    print(f"Error parsing {full_path}: {e}")
    return low_version_files

if __name__ == '__main__':
    results = find_low_api_version_files()
    if not results:
        print(f"No Apex classes with API version below {THRESHOLD_VERSION} found.")
    else:
        print(f"Apex classes with API version below {THRESHOLD_VERSION}:")
        for path, version in results:
            print(f"{path}: {version}")
