import 'package:flutter/material.dart';
import 'dart:io';
import '../models/pdf_document.dart';
import '../widgets/pdf_card.dart';
import 'pdf_reader_screen.dart';
import 'package:file_picker/file_picker.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  
  const HomeScreen({Key? key, required this.onToggleTheme}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PDFDocument> _documents = [];
  String _searchQuery = '';
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadRecentDocuments();
  }

  void _loadRecentDocuments() {
    // This would load from local storage/database
    // For now, using sample data
    setState(() {
      _documents = [
        PDFDocument(
          id: '1',
          title: 'Sample Document.pdf',
          path: '/path/to/sample.pdf',
          lastOpened: DateTime.now().subtract(const Duration(hours: 2)),
          totalPages: 150,
          currentPage: 45,
        ),
      ];
    });
  }

  Future<void> _pickAndOpenPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final doc = PDFDocument(
          id: DateTime.now().toString(),
          title: result.files.single.name,
          path: file.path,
          lastOpened: DateTime.now(),
          totalPages: 0,
          currentPage: 1,
        );
        
        setState(() {
          _documents.insert(0, doc);
        });
        
        _openDocument(doc);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error opening file: $e')),
      );
    }
  }

  void _openDocument(PDFDocument doc) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFReaderScreen(document: doc),
      ),
    ).then((_) => _loadRecentDocuments());
  }

  List<PDFDocument> get _filteredDocuments {
    if (_searchQuery.isEmpty) return _documents;
    return _documents
        .where((doc) => doc.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NightReader Pro'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
            tooltip: 'Toggle theme',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search documents...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          
          // Documents list
          Expanded(
            child: _filteredDocuments.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.library_books,
                          size: 64,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No documents yet',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap + to add a PDF',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredDocuments.length,
                    itemBuilder: (context, index) {
                      return PDFCard(
                        document: _filteredDocuments[index],
                        onTap: () => _openDocument(_filteredDocuments[index]),
                        onDelete: () {
                          setState(() {
                            _documents.remove(_filteredDocuments[index]);
                          });
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _pickAndOpenPDF,
        icon: const Icon(Icons.add),
        label: const Text('Add PDF'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.library_books),
            label: 'Library',
          ),
          NavigationDestination(
            icon: Icon(Icons.access_time),
            label: 'Recent',
          ),
          NavigationDestination(
            icon: Icon(Icons.folder),
            label: 'Collections',
          ),
        ],
      ),
    );
  }
}
