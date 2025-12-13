import 'package:flutter/material.dart';
import 'package:to_do_list/core/models/category_model.dart';

class CategoryChip extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onTap;
  final int taskCount;

  const CategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
    this.taskCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.only(right: screenWidth * 0.03),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenWidth * 0.03,
        ),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [category.color, category.color.withOpacity(0.7)],
                )
              : null,
          color: !isSelected
              ? (isDark
                    ? const Color(0xFF1A1A2E).withOpacity(0.6)
                    : Colors.white.withOpacity(0.8))
              : null,
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
          border: Border.all(
            color: isSelected
                ? category.color
                : (isDark ? const Color(0xFF2D2D44) : const Color(0xFFE5E7EB)),
            width: 2,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: category.color.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              category.icon,
              color: isSelected
                  ? Colors.white
                  : (isDark ? const Color(0xFF9CA3AF) : category.color),
              size: screenWidth * 0.05,
            ),
            SizedBox(width: screenWidth * 0.02),
            Text(
              category.name,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : (isDark
                          ? const Color(0xFFE8E8F0)
                          : const Color(0xFF1F1F3D)),
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (taskCount > 0) ...[
              SizedBox(width: screenWidth * 0.015),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenWidth * 0.005,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withOpacity(0.3)
                      : category.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(screenWidth * 0.025),
                ),
                child: Text(
                  '$taskCount',
                  style: TextStyle(
                    color: isSelected ? Colors.white : category.color,
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
