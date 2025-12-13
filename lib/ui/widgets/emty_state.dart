import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final bool hasSearchQuery;

  const EmptyState({super.key, this.hasSearchQuery = false});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final containerSize = screenWidth * 0.3;
    final iconSize = screenWidth * 0.14;
    final titleFontSize = screenWidth * 0.065;
    final subtitleFontSize = screenWidth * 0.037;
    final hintFontSize = screenWidth * 0.035;
    final borderRadius = screenWidth * 0.08;
    final spacing = screenHeight * 0.02;
    final hintIconSize = screenWidth * 0.05;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: containerSize,
                height: containerSize,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: hasSearchQuery
                        ? [
                            const Color(0xFFFBBF24).withOpacity(0.2),
                            const Color(0xFFF59E0B).withOpacity(0.1),
                          ]
                        : [
                            const Color(0xFF6C63FF).withOpacity(0.2),
                            const Color(0xFF2DD4BF).withOpacity(0.1),
                          ],
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(
                    color: hasSearchQuery
                        ? const Color(0xFFFBBF24).withOpacity(0.3)
                        : const Color(0xFF6C63FF).withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Icon(
                  hasSearchQuery
                      ? Icons.search_off_rounded
                      : Icons.task_alt_rounded,
                  size: iconSize,
                  color: hasSearchQuery
                      ? const Color(0xFFFBBF24)
                      : const Color(0xFF6C63FF),
                ),
              ),
              SizedBox(height: spacing * 1.6),
              Text(
                hasSearchQuery ? 'No results found' : 'No tasks yet',
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spacing * 0.6),
              Text(
                hasSearchQuery
                    ? 'Try a different search term'
                    : 'Tap the + button to create your first task',
                style: TextStyle(
                  fontSize: subtitleFontSize,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? const Color(0xFF9CA3AF)
                      : const Color(0xFF6B7280),
                ),
                textAlign: TextAlign.center,
              ),
              if (!hasSearchQuery) ...[
                SizedBox(height: spacing * 1.6),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.06,
                    vertical: screenHeight * 0.02,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF6C63FF).withOpacity(0.15),
                        const Color(0xFF2DD4BF).withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(borderRadius * 0.5),
                    border: Border.all(
                      color: const Color(0xFF6C63FF).withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.lightbulb_rounded,
                        color: const Color(0xFF6C63FF),
                        size: hintIconSize,
                      ),
                      SizedBox(width: spacing * 0.6),
                      Flexible(
                        child: Text(
                          'Start organizing your day!',
                          style: TextStyle(
                            fontSize: hintFontSize,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
