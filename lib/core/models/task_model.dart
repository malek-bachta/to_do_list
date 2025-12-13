import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  factory CategoryModel.fromMap(Map map) {
    return CategoryModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      icon: IconData(map['iconCode'] ?? Icons.folder.codePoint, fontFamily: 'MaterialIcons'),
      color: map['color'] ?? const Color(0xFF6C63FF),
    );
  }

  Map toMap() {
    return {
      'id': id,
      'name': name,
      'iconCode': icon.codePoint,
      'color': color,
    };
  }

  static List<CategoryModel> getDefaultCategories() {
    return [
      CategoryModel(
        id: 'all',
        name: 'All',
        icon: Icons.apps_rounded,
        color: const Color(0xFF6C63FF),
      ),
      CategoryModel(
        id: 'work',
        name: 'Work',
        icon: Icons.work_rounded,
        color: const Color(0xFF3B82F6),
      ),
      CategoryModel(
        id: 'personal',
        name: 'Personal',
        icon: Icons.person_rounded,
        color: const Color(0xFF10B981),
      ),
      CategoryModel(
        id: 'shopping',
        name: 'Shopping',
        icon: Icons.shopping_cart_rounded,
        color: const Color(0xFFF59E0B),
      ),
      CategoryModel(
        id: 'health',
        name: 'Health',
        icon: Icons.favorite_rounded,
        color: const Color(0xFFEF4444),
      ),
      CategoryModel(
        id: 'education',
        name: 'Education',
        icon: Icons.school_rounded,
        color: const Color(0xFF8B5CF6),
      ),
    ];
  }
}