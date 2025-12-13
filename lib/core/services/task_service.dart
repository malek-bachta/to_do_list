import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/ui/utils/color_utils.dart';

class TaskService {
  static const String _boxName = 'tasks';

  Box get _box => Hive.box(_boxName);

  void addTask(
    String title,
    String description,
    DateTime? dueDateTime,
    String? categoryId,
  ) {
    final task = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'title': title,
      'description': description,
      'completed': false,
      'timestamp': DateTime.now().toIso8601String(),
      'color': ColorUtils.getRandomColor(),
      'dueDateTime': dueDateTime?.toIso8601String(),
      'categoryId': categoryId,
    };
    _box.add(task);
  }

  void updateTask(
    int index,
    String title,
    String description,
    DateTime? dueDateTime,
    String? categoryId,
  ) {
    final task = _box.getAt(index) as Map;
    task['title'] = title;
    task['description'] = description;
    task['dueDateTime'] = dueDateTime?.toIso8601String();
    task['categoryId'] = categoryId;
    _box.putAt(index, task);
  }

  void toggleComplete(int index) {
    final task = _box.getAt(index) as Map;
    task['completed'] = !(task['completed'] ?? false);
    _box.putAt(index, task);
  }

  void deleteTask(int index) {
    _box.deleteAt(index);
  }

  int findTaskIndexById(String taskId) {
    for (int i = 0; i < _box.length; i++) {
      final task = _box.getAt(i) as Map;
      if (task['id'] == taskId) {
        return i;
      }
    }
    return -1;
  }

  void restoreTask(Map<dynamic, dynamic> taskData) {
    _box.add(taskData);
  }

  Map getTaskAt(int index) {
    return _box.getAt(index) as Map;
  }

  List<MapEntry<int, dynamic>> getAllTasks({String? categoryId}) {
    final tasks = <MapEntry<int, dynamic>>[];
    for (int i = 0; i < _box.length; i++) {
      final task = _box.getAt(i) as Map;

      if (task['id'] == null) {
        task['id'] = '${i}_${DateTime.now().millisecondsSinceEpoch}';
        _box.putAt(i, task);
      }

      if (categoryId != null && categoryId != 'all') {
        if (task['categoryId'] != categoryId) continue;
      }

      tasks.add(MapEntry(i, task));
    }

    tasks.sort((a, b) {
      final taskA = a.value as Map;
      final taskB = b.value as Map;

      final dueDateA = taskA['dueDateTime'];
      final dueDateB = taskB['dueDateTime'];

      if (dueDateA != null && dueDateB != null) {
        final dateA = DateTime.parse(dueDateA);
        final dateB = DateTime.parse(dueDateB);
        return dateA.compareTo(dateB);
      }

      if (dueDateA != null && dueDateB == null) {
        return -1;
      }

      if (dueDateA == null && dueDateB != null) {
        return 1;
      }

      final timestampA = taskA['timestamp'] ?? '';
      final timestampB = taskB['timestamp'] ?? '';
      return timestampA.compareTo(timestampB);
    });

    return tasks;
  }

  List<MapEntry<int, dynamic>> searchTasks(String query, {String? categoryId}) {
    if (query.isEmpty) return getAllTasks(categoryId: categoryId);

    final tasks = <MapEntry<int, dynamic>>[];
    for (int i = 0; i < _box.length; i++) {
      final task = _box.getAt(i) as Map;

      if (task['id'] == null) {
        task['id'] = '${i}_${DateTime.now().millisecondsSinceEpoch}';
        _box.putAt(i, task);
      }

      if (categoryId != null && categoryId != 'all') {
        if (task['categoryId'] != categoryId) continue;
      }

      final title = (task['title'] ?? '').toString().toLowerCase();
      final desc = (task['description'] ?? '').toString().toLowerCase();

      if (title.contains(query.toLowerCase()) ||
          desc.contains(query.toLowerCase())) {
        tasks.add(MapEntry(i, task));
      }
    }

    tasks.sort((a, b) {
      final taskA = a.value as Map;
      final taskB = b.value as Map;

      final dueDateA = taskA['dueDateTime'];
      final dueDateB = taskB['dueDateTime'];

      if (dueDateA != null && dueDateB != null) {
        final dateA = DateTime.parse(dueDateA);
        final dateB = DateTime.parse(dueDateB);
        return dateA.compareTo(dateB);
      }

      if (dueDateA != null && dueDateB == null) {
        return -1;
      }

      if (dueDateA == null && dueDateB != null) {
        return 1;
      }

      final timestampA = taskA['timestamp'] ?? '';
      final timestampB = taskB['timestamp'] ?? '';
      return timestampA.compareTo(timestampB);
    });

    return tasks;
  }

  int getTotalTasks({String? categoryId}) {
    if (categoryId == null || categoryId == 'all') {
      return _box.length;
    }

    int count = 0;
    for (int i = 0; i < _box.length; i++) {
      final task = _box.getAt(i) as Map;
      if (task['categoryId'] == categoryId) count++;
    }
    return count;
  }

  int getCompletedCount({String? categoryId}) {
    int count = 0;
    for (int i = 0; i < _box.length; i++) {
      final task = _box.getAt(i) as Map;

      if (categoryId != null && categoryId != 'all') {
        if (task['categoryId'] != categoryId) continue;
      }

      if (task['completed'] == true) count++;
    }
    return count;
  }

  int get totalTasks => _box.length;

  int get completedCount =>
      _box.values.where((t) => (t as Map)['completed'] == true).length;
}
