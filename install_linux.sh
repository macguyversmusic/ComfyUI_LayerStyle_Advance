#!/usr/bin/env bash

repair_dependency_txt="$(dirname "$0")/repair_dependency_list.txt"
requirements_txt="$(dirname "$0")/requirements.txt"

echo "Install whl..."
python -m pip install ./whl/docopt-0.6.2-py2.py3-none-any.whl
python -m pip install ./whl/hydra_core-1.3.2-py3-none-any.whl

echo "Install requirements.txt..."
while IFS= read -r line; do
    python -m pip install "$line"
done < "$requirements_txt"

echo
echo "Fixing Dependency Package..."
python -m pip uninstall -y onnxruntime
python -m pip uninstall -y opencv-python opencv-contrib-python opencv-python-headless opencv-contrib-python-headless

while IFS= read -r line; do
    python -m pip install "$line"
done < "$repair_dependency_txt"

echo
echo "Install Finish!"
