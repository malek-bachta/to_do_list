import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/core/providers/task_provider.dart';
import 'package:to_do_list/ui/widgets/category_ship.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        return Container(
          height: screenHeight * 0.08,
          margin: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            itemCount: taskProvider.categories.length,
            itemBuilder: (context, index) {
              final category = taskProvider.categories[index];
              final isSelected = taskProvider.selectedCategoryId == category.id;
              final taskCount = taskProvider.getTaskCountForCategory(
                category.id,
              );

              return CategoryChip(
                category: category,
                isSelected: isSelected,
                onTap: () => taskProvider.selectCategory(category.id),
                taskCount: taskCount,
              );
            },
          ),
        );
      },
    );
  }
}
