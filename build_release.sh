#!/bin/bash

# NightReader Pro - Automated Build and Release Script
# This script automates building release versions for all platforms

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
VERSION="1.0.0"
APP_NAME="NightReaderPro"

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  NightReader Pro Build Script v${VERSION}${NC}"
echo -e "${GREEN}========================================${NC}\n"

# Clean previous builds
echo -e "${YELLOW}🧹 Cleaning previous builds...${NC}"
flutter clean
flutter pub get

# Create release directory
RELEASE_DIR="releases/v${VERSION}"
mkdir -p "$RELEASE_DIR"

# Function to build Android
build_android() {
    echo -e "\n${YELLOW}📱 Building Android APKs...${NC}"
    flutter build apk --release --split-per-abi
    
    # Copy APKs to release directory
    cp build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk \
       "$RELEASE_DIR/${APP_NAME}-v${VERSION}-android-arm32.apk"
    cp build/app/outputs/flutter-apk/app-arm64-v8a-release.apk \
       "$RELEASE_DIR/${APP_NAME}-v${VERSION}-android-arm64.apk"
    cp build/app/outputs/flutter-apk/app-x86_64-release.apk \
       "$RELEASE_DIR/${APP_NAME}-v${VERSION}-android-x64.apk"
    
    # Also build universal APK
    flutter build apk --release
    cp build/app/outputs/flutter-apk/app-release.apk \
       "$RELEASE_DIR/${APP_NAME}-v${VERSION}-android-universal.apk"
    
    echo -e "${GREEN}✅ Android builds complete!${NC}"
}

# Function to build Windows
build_windows() {
    echo -e "\n${YELLOW}🪟 Building Windows executable...${NC}"
    
    # Check if running on Windows or WSL
    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
        flutter build windows --release
        
        # Create ZIP
        cd build/windows/runner/Release
        powershell Compress-Archive -Path * -DestinationPath "../../../../${RELEASE_DIR}/${APP_NAME}-v${VERSION}-Windows.zip" -Force
        cd ../../../..
        
        echo -e "${GREEN}✅ Windows build complete!${NC}"
    else
        echo -e "${YELLOW}⚠️  Windows builds require Windows OS. Skipping...${NC}"
    fi
}

# Function to build iOS (macOS only)
build_ios() {
    echo -e "\n${YELLOW}🍎 Building iOS...${NC}"
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        flutter build ios --release --no-codesign
        echo -e "${GREEN}✅ iOS build complete! (Open in Xcode to sign and archive)${NC}"
    else
        echo -e "${YELLOW}⚠️  iOS builds require macOS. Skipping...${NC}"
    fi
}

# Function to create release notes
create_release_notes() {
    echo -e "\n${YELLOW}📝 Creating release notes...${NC}"
    
    cat > "$RELEASE_DIR/RELEASE_NOTES.md" << EOF
# 🌙 NightReader Pro v${VERSION}

**Release Date:** $(date +%Y-%m-%d)

## ✨ What's New

### Features
- 🌓 Advanced dark mode with 4 color schemes
- 📝 Professional annotation tools (highlight, underline, notes)
- 🎨 Fully customizable reading experience
- 📚 Smart library management
- ⚡ Fast and lightweight

### Improvements
- Optimized PDF rendering
- Improved night reading experience
- Better battery life in dark modes
- Enhanced UI/UX

## 📦 Installation

### Android
1. Download the appropriate APK for your device:
   - **Most users:** ${APP_NAME}-v${VERSION}-android-arm64.apk (64-bit ARM)
   - **Older devices:** ${APP_NAME}-v${VERSION}-android-arm32.apk (32-bit ARM)
   - **Universal:** ${APP_NAME}-v${VERSION}-android-universal.apk (works on all)

2. Enable "Install from Unknown Sources" in Android settings
3. Install the APK

### Windows
1. Download ${APP_NAME}-v${VERSION}-Windows.zip
2. Extract the ZIP file
3. Run nightreader_pro.exe

## 🐛 Known Issues
- None reported yet

## 📖 Documentation
- [Quick Start Guide](../QUICK_START.md)
- [Feature Comparison](../FEATURE_COMPARISON.md)
- [Full Documentation](../README.md)

## 🙏 Acknowledgments
Thank you to all contributors and users!

---

**Full Changelog:** [Compare v${VERSION}](https://github.com/YOUR_USERNAME/nightreader-pro/compare/v0.9.0...v${VERSION})
EOF
    
    echo -e "${GREEN}✅ Release notes created!${NC}"
}

# Function to calculate checksums
create_checksums() {
    echo -e "\n${YELLOW}🔐 Calculating checksums...${NC}"
    
    cd "$RELEASE_DIR"
    
    # Create checksums file
    if [[ "$OSTYPE" == "darwin"* ]] || [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sha256sum *.apk *.zip 2>/dev/null > SHA256SUMS.txt || true
    fi
    
    cd ../..
    echo -e "${GREEN}✅ Checksums created!${NC}"
}

# Main menu
echo -e "${YELLOW}Select build target:${NC}"
echo "1) Android only"
echo "2) Windows only"
echo "3) iOS only (macOS required)"
echo "4) All platforms"
echo "5) Quick build (Android + Windows)"
read -p "Enter choice [1-5]: " choice

case $choice in
    1)
        build_android
        ;;
    2)
        build_windows
        ;;
    3)
        build_ios
        ;;
    4)
        build_android
        build_windows
        build_ios
        ;;
    5)
        build_android
        build_windows
        ;;
    *)
        echo -e "${RED}Invalid choice!${NC}"
        exit 1
        ;;
esac

# Always create release notes and checksums
create_release_notes
create_checksums

# Summary
echo -e "\n${GREEN}========================================${NC}"
echo -e "${GREEN}  Build Complete! 🎉${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "\n${YELLOW}Release files are in: ${RELEASE_DIR}${NC}"
echo -e "\n${YELLOW}Next steps:${NC}"
echo "1. Test all builds on target devices"
echo "2. Create a git tag: git tag -a v${VERSION} -m 'Release v${VERSION}'"
echo "3. Push to GitHub: git push origin v${VERSION}"
echo "4. Create GitHub release and upload files from ${RELEASE_DIR}"
echo "5. Update README.md with download links"
echo -e "\n${GREEN}Happy releasing! 🚀${NC}\n"

# Open release directory
if command -v xdg-open &> /dev/null; then
    xdg-open "$RELEASE_DIR"
elif command -v open &> /dev/null; then
    open "$RELEASE_DIR"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    start "$RELEASE_DIR"
fi
