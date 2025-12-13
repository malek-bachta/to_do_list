import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/core/models/category_model.dart';
import 'custom_text_field.dart';

class TaskDialog {
  static void show({
    required BuildContext context,
    String title = 'New Task',
    String initialTitle = '',
    String initialDescription = '',
    DateTime? initialDueDateTime,
    String? initialCategoryId,
    required Function(
      String title,
      String description,
      DateTime? dueDateTime,
      String? categoryId,
    )
    onSave,
  }) {
    final titleController = TextEditingController(text: initialTitle);
    final descriptionController = TextEditingController(
      text: initialDescription,
    );
    DateTime? selectedDueDateTime = initialDueDateTime;
    String? selectedCategoryId = initialCategoryId;
    final categories = CategoryModel.getDefaultCategories()
        .where((cat) => cat.id != 'all')
        .toList();

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.75),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final screenWidth = MediaQuery.of(context).size.width;
          final screenHeight = MediaQuery.of(context).size.height;

          final dialogPadding = screenWidth * 0.05;
          final headerIconSize = screenWidth * 0.06;
          final titleFontSize = screenWidth * 0.065;
          final normalFontSize = screenWidth * 0.035;
          final smallFontSize = screenWidth * 0.03;
          final spacing = screenHeight * 0.02;
          final borderRadius = screenWidth * 0.04;
          final iconSize = screenWidth * 0.05;

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Dialog(
              backgroundColor: isDark ? const Color(0xFF1A1A2E) : Colors.white,
              surfaceTintColor: Colors.transparent,
              insetPadding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.05,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: BorderSide(
                  color: const Color(0xFF6C63FF).withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: screenWidth * 0.9,
                  maxHeight: screenHeight * 0.85,
                ),
                padding: EdgeInsets.all(dialogPadding),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(screenWidth * 0.025),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF6C63FF), Color(0xFF2DD4BF)],
                              ),
                              borderRadius: BorderRadius.circular(
                                borderRadius * 0.5,
                              ),
                            ),
                            child: Icon(
                              Icons.add_task_rounded,
                              color: Colors.white,
                              size: headerIconSize,
                            ),
                          ),
                          SizedBox(width: spacing),
                          Flexible(
                            child: Text(
                              title,
                              style: TextStyle(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spacing * 1.5),

                      CustomTextField(
                        controller: titleController,
                        hint: 'Task title',
                        autofocus: false,
                      ),

                      SizedBox(height: spacing),

                      CustomTextField(
                        controller: descriptionController,
                        hint: 'Description',
                        maxLines: 3,
                      ),

                      SizedBox(height: spacing * 1.2),

                      Text(
                        'CATEGORY',
                        style: TextStyle(
                          fontSize: smallFontSize,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                          color: isDark
                              ? const Color(0xFF9CA3AF)
                              : const Color(0xFF6B7280),
                        ),
                      ),

                      SizedBox(height: spacing * 0.6),

                      SizedBox(
                        height: screenHeight * 0.065,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            final isSelected =
                                selectedCategoryId == category.id;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCategoryId = category.id;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  right: screenWidth * 0.025,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.04,
                                  vertical: screenWidth * 0.025,
                                ),
                                decoration: BoxDecoration(
                                  gradient: isSelected
                                      ? LinearGradient(
                                          colors: [
                                            category.color,
                                            category.color.withOpacity(0.7),
                                          ],
                                        )
                                      : null,
                                  color: !isSelected
                                      ? (isDark
                                            ? const Color(0xFF0F0F23)
                                            : const Color(0xFFF3F4F6))
                                      : null,
                                  borderRadius: BorderRadius.circular(
                                    borderRadius * 0.5,
                                  ),
                                  border: Border.all(
                                    color: isSelected
                                        ? category.color
                                        : (isDark
                                              ? const Color(0xFF2D2D44)
                                              : const Color(0xFFE5E7EB)),
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      category.icon,
                                      color: isSelected
                                          ? Colors.white
                                          : category.color,
                                      size: iconSize * 0.9,
                                    ),
                                    SizedBox(width: screenWidth * 0.015),
                                    Text(
                                      category.name,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Theme.of(
                                                context,
                                              ).colorScheme.onSurface,
                                        fontSize: normalFontSize,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: spacing * 1.2),

                      Text(
                        'DUE DATE & TIME',
                        style: TextStyle(
                          fontSize: smallFontSize,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                          color: isDark
                              ? const Color(0xFF9CA3AF)
                              : const Color(0xFF6B7280),
                        ),
                      ),

                      SizedBox(height: spacing * 0.6),

                      Row(
                        children: [
                          Expanded(
                            child: _buildDateTimeButton(
                              context: context,
                              icon: Icons.calendar_today_rounded,
                              label: selectedDueDateTime != null
                                  ? DateFormat(
                                      'MMM dd, yyyy',
                                    ).format(selectedDueDateTime!)
                                  : 'Select Date',
                              isDark: isDark,
                              iconSize: iconSize,
                              fontSize: normalFontSize,
                              padding: screenWidth * 0.04,
                              borderRadius: borderRadius * 0.5,
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      selectedDueDateTime ?? DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(
                                    const Duration(days: 365),
                                  ),
                                  builder: (context, child) {
                                    return Theme(
                                      data: isDark
                                          ? ThemeData.dark().copyWith(
                                              colorScheme:
                                                  const ColorScheme.dark(
                                                    primary: Color(0xFF6C63FF),
                                                    surface: Color(0xFF1A1A2E),
                                                  ),
                                            )
                                          : ThemeData.light().copyWith(
                                              colorScheme:
                                                  const ColorScheme.light(
                                                    primary: Color(0xFF6C63FF),
                                                    surface: Colors.white,
                                                  ),
                                            ),
                                      child: child!,
                                    );
                                  },
                                );

                                if (date != null) {
                                  setState(() {
                                    if (selectedDueDateTime != null) {
                                      selectedDueDateTime = DateTime(
                                        date.year,
                                        date.month,
                                        date.day,
                                        selectedDueDateTime!.hour,
                                        selectedDueDateTime!.minute,
                                      );
                                    } else {
                                      selectedDueDateTime = date;
                                    }
                                  });
                                }
                              },
                            ),
                          ),
                          SizedBox(width: spacing * 0.6),
                          Expanded(
                            child: _buildDateTimeButton(
                              context: context,
                              icon: Icons.access_time_rounded,
                              label: selectedDueDateTime != null
                                  ? DateFormat(
                                      'HH:mm',
                                    ).format(selectedDueDateTime!)
                                  : 'Select Time',
                              isDark: isDark,
                              iconSize: iconSize,
                              fontSize: normalFontSize,
                              padding: screenWidth * 0.04,
                              borderRadius: borderRadius * 0.5,
                              onTap: () async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: selectedDueDateTime != null
                                      ? TimeOfDay.fromDateTime(
                                          selectedDueDateTime!,
                                        )
                                      : TimeOfDay.now(),
                                  builder: (context, child) {
                                    return Theme(
                                      data: isDark
                                          ? ThemeData.dark().copyWith(
                                              colorScheme:
                                                  const ColorScheme.dark(
                                                    primary: Color(0xFF6C63FF),
                                                    surface: Color(0xFF1A1A2E),
                                                  ),
                                            )
                                          : ThemeData.light().copyWith(
                                              colorScheme:
                                                  const ColorScheme.light(
                                                    primary: Color(0xFF6C63FF),
                                                    surface: Colors.white,
                                                  ),
                                            ),
                                      child: child!,
                                    );
                                  },
                                );

                                if (time != null) {
                                  setState(() {
                                    final now = DateTime.now();
                                    if (selectedDueDateTime != null) {
                                      selectedDueDateTime = DateTime(
                                        selectedDueDateTime!.year,
                                        selectedDueDateTime!.month,
                                        selectedDueDateTime!.day,
                                        time.hour,
                                        time.minute,
                                      );
                                    } else {
                                      selectedDueDateTime = DateTime(
                                        now.year,
                                        now.month,
                                        now.day,
                                        time.hour,
                                        time.minute,
                                      );
                                    }
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),

                      if (selectedDueDateTime != null) ...[
                        SizedBox(height: spacing * 0.8),
                        Container(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF6C63FF).withOpacity(0.15),
                                const Color(0xFF2DD4BF).withOpacity(0.1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(
                              borderRadius * 0.6,
                            ),
                            border: Border.all(
                              color: const Color(0xFF6C63FF).withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(
                                        screenWidth * 0.02,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF6C63FF),
                                        borderRadius: BorderRadius.circular(
                                          borderRadius * 0.35,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.event_available_rounded,
                                        color: Colors.white,
                                        size: iconSize * 0.9,
                                      ),
                                    ),
                                    SizedBox(width: spacing * 0.6),
                                    Flexible(
                                      child: Text(
                                        DateFormat(
                                          'EEE, MMM dd at HH:mm',
                                        ).format(selectedDueDateTime!),
                                        style: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                          fontSize: normalFontSize,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectedDueDateTime = null;
                                  });
                                },
                                padding: EdgeInsets.all(screenWidth * 0.01),
                                constraints: const BoxConstraints(),
                                icon: Icon(
                                  Icons.close_rounded,
                                  color: const Color(0xFF6C63FF),
                                  size: iconSize,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      SizedBox(height: spacing * 1.4),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.06,
                                vertical: screenHeight * 0.02,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  borderRadius * 0.5,
                                ),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: normalFontSize,
                                fontWeight: FontWeight.w700,
                                color: isDark
                                    ? const Color(0xFF9CA3AF)
                                    : const Color(0xFF6B7280),
                              ),
                            ),
                          ),
                          SizedBox(width: spacing * 0.6),
                          Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF6C63FF), Color(0xFF2DD4BF)],
                              ),
                              borderRadius: BorderRadius.circular(
                                borderRadius * 0.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF6C63FF,
                                  ).withOpacity(0.4),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (titleController.text.isEmpty) return;
                                onSave(
                                  titleController.text,
                                  descriptionController.text,
                                  selectedDueDateTime,
                                  selectedCategoryId,
                                );
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.08,
                                  vertical: screenHeight * 0.02,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    borderRadius * 0.5,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Save Task',
                                style: TextStyle(
                                  fontSize: normalFontSize,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  static Widget _buildDateTimeButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isDark,
    required double iconSize,
    required double fontSize,
    required double padding,
    required double borderRadius,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF0F0F23) : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: isDark ? const Color(0xFF2D2D44) : const Color(0xFFE5E7EB),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF6C63FF), size: iconSize),
            SizedBox(width: padding * 0.5),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
