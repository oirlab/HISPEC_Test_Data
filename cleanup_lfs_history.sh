#!/bin/bash

set -e  # Exit on error

echo ">>> Removing all .fits files from Git history..."
git filter-repo --path-glob '*.fits' --invert-paths

echo ">>> Expiring reflog and running garbage collection..."
git reflog expire --expire=now --all
git gc --prune=now

echo ">>> Pruning unused Git LFS objects..."
git lfs prune

echo ">>> Remaking directories..."
mkdir -p HISPEC/Raw
mkdir -p HISPEC/L0
mkdir -p HISPEC/Cals

echo ">>> Connecting to Remote..."
git remote add origin https://github.com/oirlab/HISPEC_Test_Data

echo "Cleanup complete."
