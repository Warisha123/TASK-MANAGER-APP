# Task Manager App
This is a simple Dart-based Task Manager application that allows users to manage tasks, toggle their completion status, save and load tasks from a JSON file, and search for tasks by title.

## Features
- Add, update, and delete tasks.
- List all tasks or filter by completed/incomplete status.
- Toggle task completion status.
- Search tasks by title.
- Save tasks to a JSON file and load them upon starting the app.

## Project Setup Instructions
1. **Install Dart**:
   - If Dart is not installed, download it from [Dart's official website](https://dart.dev/get-dart) and follow the instructions to install it.
2. **Clone the Repository**:
   - Clone this repository from GitHub

3. **Run the Application**:
   - In the terminal, run the application using Dart:
   dart run

## App Architecture
The app is structured around two main classes: `Task` and `TaskManager`.
- **Task Class**: Defines a single task with properties for title, description, and completion status, as well as a custom `toString` method for easy display of task details.
- **TaskManager Class**: Manages a list of tasks, providing methods to add, update, delete, toggle, and search tasks. It also includes functionality to save tasks to a JSON file and load them back when the app starts.

## Output
--- Task Manager ---

1.Add a new task
2.Update a task
3.Delete a task
4.List all tasks
5.List completed tasks
6.List incomplete tasks
7.Toggle completion status of a task
8.Search for a task by title
0.Exit

