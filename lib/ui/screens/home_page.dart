import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/core/providers/task_provider.dart';
import 'package:to_do_list/ui/widgets/category_selector.dart';
import 'package:to_do_list/ui/widgets/emty_state.dart';
import 'package:to_do_list/ui/widgets/home_page/header_widget.dart';
import 'package:to_do_list/ui/widgets/home_page/task_item.dart';
import '../widgets/task_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(), floatingActionButton: _buildFAB());
  }

  Widget _buildBody() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF0F0F23), const Color(0xFF1A1A2E)]
              : [const Color(0xFFF8F9FE), const Color(0xFFE8E9FF)],
        ),
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              const CategorySelector(),
              Expanded(child: _buildTaskList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return HeaderWidget(
          completedCount: taskProvider.completedCount,
          totalTasks: taskProvider.totalTasks,
          progress: taskProvider.progress,
          searchController: _searchController,
          searchQuery: taskProvider.searchQuery,
          onSearchChanged: (value) => taskProvider.setSearchQuery(value),
          onClearSearch: () {
            _searchController.clear();
            taskProvider.clearSearch();
          },
        );
      },
    );
  }

  Widget _buildTaskList() {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        final filteredTasks = taskProvider.filteredTasks;
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        if (filteredTasks.isEmpty) {
          return EmptyState(
            hasSearchQuery: taskProvider.searchQuery.isNotEmpty,
          );
        }

        return ListView.builder(
          padding: EdgeInsets.fromLTRB(
            screenWidth * 0.05,
            0,
            screenWidth * 0.05,
            screenHeight * 0.12,
          ),
          itemCount: filteredTasks.length,
          itemBuilder: (context, index) =>
              _buildTaskListItem(filteredTasks[index], taskProvider),
        );
      },
    );
  }

  Widget _buildTaskListItem(
    MapEntry<int, dynamic> entry,
    TaskProvider taskProvider,
  ) {
    final task = entry.value as Map;
    final taskId = task['id'] as String;
    final taskCopy = _createTaskCopy(task);

    return TaskListItem(
      key: ValueKey(taskId),
      task: task,
      taskId: taskId,
      onToggle: () => taskProvider.toggleComplete(taskId),
      onEdit: () => _showEditTaskDialog(taskId, taskProvider),
      onDelete: () => _handleDeleteTask(taskId, taskCopy, taskProvider),
    );
  }

  Map<String, dynamic> _createTaskCopy(Map task) {
    final taskCopy = <String, dynamic>{};
    task.forEach((key, value) {
      taskCopy[key.toString()] = value;
    });
    return taskCopy;
  }

  void _handleDeleteTask(
    String taskId,
    Map<String, dynamic> taskCopy,
    TaskProvider taskProvider,
  ) {
    taskProvider.deleteTask(taskId);
    _showUndoSnackBar(taskCopy, taskProvider);
  }

  void _showUndoSnackBar(
    Map<String, dynamic> taskCopy,
    TaskProvider taskProvider,
  ) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.delete_outline_rounded,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '${taskCopy['title']}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1A1A2E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: const Color(0xFF6C63FF).withOpacity(0.3),
            width: 1.5,
          ),
        ),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.08,
          left: 16,
          right: 16,
        ),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: const Color(0xFF2DD4BF),
          onPressed: () => taskProvider.restoreTask(taskCopy),
        ),
      ),
    );
  }

  void _showAddTaskDialog() {
    final taskProvider = context.read<TaskProvider>();
    TaskDialog.show(
      context: context,
      title: 'New Task',
      initialCategoryId: taskProvider.selectedCategoryId != 'all'
          ? taskProvider.selectedCategoryId
          : null,
      onSave: (title, description, dueDateTime, categoryId) {
        taskProvider.addTask(title, description, dueDateTime, categoryId);
      },
    );
  }

  void _showEditTaskDialog(String taskId, TaskProvider taskProvider) {
    final currentIndex = taskProvider.findTaskIndexById(taskId);
    if (currentIndex == -1) return;

    final task = taskProvider.getTaskAt(currentIndex);

    TaskDialog.show(
      context: context,
      title: 'Edit Task',
      initialTitle: task['title'] ?? '',
      initialDescription: task['description'] ?? '',
      initialDueDateTime: task['dueDateTime'] != null
          ? DateTime.parse(task['dueDateTime'])
          : null,
      initialCategoryId: task['categoryId'],
      onSave: (title, description, dueDateTime, categoryId) {
        taskProvider.updateTask(
          currentIndex,
          title,
          description,
          dueDateTime,
          categoryId,
        );
      },
    );
  }

  Widget _buildFAB() {
    final screenWidth = MediaQuery.of(context).size.width;
    final fabSize = screenWidth * 0.16;
    final iconSize = screenWidth * 0.08;
    final borderRadius = screenWidth * 0.05;

    return Container(
      width: fabSize,
      height: fabSize,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6C63FF), Color(0xFF2DD4BF)],
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C63FF).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Icon(Icons.add_rounded, size: iconSize, color: Colors.white),
      ),
    );
  }
}
