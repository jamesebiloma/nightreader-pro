import 'package:flutter/material.dart';

class AnnotationTools extends StatelessWidget {
  const AnnotationTools({Key? key}) : super(key: key);

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
                    'Annotation Tools',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),

                  // Highlight tools
                  _buildToolSection(
                    context,
                    'Highlight',
                    [
                      _AnnotationTool(
                        icon: Icons.highlight,
                        label: 'Yellow',
                        color: Colors.yellow.shade700,
                      ),
                      _AnnotationTool(
                        icon: Icons.highlight,
                        label: 'Green',
                        color: Colors.green.shade600,
                      ),
                      _AnnotationTool(
                        icon: Icons.highlight,
                        label: 'Blue',
                        color: Colors.blue.shade600,
                      ),
                      _AnnotationTool(
                        icon: Icons.highlight,
                        label: 'Pink',
                        color: Colors.pink.shade400,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Text tools
                  _buildToolSection(
                    context,
                    'Text',
                    [
                      _AnnotationTool(
                        icon: Icons.format_underline,
                        label: 'Underline',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      _AnnotationTool(
                        icon: Icons.strikethrough_s,
                        label: 'Strikethrough',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      _AnnotationTool(
                        icon: Icons.border_color,
                        label: 'Freehand',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Notes & Shapes
                  _buildToolSection(
                    context,
                    'Notes & Shapes',
                    [
                      _AnnotationTool(
                        icon: Icons.note_add,
                        label: 'Add Note',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      _AnnotationTool(
                        icon: Icons.crop_square,
                        label: 'Rectangle',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      _AnnotationTool(
                        icon: Icons.circle_outlined,
                        label: 'Circle',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      _AnnotationTool(
                        icon: Icons.arrow_forward,
                        label: 'Arrow',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolSection(
    BuildContext context,
    String title,
    List<_AnnotationTool> tools,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: tools.map((tool) => _buildToolButton(context, tool)).toList(),
        ),
      ],
    );
  }

  Widget _buildToolButton(BuildContext context, _AnnotationTool tool) {
    return InkWell(
      onTap: () {
        // Handle tool selection
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${tool.label} tool selected')),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 70,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).dividerColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              tool.icon,
              color: tool.color,
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              tool.label,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _AnnotationTool {
  final IconData icon;
  final String label;
  final Color color;

  _AnnotationTool({
    required this.icon,
    required this.label,
    required this.color,
  });
}
