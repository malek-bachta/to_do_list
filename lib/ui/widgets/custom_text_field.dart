import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final bool autofocus;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final screenWidth = MediaQuery.of(context).size.width;

    final borderRadius = screenWidth * 0.04;
    final fontSize = screenWidth * 0.037;
    final padding = screenWidth * 0.045;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F0F23) : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: isDark ? const Color(0xFF2D2D44) : const Color(0xFFE5E7EB),
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: controller,
        autofocus: autofocus,
        maxLines: maxLines,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF),
            fontWeight: FontWeight.w500,
            fontSize: fontSize,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(padding),
        ),
      ),
    );
  }
}
