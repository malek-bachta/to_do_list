# 📝 To-Do List App

A beautiful, feature-rich Flutter todo application with modern UI/UX design, category management, and local data persistence.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

## ✨ Features

### Core Functionality
- ✅ **Create, Edit, Delete Tasks** - Full CRUD operations for task management
- 🔍 **Search Tasks** - Quickly find tasks by title or description
- ✔️ **Mark Tasks Complete** - Toggle task completion with beautiful animations
- ↩️ **Undo Delete** - Accidentally deleted? Restore tasks instantly
- 💾 **Local Storage** - All data persisted locally using Hive database

### Advanced Features
- 📂 **Category Management** - Organize tasks into 6 predefined categories:
  - 🎯 All Tasks
  - 💼 Work
  - 👤 Personal
  - 🛒 Shopping
  - ❤️ Health
  - 📚 Education
- 📅 **Due Date & Time** - Set deadlines for your tasks
- ⏰ **Smart Due Date Indicators**:
  - Overdue tasks highlighted in red
  - Today's tasks marked in yellow
  - Upcoming tasks in purple
- 📊 **Progress Tracking** - Visual progress bar showing completion percentage
- 🎨 **Color-Coded Tasks** - Each task gets a random color for easy identification

### UI/UX
- 🌓 **Dark/Light Mode** - Automatic theme switching based on system settings
- 🎭 **Beautiful Animations** - Smooth transitions and micro-interactions
- 📱 **Responsive Design** - Adapts to different screen sizes
- 🎨 **Modern Gradient UI** - Eye-catching gradient backgrounds and buttons
- 💫 **Glassmorphism Effects** - Modern frosted glass design elements


## 🏗️ Architecture

This app follows clean architecture principles and uses the Provider pattern for state management:

lib/
├── core/
│   ├── models/
│   │   ├── category_model.dart
│   │   └── task_model.dart
│   ├── providers/
│   │   └── task_provider.dart
│   └── services/
│       └── task_service.dart
├── ui/
│   ├── screens/
│   │   └── home_page.dart
│   ├── theme/
│   │   └── app_theme.dart
│   ├── utils/
│   │   └── color_utils.dart
│   └── widgets/
│       ├── home_page/
│       │   ├── category_chip.dart
│       │   ├── category_selector.dart
│       │   ├── header_widget.dart
│       │   ├── task_item.dart
│       │   └── task_item/
│       │       ├── task_checkbox.dart
│       │       └── task_content.dart
│       ├── custom_text_field.dart
│       ├── empty_state.dart
│       └── task_dialog.dart
└── main.dart

### Key Components

- **Models**: Data structures for tasks and categories
- **Providers**: State management using Provider pattern
- **Services**: Business logic and data operations
- **Widgets**: Reusable UI components
- **Theme**: Centralized theme configuration

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.9.0 or higher)
- Dart SDK (3.9 or higher)
- Android Studio / VS Code
- Android Emulator / iOS Simulator / Physical Device

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/todo-list-app.git
   cd todo-list-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  hive_flutter:
  intl:
  provider:

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints:
```

## 🎯 How to Use

### Creating a Task
1. Tap the **+ button** at the bottom right
2. Enter task title and description (optional)
3. Select a category
4. Set due date and time (optional)
5. Tap **Save Task**

### Filtering by Category
- Tap any category chip at the top to filter tasks
- The task count for each category is displayed on the chip
- Select **All** to view all tasks

### Searching Tasks
- Use the search bar in the header
- Search works across task titles and descriptions
- Combine with category filters for precise results

### Managing Tasks
- **Complete**: Tap anywhere on the task card to toggle completion
- **Edit**: Tap the edit icon on the right side of the task
- **Delete**: Swipe left on any task to delete
- **Undo Delete**: Tap UNDO in the snackbar that appears after deletion

### Due Dates
- **Red badge**: Task is overdue
- **Yellow badge**: Task is due today
- **Purple badge**: Task is due in the future


## 🔧 State Management

This app uses **Provider** for state management:

- **TaskProvider**: Manages all task-related state and operations
- **ChangeNotifier**: Notifies UI of state changes
- **Consumer**: Rebuilds widgets when state changes
- **context.read()**: One-time access to provider methods

## 💾 Data Persistence

- Uses **Hive** for local storage
- All tasks stored locally on device
- No internet connection required
- Fast and efficient key-value database
- Data persists between app sessions


## 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux
