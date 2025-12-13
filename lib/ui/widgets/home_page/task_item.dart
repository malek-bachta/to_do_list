import 'package:flutter/material.dart';
import 'package:to_do_list/ui/widgets/home_page/task_item/task_checkbox.dart';
import 'package:to_do_list/ui/widgets/home_page/task_item/task_content.dart';

class TaskListItem extends StatelessWidget {
  final Map task;
  final String taskId;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskListItem({
    super.key,
    required this.task,
    required this.taskId,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key!,
      background: _buildDismissBackground(context),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      child: _buildTaskCard(context),
    );
  }

  Widget _buildDismissBackground(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.012),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
        ),
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: screenWidth * 0.05),
      child: Icon(
        Icons.delete_rounded,
        color: Colors.white,
        size: screenWidth * 0.07,
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final isCompleted = task['completed'] ?? false;
    final taskColor = task['color'] ?? const Color(0xFF6C63FF);
    final dueDateTime = _parseDueDateTime();
    final isOverdue = _isOverdue(dueDateTime, isCompleted);
    final isDueToday = _isDueToday(dueDateTime, isCompleted);

    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.012),
      decoration: _buildCardDecoration(
        isDark,
        isCompleted,
        taskColor,
        isOverdue,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTaskRow(
                  context,
                  isCompleted,
                  taskColor,
                  isDark,
                  screenWidth,
                ),
                if (dueDateTime != null) ...[
                  SizedBox(height: screenWidth * 0.04),
                  _buildDueDateChip(
                    context,
                    dueDateTime,
                    isOverdue,
                    isDueToday,
                    screenWidth,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskRow(
    BuildContext context,
    bool isCompleted,
    Color taskColor,
    bool isDark,
    double screenWidth,
  ) {
    return Row(
      children: [
        TaskCheckbox(
          isCompleted: isCompleted,
          taskColor: taskColor,
          isDark: isDark,
        ),
        SizedBox(width: screenWidth * 0.04),
        Expanded(
          child: TaskContent(
            isCompleted: isCompleted,
            isDark: isDark,
            task: task,
          ),
        ),
        SizedBox(width: screenWidth * 0.03),
        _buildEditButton(context, taskColor, screenWidth),
      ],
    );
  }

  Widget _buildEditButton(
    BuildContext context,
    Color taskColor,
    double screenWidth,
  ) {
    final buttonSize = screenWidth * 0.105;
    final iconSize = screenWidth * 0.05;
    final borderRadius = screenWidth * 0.05;

    return Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [taskColor.withOpacity(0.2), taskColor.withOpacity(0.1)],
        ),
        borderRadius: BorderRadius.circular(borderRadius * 0.5),
      ),
      child: IconButton(
        icon: Icon(Icons.edit_rounded, color: taskColor, size: iconSize),
        onPressed: onEdit,
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildDueDateChip(
    BuildContext context,
    DateTime dueDateTime,
    bool isOverdue,
    bool isDueToday,
    double screenWidth,
  ) {
    Color chipColor;
    IconData chipIcon;
    String timeText;

    if (isOverdue) {
      chipColor = const Color(0xFFEF4444);
      chipIcon = Icons.warning_rounded;
      timeText = 'Overdue';
    } else if (isDueToday) {
      chipColor = const Color(0xFFFBBF24);
      chipIcon = Icons.today_rounded;
      timeText = 'Today at ${_formatTime(dueDateTime)}';
    } else {
      chipColor = const Color(0xFF6C63FF);
      chipIcon = Icons.schedule_rounded;
      timeText = _formatDateTime(dueDateTime);
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.035,
        vertical: screenWidth * 0.019,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [chipColor.withOpacity(0.2), chipColor.withOpacity(0.15)],
        ),
        borderRadius: BorderRadius.circular(screenWidth * 0.025),
        border: Border.all(color: chipColor.withOpacity(0.3), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(chipIcon, size: screenWidth * 0.04, color: chipColor),
          SizedBox(width: screenWidth * 0.019),
          Text(
            timeText,
            style: TextStyle(
              fontSize: screenWidth * 0.032,
              fontWeight: FontWeight.w700,
              color: chipColor,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildCardDecoration(
    bool isDark,
    bool isCompleted,
    Color taskColor,
    bool isOverdue,
  ) {
    return BoxDecoration(
      color: isDark ? const Color(0xFF1A1A2E).withOpacity(0.8) : Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: isOverdue
            ? const Color(0xFFEF4444)
            : (isCompleted
                  ? taskColor.withOpacity(0.4)
                  : (isDark
                        ? const Color(0xFF2D2D44)
                        : const Color(0xFFE5E7EB))),
        width: 2,
      ),
      boxShadow: [
        BoxShadow(
          color: isCompleted
              ? taskColor.withOpacity(0.1)
              : (isDark ? Colors.black26 : Colors.black.withOpacity(0.05)),
          blurRadius: 15,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }

  DateTime? _parseDueDateTime() {
    final dueDateTimeStr = task['dueDateTime'];
    return dueDateTimeStr != null ? DateTime.parse(dueDateTimeStr) : null;
  }

  bool _isOverdue(DateTime? dueDateTime, bool isCompleted) {
    return dueDateTime != null &&
        !isCompleted &&
        DateTime.now().isAfter(dueDateTime);
  }

  bool _isDueToday(DateTime? dueDateTime, bool isCompleted) {
    if (dueDateTime == null || isCompleted) return false;
    final now = DateTime.now();
    return dueDateTime.year == now.year &&
        dueDateTime.month == now.month &&
        dueDateTime.day == now.day;
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _formatDateTime(DateTime dateTime) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[dateTime.month - 1]} ${dateTime.day} at ${_formatTime(dateTime)}';
  }
}
