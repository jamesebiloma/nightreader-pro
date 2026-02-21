import 'package:flutter/material.dart';

class ReadingControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;
  final VoidCallback onTableOfContents;
  final VoidCallback onBookmark;
  final VoidCallback onAnnotate;
  final VoidCallback onSettings;

  const ReadingControls({
    Key? key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    required this.onTableOfContents,
    required this.onBookmark,
    required this.onAnnotate,
    required this.onSettings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Page navigation slider
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_left),
                  onPressed: currentPage > 1
                      ? () => onPageChanged(currentPage - 1)
                      : null,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Slider(
                        value: currentPage.toDouble(),
                        min: 1,
                        max: totalPages.toDouble(),
                        divisions: totalPages - 1,
                        label: currentPage.toString(),
                        onChanged: (value) => onPageChanged(value.round()),
                      ),
                      Text(
                        'Page $currentPage of $totalPages',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_right),
                  onPressed: currentPage < totalPages
                      ? () => onPageChanged(currentPage + 1)
                      : null,
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildControlButton(
                  context,
                  icon: Icons.list,
                  label: 'Contents',
                  onTap: onTableOfContents,
                ),
                _buildControlButton(
                  context,
                  icon: Icons.bookmark_border,
                  label: 'Bookmark',
                  onTap: onBookmark,
                ),
                _buildControlButton(
                  context,
                  icon: Icons.edit,
                  label: 'Annotate',
                  onTap: onAnnotate,
                ),
                _buildControlButton(
                  context,
                  icon: Icons.tune,
                  label: 'Settings',
                  onTap: onSettings,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 28),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
