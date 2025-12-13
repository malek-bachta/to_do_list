import 'package:flutter/material.dart';
import 'package:to_do_list/core/models/category_model.dart';
import 'package:to_do_list/core/services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  final TaskService _taskService = TaskService();
  String _searchQuery = '';
  String _selectedCategoryId = 'all';
  List<CategoryModel> _categories = CategoryModel.getDefaultCategories();

  String get searchQuery => _searchQuery;
  String get selectedCategoryId => _selectedCategoryId;
  List<CategoryModel> get categories => _categories;

  CategoryModel get selectedCategory =>
      _categories.firstWhere((cat) => cat.id == _selectedCategoryId);

  int get totalTasks =>
      _taskService.getTotalTasks(categoryId: _selectedCategoryId);
  int get completedCount =>
      _taskService.getCompletedCount(categoryId: _selectedCategoryId);
  double get progress => totalTasks > 0 ? completedCount / totalTasks : 0.0;

  List<MapEntry<int, dynamic>> get filteredTasks =>
      _taskService.searchTasks(_searchQuery, categoryId: _selectedCategoryId);

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  void selectCategory(String categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }

  void addTask(
    String title,
    String description,
    DateTime? dueDateTime,
    String? categoryId,
  ) {
    _taskService.addTask(title, description, dueDateTime, categoryId);
    notifyListeners();
  }

  void updateTask(
    int index,
    String title,
    String description,
    DateTime? dueDateTime,
    String? categoryId,
  ) {
    _taskService.updateTask(index, title, description, dueDateTime, categoryId);
    notifyListeners();
  }

  void toggleComplete(String taskId) {
    final currentIndex = _taskService.findTaskIndexById(taskId);
    if (currentIndex != -1) {
      _taskService.toggleComplete(currentIndex);
      notifyListeners();
    }
  }

  void deleteTask(String taskId) {
    final currentIndex = _taskService.findTaskIndexById(taskId);
    if (currentIndex != -1) {
      _taskService.deleteTask(currentIndex);
      notifyListeners();
    }
  }

  void restoreTask(Map<dynamic, dynamic> taskData) {
    _taskService.restoreTask(taskData);
    notifyListeners();
  }

  Map getTaskAt(int index) {
    return _taskService.getTaskAt(index);
  }

  int findTaskIndexById(String taskId) {
    return _taskService.findTaskIndexById(taskId);
  }

  int getTaskCountForCategory(String categoryId) {
    return _taskService.getTotalTasks(categoryId: categoryId);
  }
}
