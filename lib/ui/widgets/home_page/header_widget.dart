import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final int completedCount;
  final int totalTasks;
  final double progress;
  final TextEditingController searchController;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onClearSearch;

  const HeaderWidget({
    super.key,
    required this.completedCount,
    required this.totalTasks,
    required this.progress,
    required this.searchController,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(screenWidth * 0.05),
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: _buildHeaderDecoration(isDark),
      child: Column(
        children: [
          _buildTitleSection(context, isDark, screenWidth),
          if (totalTasks > 0) ...[
            SizedBox(height: screenWidth * 0.05),
            _buildProgressSection(isDark, screenWidth),
          ],
          SizedBox(height: screenWidth * 0.05),
          _buildSearchBar(context, isDark, screenWidth),
        ],
      ),
    );
  }

  BoxDecoration _buildHeaderDecoration(bool isDark) {
    return BoxDecoration(
      color: isDark
          ? const Color(0xFF1A1A2E).withOpacity(0.6)
          : Colors.white.withOpacity(0.8),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: const Color(0xFF6C63FF).withOpacity(isDark ? 0.2 : 0.1),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF6C63FF).withOpacity(0.1),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  Widget _buildTitleSection(
    BuildContext context,
    bool isDark,
    double screenWidth,
  ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(screenWidth * 0.02),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6C63FF), Color(0xFF2DD4BF)],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.check_circle_rounded,
            color: Colors.white,
            size: screenWidth * 0.06,
          ),
        ),
        SizedBox(width: screenWidth * 0.03),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Tasks',
                style: TextStyle(
                  fontSize: screenWidth * 0.08,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.onSurface,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                _getSubtitleText(),
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? const Color(0xFF9CA3AF)
                      : const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getSubtitleText() {
    if (totalTasks == 0) return 'Start your productive day';
    if (completedCount == totalTasks) return '🎉 All tasks completed!';
    return '$completedCount of $totalTasks completed';
  }

  Widget _buildProgressSection(bool isDark, double screenWidth) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: TextStyle(
                fontSize: screenWidth * 0.032,
                fontWeight: FontWeight.w700,
                color: isDark
                    ? const Color(0xFF9CA3AF)
                    : const Color(0xFF6B7280),
              ),
            ),
            _buildProgressBadge(screenWidth),
          ],
        ),
        SizedBox(height: screenWidth * 0.03),
        _buildProgressBar(isDark, screenWidth),
      ],
    );
  }

  Widget _buildProgressBadge(double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenWidth * 0.01,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: progress == 1.0
              ? [const Color(0xFF4ADE80), const Color(0xFF22C55E)]
              : [const Color(0xFF6C63FF), const Color(0xFF2DD4BF)],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '${(progress * 100).toInt()}%',
        style: TextStyle(
          fontSize: screenWidth * 0.032,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildProgressBar(bool isDark, double screenWidth) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 10,
        backgroundColor: isDark
            ? const Color(0xFF2D2D44)
            : const Color(0xFFE5E7EB),
        valueColor: AlwaysStoppedAnimation<Color>(
          progress == 1.0 ? const Color(0xFF4ADE80) : const Color(0xFF6C63FF),
        ),
      ),
    );
  }

  Widget _buildSearchBar(
    BuildContext context,
    bool isDark,
    double screenWidth,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F0F23) : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: isDark ? const Color(0xFF2D2D44) : const Color(0xFFE5E7EB),
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: searchController,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: screenWidth * 0.037,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'Search your tasks...',
          hintStyle: TextStyle(
            color: isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF),
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: screenWidth * 0.055,
          ),
          suffixIcon: searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    color: isDark
                        ? const Color(0xFF6B7280)
                        : const Color(0xFF9CA3AF),
                    size: screenWidth * 0.05,
                  ),
                  onPressed: onClearSearch,
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenWidth * 0.045,
          ),
        ),
        onChanged: onSearchChanged,
      ),
    );
  }
}
