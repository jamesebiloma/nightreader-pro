# Contributing to NightReader Pro

First off, thank you for considering contributing to NightReader Pro! 🎉 

It's people like you that make NightReader Pro such a great tool for everyone who loves reading PDFs.

## 🌟 Ways to Contribute

### 🐛 Reporting Bugs

If you find a bug, please create an issue on GitHub with:

- **Clear title**: Describe the issue briefly
- **Steps to reproduce**: How can we recreate the bug?
- **Expected behavior**: What should happen?
- **Actual behavior**: What actually happens?
- **Screenshots**: If applicable
- **Environment**:
  - Device model (e.g., Samsung Galaxy S21)
  - OS version (e.g., Android 13)
  - App version (e.g., 1.0.0)

**Example:**
```
Title: App crashes when opening large PDF files

Steps to reproduce:
1. Open app
2. Select PDF larger than 100MB
3. App crashes

Expected: PDF should load
Actual: App crashes immediately

Device: Pixel 7
OS: Android 14
Version: 1.0.0
```

### 💡 Suggesting Features

We love new ideas! To suggest a feature:

1. Check if it's already suggested in [Issues](https://github.com/YOUR_USERNAME/nightreader-pro/issues)
2. Create a new issue with label `enhancement`
3. Describe:
   - **What** the feature does
   - **Why** it would be useful
   - **How** it might work (optional)

### 📝 Improving Documentation

Documentation improvements are always welcome:
- Fix typos or unclear instructions
- Add examples
- Improve existing guides
- Translate to other languages

### 💻 Code Contributions

Want to write code? Awesome! Here's how:

## 🚀 Development Setup

### Prerequisites
- Flutter SDK 3.0 or higher
- Git
- Your favorite code editor (VS Code, Android Studio, IntelliJ)

### Setup Steps

1. **Fork the repository**
   - Click "Fork" button on GitHub
   - This creates your own copy

2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/nightreader-pro.git
   cd nightreader-pro
   ```

3. **Add upstream remote**
   ```bash
   git remote add upstream https://github.com/ORIGINAL_OWNER/nightreader-pro.git
   ```

4. **Install dependencies**
   ```bash
   flutter pub get
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## 📋 Contribution Workflow

### 1. Create a Branch

Always create a new branch for your work:

```bash
# For bug fixes
git checkout -b fix/issue-description

# For new features
git checkout -b feature/feature-name

# For documentation
git checkout -b docs/what-you-are-documenting
```

**Examples:**
- `fix/crash-on-large-pdf`
- `feature/text-to-speech`
- `docs/installation-guide`

### 2. Make Your Changes

- Write clean, readable code
- Follow Dart/Flutter style guidelines
- Add comments for complex logic
- Test your changes thoroughly

### 3. Test Your Changes

Before submitting:

```bash
# Run tests
flutter test

# Check for issues
flutter analyze

# Test on real device
flutter run --release
```

**Testing checklist:**
- [ ] App runs without crashes
- [ ] Feature works as expected
- [ ] No regressions (existing features still work)
- [ ] Tested on Android (if applicable)
- [ ] Tested on iOS (if applicable)
- [ ] Tested on Windows (if applicable)

### 4. Commit Your Changes

Write clear, meaningful commit messages:

```bash
# Good commit messages
git commit -m "Fix crash when opening PDFs larger than 100MB"
git commit -m "Add text-to-speech functionality for accessibility"
git commit -m "Update README with new installation instructions"

# Bad commit messages ❌
git commit -m "fix bug"
git commit -m "changes"
git commit -m "update"
```

**Commit message format:**
```
<type>: <short description>

<optional longer description>

Fixes #123
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance tasks

### 5. Push to Your Fork

```bash
git push origin your-branch-name
```

### 6. Create a Pull Request

1. Go to your fork on GitHub
2. Click "Pull Request" button
3. Select your branch
4. Fill in the PR template:

```markdown
## Description
Brief description of what this PR does

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Code refactoring

## Related Issue
Fixes #(issue number)

## Testing
- [ ] Tested on Android
- [ ] Tested on iOS
- [ ] Tested on Windows
- [ ] Added/updated tests

## Screenshots (if applicable)
[Add screenshots here]

## Checklist
- [ ] My code follows the project's style guidelines
- [ ] I have commented my code where necessary
- [ ] I have updated the documentation
- [ ] My changes don't introduce new warnings
- [ ] I have tested my changes
```

5. Submit the PR
6. Wait for review

### 7. Code Review Process

- Maintainers will review your PR
- They may request changes
- Make requested changes in your branch
- Push updates (they'll automatically appear in the PR)
- Once approved, your PR will be merged! 🎉

## 💻 Code Style Guidelines

### Dart/Flutter Best Practices

1. **Follow official Dart style guide**: https://dart.dev/guides/language/effective-dart

2. **Use meaningful names**:
   ```dart
   // Good ✅
   final String documentTitle;
   void openPdfDocument();
   
   // Bad ❌
   final String dt;
   void opnDoc();
   ```

3. **Keep functions small and focused**:
   ```dart
   // Good ✅
   void loadDocument() {
     validateDocument();
     parsePdfContent();
     displayDocument();
   }
   
   // Bad ❌
   void loadDocument() {
     // 200 lines of code doing everything
   }
   ```

4. **Add comments for complex logic**:
   ```dart
   // Good ✅
   // Calculate reading progress as percentage
   // considering bookmarked pages and last position
   double calculateProgress() {
     return (currentPage / totalPages) * 100;
   }
   
   // Bad ❌
   double calc() {
     return (c / t) * 100;
   }
   ```

5. **Use const where possible**:
   ```dart
   const SizedBox(height: 16),
   const EdgeInsets.all(8),
   ```

### Widget Organization

```dart
class MyWidget extends StatelessWidget {
  // 1. Fields
  final String title;
  
  // 2. Constructor
  const MyWidget({required this.title});
  
  // 3. Build method
  @override
  Widget build(BuildContext context) {
    return _buildMainContent();
  }
  
  // 4. Private helper methods
  Widget _buildMainContent() { ... }
  Widget _buildHeader() { ... }
}
```

### File Structure

```
lib/
  models/          # Data models
  screens/         # App screens
  widgets/         # Reusable widgets
  services/        # Business logic
  utils/           # Utilities and helpers
```

## 🧪 Testing

### Writing Tests

Add tests for new features:

```dart
// test/models/pdf_document_test.dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PDFDocument', () {
    test('calculates reading progress correctly', () {
      final doc = PDFDocument(
        currentPage: 50,
        totalPages: 100,
      );
      
      expect(doc.readingProgress, 50.0);
    });
  });
}
```

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/models/pdf_document_test.dart

# Run with coverage
flutter test --coverage
```

## 📚 Documentation

### Code Documentation

Use dartdoc comments for public APIs:

```dart
/// Opens a PDF document from the given [path].
///
/// Returns `true` if successful, `false` otherwise.
/// Throws [FileNotFoundException] if the file doesn't exist.
///
/// Example:
/// ```dart
/// final success = await openDocument('/path/to/file.pdf');
/// if (success) {
///   print('Document opened!');
/// }
/// ```
Future<bool> openDocument(String path) async { ... }
```

### README Updates

If your changes affect how users interact with the app, update README.md

## 🎯 Priority Areas for Contribution

We especially welcome contributions in these areas:

### High Priority
- 🐛 Bug fixes (check Issues labeled `bug`)
- ♿ Accessibility improvements
- 🌍 Translations to other languages
- 📱 iOS-specific features and fixes
- 🪟 Windows-specific improvements

### Medium Priority
- ✨ New annotation types
- 🎨 UI/UX improvements
- ⚡ Performance optimizations
- 📖 Documentation improvements

### Feature Requests
Check Issues labeled `enhancement` for requested features

## 🌍 Translations

Want to translate the app to your language?

1. Create a new file: `lib/l10n/app_[language_code].arb`
2. Copy from `app_en.arb`
3. Translate all strings
4. Update `l10n.yaml`
5. Submit PR

Example:
```json
{
  "appTitle": "NightReader Pro",
  "openDocument": "Open Document",
  "darkMode": "Dark Mode"
}
```

## ❓ Questions?

- 💬 Open a [Discussion](https://github.com/YOUR_USERNAME/nightreader-pro/discussions)
- 🐛 Create an [Issue](https://github.com/YOUR_USERNAME/nightreader-pro/issues)
- 📧 Email: your-email@example.com

## 🏆 Recognition

All contributors will be recognized in:
- README.md Contributors section
- Release notes
- Special thanks in the app's About section

## 📜 Code of Conduct

Please note that this project follows our [Code of Conduct](CODE_OF_CONDUCT.md). 
By participating, you're expected to uphold this code.

## 🙏 Thank You!

Your contributions make this project better for everyone. We appreciate your time and effort!

---

**Happy coding!** 🚀
