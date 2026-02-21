import 'package:flutter/material.dart';

class TableOfContents extends StatelessWidget {
  final Function(int) onPageSelected;

  const TableOfContents({
    Key? key,
    required this.onPageSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample TOC data - in real app, this would be extracted from PDF
    final tocItems = [
      TOCItem(title: 'Introduction', page: 1, level: 0),
      TOCItem(title: 'Getting Started', page: 5, level: 0),
      TOCItem(title: 'Installation', page: 6, level: 1),
      TOCItem(title: 'Configuration', page: 10, level: 1),
      TOCItem(title: 'Basic Concepts', page: 15, level: 0),
      TOCItem(title: 'Architecture', page: 16, level: 1),
      TOCItem(title: 'Components', page: 20, level: 1),
      TOCItem(title: 'Widgets', page: 21, level: 2),
      TOCItem(title: 'State Management', page: 25, level: 2),
      TOCItem(title: 'Advanced Topics', page: 30, level: 0),
      TOCItem(title: 'Performance Optimization', page: 31, level: 1),
      TOCItem(title: 'Testing', page: 40, level: 1),
      TOCItem(title: 'Deployment', page: 50, level: 1),
      TOCItem(title: 'Conclusion', page: 60, level: 0),
    ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
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

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  'Table of Contents',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          const Divider(),

          // TOC list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: tocItems.length,
              itemBuilder: (context, index) {
                final item = tocItems[index];
                return _buildTOCItem(context, item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTOCItem(BuildContext context, TOCItem item) {
    return InkWell(
      onTap: () => onPageSelected(item.page),
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.0 + (item.level * 24.0),
          right: 16.0,
          top: 12.0,
          bottom: 12.0,
        ),
        child: Row(
          children: [
            if (item.level > 0)
              Container(
                width: 4,
                height: 4,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
            Expanded(
              child: Text(
                item.title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight:
                          item.level == 0 ? FontWeight.w600 : FontWeight.w400,
                    ),
              ),
            ),
            Text(
              item.page.toString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class TOCItem {
  final String title;
  final int page;
  final int level;

  TOCItem({
    required this.title,
    required this.page,
    required this.level,
  });
}
