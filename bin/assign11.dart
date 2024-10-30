import 'dart:io';
import 'dart:convert';

class Task {
  String title;
  String description;
  bool iscompleted;

  Task(this.title, this.description, this.iscompleted);

  String represent_String() {
    return '{"title": "$title", "description": "$description", "isCompleted": $iscompleted}';
  }

  @override
  String toString() {
    return '$title: $description [${iscompleted ? "Completed" : "Incomplete"}]';
  }
}

class TaskManager {
  List<Task> tasks = [];

  void addTask(Task task) {
    tasks.add(task);
  }

  void updateTask(int index, Task task) {
    if (index >= 0 && index < tasks.length) {
      tasks[index] = task;
    } else {
      print('Invalid index. Task not updated.');
    }
  }

  void deleteTask(int index) {
    if (index >= 0 && index < tasks.length) {
      tasks.removeAt(index);
    } else {
      print('Invalid index. Task not deleted.');
    }
  }

  List<Task> getTasks() {
    return tasks;
  }

  List<Task> getCompletedTasks() {
    List<Task> compl_task = [];
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].iscompleted == true) {
        compl_task.add(tasks[i]);
      }
    }
    return compl_task;
  }

  List<Task> getIncompleteTasks() {
    List<Task> incompl_task = [];
    for (int i = 0; i < tasks.length; i++) {
      if (!tasks[i].iscompleted) {
        incompl_task.add(tasks[i]);
      }
    }
    return incompl_task;
  }

  void toggleTaskCompletion(int index) {
    if (index >= 0 && index < tasks.length) {
      tasks[index].iscompleted = !tasks[index].iscompleted;
    } else {
      print('Invalid index. Completion status not toggled.');
    }
  }

  void saveTasksToFile(String filePath) {
    final jsonTasks = tasks.map((task) => task.represent_String()).toList();
    File(filePath).writeAsStringSync(json.encode(jsonTasks));
  }

  void loadTasksFromFile(String filePath) {
    if (File(filePath).existsSync()) {
      final jsonString = File(filePath).readAsStringSync();
      final List<dynamic> jsonTasks = json.decode(jsonString);
      tasks = jsonTasks.map((jsonTask) {
        return Task(jsonTask['title'], jsonTask['description'],
            jsonTask['isCompleted']);
      }).toList();
    }
  }

  Task? findTask(String title) {
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].title == title) {
        return tasks[i];
      }
    }
    return null;
  }
}

void main() {
  String filePath = 'tasks.json';
  TaskManager taskManager = TaskManager();
  taskManager.loadTasksFromFile(filePath);

  while (true) {
    print("\n--- Task Manager ---");
    print("1. Add a new task");
    print("2. Update a task");
    print("3. Delete a task");
    print("4. List all tasks");
    print("5. List completed tasks");
    print("6. List incomplete tasks");
    print("7. Toggle completion status of a task");
    print("8. Search for a task by title");
    print("0. Exit");

    int choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        print("Enter task title:");
        String title = stdin.readLineSync()!;
        print("Enter task description:");
        String description = stdin.readLineSync()!;
        print("Is the task completed? (true/false):");
        bool is_completed = stdin.readLineSync()!.toLowerCase() == 'true';
        Task newTask = Task(title, description, is_completed);
        taskManager.addTask(newTask);
        break;

      case 2:
        print("Enter the index of the task to update:");
        int index = int.parse(stdin.readLineSync()!);
        print("Enter new task title:");
        String newTitle = stdin.readLineSync()!;
        print("Enter new task description:");
        String newDescription = stdin.readLineSync()!;
        print("Is the task completed? (true/false):");
        bool is_completed = stdin.readLineSync()!.toLowerCase() == 'true';
        taskManager.updateTask(
            index, Task(newTitle, newDescription, is_completed));
        break;

      case 3:
        print("Enter the index of the task to delete:");
        int indexToDelete = int.parse(stdin.readLineSync()!);
        taskManager.deleteTask(indexToDelete);
        break;

      case 4:
        print("All tasks:");
        taskManager.getTasks().forEach(print);
        break;

      case 5:
        print("Completed tasks:");
        taskManager.getCompletedTasks().forEach(print);
        break;

      case 6:
        print("Incomplete tasks:");
        taskManager.getIncompleteTasks().forEach(print);
        break;

      case 7:
        print("Enter the index of the task to toggle:");
        int indexToToggle = int.parse(stdin.readLineSync()!);
        taskManager.toggleTaskCompletion(indexToToggle);
        break;

      case 8:
        print("Enter the title of the task to search:");
        String titleToSearch = stdin.readLineSync()!;
        Task? foundTask = taskManager.findTask(titleToSearch);
        if (foundTask != null) {
          print("Found task: $foundTask");
        } else {
          print("Task not found.");
        }
        break;

      case 0:
        taskManager.saveTasksToFile(filePath);
        print("Exiting the application. Tasks saved to $filePath.");
        return;

      default:
        print("Invalid choice. Please try again.");
    }
  }
}
