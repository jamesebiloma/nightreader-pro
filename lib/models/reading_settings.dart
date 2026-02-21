import 'package:flutter/material.dart';

class ReadingSettings {
  final Color backgroundColor;
  final Color pageColor;
  final Color textColor;
  final double brightness;
  final bool nightMode;
  final bool sepia;
  final ReadingMode readingMode;
  final double fontSize;
  final double lineSpacing;
  final double pageMargin;
  final bool autoScroll;
  final double scrollSpeed;

  ReadingSettings({
    this.backgroundColor = const Color(0xFF0D0D0D),
    this.pageColor = const Color(0xFF1A1A1A),
    this.textColor = const Color(0xFFE0E0E0),
    this.brightness = 0.8,
    this.nightMode = true,
    this.sepia = false,
    this.readingMode = ReadingMode.continuous,
    this.fontSize = 16.0,
    this.lineSpacing = 1.5,
    this.pageMargin = 16.0,
    this.autoScroll = false,
    this.scrollSpeed = 1.0,
  });

  ReadingSettings copyWith({
    Color? backgroundColor,
    Color? pageColor,
    Color? textColor,
    double? brightness,
    bool? nightMode,
    bool? sepia,
    ReadingMode? readingMode,
    double? fontSize,
    double? lineSpacing,
    double? pageMargin,
    bool? autoScroll,
    double? scrollSpeed,
  }) {
    return ReadingSettings(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      pageColor: pageColor ?? this.pageColor,
      textColor: textColor ?? this.textColor,
      brightness: brightness ?? this.brightness,
      nightMode: nightMode ?? this.nightMode,
      sepia: sepia ?? this.sepia,
      readingMode: readingMode ?? this.readingMode,
      fontSize: fontSize ?? this.fontSize,
      lineSpacing: lineSpacing ?? this.lineSpacing,
      pageMargin: pageMargin ?? this.pageMargin,
      autoScroll: autoScroll ?? this.autoScroll,
      scrollSpeed: scrollSpeed ?? this.scrollSpeed,
    );
  }

  // Predefined color schemes
  static ReadingSettings get nightMode => ReadingSettings(
        backgroundColor: const Color(0xFF0D0D0D),
        pageColor: const Color(0xFF1A1A1A),
        textColor: const Color(0xFFE0E0E0),
        nightMode: true,
        sepia: false,
      );

  static ReadingSettings get sepiaTone => ReadingSettings(
        backgroundColor: const Color(0xFFF4ECD8),
        pageColor: const Color(0xFFF9F5E8),
        textColor: const Color(0xFF5C4A3A),
        nightMode: false,
        sepia: true,
      );

  static ReadingSettings get dayMode => ReadingSettings(
        backgroundColor: const Color(0xFFF5F5F5),
        pageColor: const Color(0xFFFFFFFF),
        textColor: const Color(0xFF212121),
        nightMode: false,
        sepia: false,
      );

  static ReadingSettings get trueDark => ReadingSettings(
        backgroundColor: const Color(0xFF000000),
        pageColor: const Color(0xFF000000),
        textColor: const Color(0xFFB0B0B0),
        brightness: 0.6,
        nightMode: true,
        sepia: false,
      );
}

enum ReadingMode {
  continuous,
  paginated,
  dualPage,
}

class ReadingSettingsSheet extends StatefulWidget {
  final ReadingSettings settings;
  final Function(ReadingSettings) onSettingsChanged;

  const ReadingSettingsSheet({
    Key? key,
    required this.settings,
    required this.onSettingsChanged,
  }) : super(key: key);

  @override
  State<ReadingSettingsSheet> createState() => _ReadingSettingsSheetState();
}

class _ReadingSettingsSheetState extends State<ReadingSettingsSheet> {
  late ReadingSettings _settings;

  @override
  void initState() {
    super.initState();
    _settings = widget.settings;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reading Settings',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 24),

                  // Color schemes
                  Text(
                    'Color Scheme',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildColorSchemeButton(
                        'Night',
                        ReadingSettings.nightMode,
                        Icons.nightlight_round,
                      ),
                      _buildColorSchemeButton(
                        'Sepia',
                        ReadingSettings.sepiaTone,
                        Icons.wb_sunny,
                      ),
                      _buildColorSchemeButton(
                        'Day',
                        ReadingSettings.dayMode,
                        Icons.light_mode,
                      ),
                      _buildColorSchemeButton(
                        'True Dark',
                        ReadingSettings.trueDark,
                        Icons.dark_mode,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Brightness
                  Text(
                    'Brightness: ${(_settings.brightness * 100).round()}%',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Slider(
                    value: _settings.brightness,
                    min: 0.3,
                    max: 1.0,
                    divisions: 14,
                    onChanged: (value) {
                      setState(() {
                        _settings = _settings.copyWith(brightness: value);
                      });
                      widget.onSettingsChanged(_settings);
                    },
                  ),
                  const SizedBox(height: 16),

                  // Font size
                  Text(
                    'Font Size: ${_settings.fontSize.round()}pt',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Slider(
                    value: _settings.fontSize,
                    min: 12.0,
                    max: 24.0,
                    divisions: 12,
                    onChanged: (value) {
                      setState(() {
                        _settings = _settings.copyWith(fontSize: value);
                      });
                      widget.onSettingsChanged(_settings);
                    },
                  ),
                  const SizedBox(height: 16),

                  // Page margin
                  Text(
                    'Page Margin: ${_settings.pageMargin.round()}px',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Slider(
                    value: _settings.pageMargin,
                    min: 0.0,
                    max: 48.0,
                    divisions: 12,
                    onChanged: (value) {
                      setState(() {
                        _settings = _settings.copyWith(pageMargin: value);
                      });
                      widget.onSettingsChanged(_settings);
                    },
                  ),
                  const SizedBox(height: 16),

                  // Auto-scroll
                  SwitchListTile(
                    title: const Text('Auto-scroll'),
                    subtitle: const Text('Automatically scroll through pages'),
                    value: _settings.autoScroll,
                    onChanged: (value) {
                      setState(() {
                        _settings = _settings.copyWith(autoScroll: value);
                      });
                      widget.onSettingsChanged(_settings);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorSchemeButton(
    String label,
    ReadingSettings scheme,
    IconData icon,
  ) {
    final isSelected = _settings.backgroundColor == scheme.backgroundColor;

    return GestureDetector(
      onTap: () {
        setState(() {
          _settings = scheme;
        });
        widget.onSettingsChanged(_settings);
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: scheme.backgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                width: 3,
              ),
            ),
            child: Icon(
              icon,
              color: scheme.textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
