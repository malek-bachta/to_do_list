import 'package:flutter/material.dart';

class TaskContent extends StatelessWidget {
  final Map task;
  final bool isCompleted;
  final bool isDark;

  const TaskContent({
    super.key,
    required this.task,
    required this.isCompleted,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final titleFontSize = screenWidth * 0.04;
    final descFontSize = screenWidth * 0.035;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(titleFontSize),
        if (_hasDescription) ...[
          SizedBox(height: titleFontSize * 0.375),
          _buildDescription(descFontSize),
        ],
      ],
    );
  }

  Widget _buildTitle(double fontSize) {
    return Text(
      task['title'] ?? '',
      style: TextStyle(
        decoration: isCompleted ? TextDecoration.lineThrough : null,
        decorationColor: isDark
            ? const Color(0xFF6B7280)
            : const Color(0xFF9CA3AF),
        decorationThickness: 2,
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
        color: isCompleted
            ? (isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF))
            : (isDark ? const Color(0xFFE8E8F0) : const Color(0xFF1F1F3D)),
      ),
    );
  }

  Widget _buildDescription(double fontSize) {
    return Text(
      task['description'] ?? '',
      style: TextStyle(
        decoration: isCompleted ? TextDecoration.lineThrough : null,
        decorationColor: isDark
            ? const Color(0xFF4B5563)
            : const Color(0xFFD1D5DB),
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: isCompleted
            ? (isDark ? const Color(0xFF4B5563) : const Color(0xFFD1D5DB))
            : (isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  bool get _hasDescription => (task['description'] ?? '').toString().isNotEmpty;
}
