#!/usr/bin/env bash
set -euo pipefail

# Navigate into the macOS subproject and install pods
cd macos
pod install

# Return to root, clean build artifacts, and launch on macOS
cd ..
flutter clean
flutter run -d macos