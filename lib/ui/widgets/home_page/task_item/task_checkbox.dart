import 'package:flutter/material.dart';

class TaskCheckbox extends StatelessWidget {
  final bool isCompleted;
  final Color taskColor;
  final bool isDark;

  const TaskCheckbox({
    super.key,
    required this.isCompleted,
    required this.taskColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.07;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: isCompleted
            ? LinearGradient(colors: [taskColor, taskColor.withOpacity(0.7)])
            : null,
        color: !isCompleted ? Colors.transparent : null,
        border: !isCompleted
            ? Border.all(
                color: isDark ? const Color(0xFF4B5563) : const Color(0xFFD1D5DB),
                width: 2.5,
              )
            : null,
        boxShadow: isCompleted
            ? [
                BoxShadow(
                  color: taskColor.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
      child: isCompleted
          ? Icon(Icons.check_rounded, color: Colors.white, size: size * 0.65)
          : null,
    );
  }
}