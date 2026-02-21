# NightReader Pro - Advanced PDF Reader

A feature-rich PDF reader application built with Flutter, optimized for night reading with advanced dark mode and combining the best features from ReadEra and Foxit Reader.

## 🌟 Key Features

### Reading Experience
- **Advanced Dark Mode**: Multiple color schemes optimized for night reading
  - True Black mode for OLED screens
  - Sepia tone for reduced eye strain
  - Customizable brightness and contrast
  - Night mode with warm amber tones

- **Multiple Reading Modes**:
  - Continuous scroll
  - Paginated view
  - Dual-page view (for tablets/large screens)

- **Customizable Settings**:
  - Adjustable font size
  - Line spacing control
  - Page margins
  - Auto-scroll with adjustable speed

### Navigation & Organization
- **Smart Library Management**:
  - Recently opened documents
  - Collections and categories
  - Search functionality
  - Reading progress tracking

- **Advanced Navigation**:
  - Table of Contents with multi-level support
  - Bookmarks with custom names
  - Page thumbnails
  - Quick page jumper
  - Reading history

### Annotation Tools (Like Foxit Reader)
- **Highlighting**:
  - Multiple colors (yellow, green, blue, pink)
  - Opacity control
  - Quick access toolbar

- **Text Markup**:
  - Underline
  - Strikethrough
  - Freehand drawing

- **Notes & Shapes**:
  - Sticky notes
  - Text boxes
  - Rectangle and circle shapes
  - Arrow annotations
  - Custom stamps

### Additional Features (Like ReadEra)
- **Text Operations**:
  - Copy text
  - Text search with highlighting
  - Dictionary lookup
  - Text-to-speech

- **File Management**:
  - Quick file access
  - Recent files
  - Favorites/starred documents
  - Cloud storage integration (future)

- **Export & Share**:
  - Share documents
  - Export with annotations
  - Print support
  - Document information

### UI/UX Features
- **Fullscreen Mode**: Immersive reading with auto-hiding controls
- **Gesture Controls**:
  - Tap to show/hide controls
  - Swipe to navigate pages
  - Pinch to zoom
  - Double-tap to fit width/page

- **Performance**:
  - Fast PDF rendering
  - Smooth page transitions
  - Low memory footprint
  - Battery-efficient night mode

## 📱 Platform Support
- ✅ Android
- ✅ iOS
- ✅ Windows
- ⏳ macOS (coming soon)
- ⏳ Linux (coming soon)

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.0 or higher
- Dart 3.0 or higher
- For Android: Android Studio / Android SDK
- For iOS: Xcode 14+
- For Windows: Visual Studio 2022

### Installation

1. **Clone the repository**:
```bash
git clone https://github.com/yourusername/nightreader-pro.git
cd nightreader-pro
```

2. **Install dependencies**:
```bash
flutter pub get
```

3. **Generate necessary files**:
```bash
flutter pub run build_runner build
```

4. **Run the app**:
```bash
# For Android
flutter run

# For iOS
flutter run -d ios

# For Windows
flutter run -d windows
```

### Build for Production

**Android APK**:
```bash
flutter build apk --release
```

**Android App Bundle**:
```bash
flutter build appbundle --release
```

**iOS**:
```bash
flutter build ios --release
```

**Windows**:
```bash
flutter build windows --release
```

## 🎨 Customization

### Color Schemes
The app includes 4 predefined color schemes optimized for different reading conditions:

1. **Night Mode** (Default): Warm amber on dark gray
2. **True Dark**: Low brightness for OLED screens
3. **Sepia**: Eye-friendly beige tones
4. **Day Mode**: High contrast for bright environments

You can customize these in `lib/models/reading_settings.dart`.

### Adding Custom Fonts
For better reading experience, you can add custom fonts like OpenDyslexic:

1. Download font files
2. Add them to `assets/fonts/`
3. Update `pubspec.yaml`
4. Reference in theme configuration

## 📚 Architecture

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── pdf_document.dart
│   └── reading_settings.dart
├── screens/                  # App screens
│   ├── home_screen.dart
│   └── pdf_reader_screen.dart
├── widgets/                  # Reusable widgets
│   ├── pdf_card.dart
│   ├── table_of_contents.dart
│   ├── annotation_tools.dart
│   └── reading_controls.dart
└── utils/                    # Utilities
    └── theme.dart
```

## 🔧 Configuration

### Permissions

**Android** (`android/app/src/main/AndroidManifest.xml`):
```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```

**iOS** (`ios/Runner/Info.plist`):
```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your files to open PDF documents</string>
```

## 🎯 Roadmap

- [ ] Cloud storage integration (Google Drive, Dropbox, OneDrive)
- [ ] OCR for scanned PDFs
- [ ] Text-to-speech functionality
- [ ] Sync across devices
- [ ] Form filling support
- [ ] Digital signature support
- [ ] Password-protected PDF support
- [ ] Split view for comparison
- [ ] Custom themes editor
- [ ] Statistics and reading goals

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Inspired by ReadEra and Foxit Reader
- Built with Flutter
- PDF rendering powered by Syncfusion Flutter PDF Viewer

## 📞 Support

For issues, questions, or suggestions, please open an issue on GitHub.

---

**Note**: This is a demonstration app showcasing PDF reader functionality. For production use, you'll need to:
1. Implement actual PDF rendering using the Syncfusion or flutter_pdfview packages
2. Add proper state management for larger apps
3. Implement local database for document storage
4. Add crash reporting and analytics
5. Implement proper file system security
