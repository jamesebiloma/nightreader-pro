# NightReader Pro - Windows Build Script
# PowerShell script for building releases on Windows

param(
    [string]$Version = "1.0.0",
    [switch]$AndroidOnly,
    [switch]$WindowsOnly,
    [switch]$All
)

$AppName = "NightReaderPro"
$ReleaseDir = "releases\v$Version"

Write-Host "========================================" -ForegroundColor Green
Write-Host "  NightReader Pro Build Script v$Version" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Green

# Clean previous builds
Write-Host "🧹 Cleaning previous builds..." -ForegroundColor Yellow
flutter clean
flutter pub get

# Create release directory
New-Item -ItemType Directory -Force -Path $ReleaseDir | Out-Null

# Build Android
function Build-Android {
    Write-Host "`n📱 Building Android APKs..." -ForegroundColor Yellow
    flutter build apk --release --split-per-abi
    
    # Copy APKs
    Copy-Item "build\app\outputs\flutter-apk\app-armeabi-v7a-release.apk" `
              "$ReleaseDir\$AppName-v$Version-android-arm32.apk"
    Copy-Item "build\app\outputs\flutter-apk\app-arm64-v8a-release.apk" `
              "$ReleaseDir\$AppName-v$Version-android-arm64.apk"
    Copy-Item "build\app\outputs\flutter-apk\app-x86_64-release.apk" `
              "$ReleaseDir\$AppName-v$Version-android-x64.apk"
    
    # Universal APK
    flutter build apk --release
    Copy-Item "build\app\outputs\flutter-apk\app-release.apk" `
              "$ReleaseDir\$AppName-v$Version-android-universal.apk"
    
    Write-Host "✅ Android builds complete!" -ForegroundColor Green
}

# Build Windows
function Build-Windows {
    Write-Host "`n🪟 Building Windows executable..." -ForegroundColor Yellow
    flutter build windows --release
    
    # Create ZIP
    Compress-Archive -Path "build\windows\runner\Release\*" `
                     -DestinationPath "$ReleaseDir\$AppName-v$Version-Windows.zip" `
                     -Force
    
    Write-Host "✅ Windows build complete!" -ForegroundColor Green
}

# Create release notes
function New-ReleaseNotes {
    Write-Host "`n📝 Creating release notes..." -ForegroundColor Yellow
    
    $releaseNotes = @"
# 🌙 NightReader Pro v$Version

**Release Date:** $(Get-Date -Format "yyyy-MM-dd")

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
   - **Most users:** $AppName-v$Version-android-arm64.apk (64-bit ARM)
   - **Older devices:** $AppName-v$Version-android-arm32.apk (32-bit ARM)
   - **Universal:** $AppName-v$Version-android-universal.apk (works on all)

2. Enable "Install from Unknown Sources" in Android settings
3. Install the APK

### Windows
1. Download $AppName-v$Version-Windows.zip
2. Extract the ZIP file
3. Run nightreader_pro.exe

## 🐛 Known Issues
- None reported yet

## 📖 Documentation
- [Quick Start Guide](../QUICK_START.md)
- [Feature Comparison](../FEATURE_COMPARISON.md)
- [Full Documentation](../README.md)
"@
    
    Set-Content -Path "$ReleaseDir\RELEASE_NOTES.md" -Value $releaseNotes
    Write-Host "✅ Release notes created!" -ForegroundColor Green
}

# Calculate checksums
function New-Checksums {
    Write-Host "`n🔐 Calculating checksums..." -ForegroundColor Yellow
    
    $files = Get-ChildItem -Path $ReleaseDir -Include *.apk, *.zip -Recurse
    $checksums = @()
    
    foreach ($file in $files) {
        $hash = Get-FileHash -Path $file.FullName -Algorithm SHA256
        $checksums += "$($hash.Hash)  $($file.Name)"
    }
    
    Set-Content -Path "$ReleaseDir\SHA256SUMS.txt" -Value $checksums
    Write-Host "✅ Checksums created!" -ForegroundColor Green
}

# Main execution
if ($AndroidOnly) {
    Build-Android
}
elseif ($WindowsOnly) {
    Build-Windows
}
elseif ($All) {
    Build-Android
    Build-Windows
}
else {
    # Interactive menu
    Write-Host "Select build target:" -ForegroundColor Yellow
    Write-Host "1) Android only"
    Write-Host "2) Windows only"
    Write-Host "3) Both Android and Windows"
    $choice = Read-Host "Enter choice [1-3]"
    
    switch ($choice) {
        "1" { Build-Android }
        "2" { Build-Windows }
        "3" { 
            Build-Android
            Build-Windows
        }
        default { 
            Write-Host "Invalid choice!" -ForegroundColor Red
            exit 1
        }
    }
}

# Always create release notes and checksums
New-ReleaseNotes
New-Checksums

# Summary
Write-Host "`n========================================" -ForegroundColor Green
Write-Host "  Build Complete! 🎉" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host "`nRelease files are in: $ReleaseDir" -ForegroundColor Yellow
Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "1. Test all builds on target devices"
Write-Host "2. Create a git tag: git tag -a v$Version -m 'Release v$Version'"
Write-Host "3. Push to GitHub: git push origin v$Version"
Write-Host "4. Create GitHub release and upload files from $ReleaseDir"
Write-Host "5. Update README.md with download links"
Write-Host "`nHappy releasing! 🚀`n" -ForegroundColor Green

# Open release directory
Start-Process explorer.exe -ArgumentList $ReleaseDir
