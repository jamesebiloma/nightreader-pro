import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/pdf_document.dart';
import '../widgets/reading_controls.dart';
import '../widgets/table_of_contents.dart';
import '../widgets/annotation_tools.dart';
import '../models/reading_settings.dart';

class PDFReaderScreen extends StatefulWidget {
  final PDFDocument document;

  const PDFReaderScreen({Key? key, required this.document}) : super(key: key);

  @override
  State<PDFReaderScreen> createState() => _PDFReaderScreenState();
}

class _PDFReaderScreenState extends State<PDFReaderScreen> {
  int _currentPage = 1;
  int _totalPages = 150; // Would be loaded from actual PDF
  double _zoom = 1.0;
  bool _isFullscreen = false;
  bool _showControls = true;
  ReadingSettings _settings = ReadingSettings();
  
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _currentPage = widget.document.currentPage;
    _totalPages = widget.document.totalPages;
    
    // Auto-hide controls after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  void _toggleFullscreen() {
    setState(() {
      _isFullscreen = !_isFullscreen;
      if (_isFullscreen) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      }
    });
  }

  void _showTableOfContents() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TableOfContents(
        onPageSelected: (page) {
          setState(() {
            _currentPage = page;
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showAnnotationTools() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const AnnotationTools(),
    );
  }

  void _showReadingSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReadingSettingsSheet(
        settings: _settings,
        onSettingsChanged: (newSettings) {
          setState(() {
            _settings = newSettings;
          });
        },
      ),
    );
  }

  void _goToPage(int page) {
    if (page >= 1 && page <= _totalPages) {
      setState(() {
        _currentPage = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _settings.backgroundColor,
      body: GestureDetector(
        onTap: () {
          setState(() {
            _showControls = !_showControls;
          });
        },
        child: Stack(
          children: [
            // PDF Content Area
            Center(
              child: Container(
                color: _settings.backgroundColor,
                child: _buildPDFViewer(),
              ),
            ),

            // Top App Bar (Animated)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              top: _showControls ? 0 : -100,
              left: 0,
              right: 0,
              child: _buildTopBar(),
            ),

            // Bottom Controls (Animated)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: _showControls ? 0 : -150,
              left: 0,
              right: 0,
              child: _buildBottomControls(),
            ),

            // Side Tools (when in fullscreen)
            if (_isFullscreen && _showControls)
              Positioned(
                right: 16,
                top: MediaQuery.of(context).size.height / 2 - 100,
                child: _buildSideTools(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor?.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.document.title,
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Page $_currentPage of $_totalPages',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // Search functionality
                },
              ),
              IconButton(
                icon: Icon(_isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen),
                onPressed: _toggleFullscreen,
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  _showOptionsMenu();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Page slider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Text(
                    '$_currentPage',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Expanded(
                    child: Slider(
                      value: _currentPage.toDouble(),
                      min: 1,
                      max: _totalPages.toDouble(),
                      divisions: _totalPages,
                      onChanged: (value) {
                        setState(() {
                          _currentPage = value.round();
                        });
                      },
                    ),
                  ),
                  Text(
                    '$_totalPages',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            
            // Control buttons
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.list),
                    onPressed: _showTableOfContents,
                    tooltip: 'Table of Contents',
                  ),
                  IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {
                      // Add bookmark
                    },
                    tooltip: 'Bookmark',
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: _showAnnotationTools,
                    tooltip: 'Annotate',
                  ),
                  IconButton(
                    icon: const Icon(Icons.tune),
                    onPressed: _showReadingSettings,
                    tooltip: 'Settings',
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      // Share
                    },
                    tooltip: 'Share',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSideTools() {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () {
              setState(() {
                _zoom = (_zoom + 0.25).clamp(0.5, 3.0);
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: () {
              setState(() {
                _zoom = (_zoom - 0.25).clamp(0.5, 3.0);
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.rotate_right),
            onPressed: () {
              // Rotate page
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPDFViewer() {
    // This is a placeholder. In real implementation, use flutter_pdfview or syncfusion_flutter_pdfviewer
    return Container(
      margin: EdgeInsets.all(_settings.pageMargin),
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (page) {
          setState(() {
            _currentPage = page + 1;
          });
        },
        itemCount: _totalPages,
        itemBuilder: (context, index) {
          return Transform.scale(
            scale: _zoom,
            child: Container(
              decoration: BoxDecoration(
                color: _settings.pageColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.picture_as_pdf,
                      size: 80,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Page ${index + 1}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'PDF content would be rendered here',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showOptionsMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.print),
              title: const Text('Print'),
              onTap: () {
                Navigator.pop(context);
                // Print functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_download),
              title: const Text('Export'),
              onTap: () {
                Navigator.pop(context);
                // Export functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Document Info'),
              onTap: () {
                Navigator.pop(context);
                // Show document info
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }
}
