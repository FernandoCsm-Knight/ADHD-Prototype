import 'package:flutter/material.dart';
import 'package:prototype/src/common/models/task.dart';
import 'package:prototype/src/common/types/view_mode.dart';
import 'package:uuid/uuid.dart';

class TaskController with ChangeNotifier {
  final List<Task> _tasks = [];

  DateTime _generateDate(int hour, int min) {
    // TODO: change this logic to firebase
    final DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, min);
  }

  TaskController() {
    // TODO: load tasks from database
    addTask(
      Task(
        uuid: const Uuid().v8(),
        mode: ViewMode.parent,
        title: 'Tarefa 1',
        description: 'Descrição 1',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        isAllDay: false,
      ),
    );

    addTask(
      Task(
        uuid: const Uuid().v8(),
        mode: ViewMode.parent,
        title: 'Tarefa 2',
        description: 'Descrição 2',
        startDate: _generateDate(6, 10),
        isAllDay: false,
      ),
    );

    addTask(
      Task(
        uuid: const Uuid().v8(),
        mode: ViewMode.parent,
        title: 'Tarefa 3',
        description: 'Descrição 3',
        startDate: _generateDate(13, 10),
        isAllDay: false,
      ),
    );

    addTask(
      Task(
        uuid: const Uuid().v8(),
        mode: ViewMode.parent,
        title: 'Tarefa 4',
        description: 'Descrição 4',
        startDate: _generateDate(20, 10),
        isAllDay: false,
      ),
    );

    addTask(
      Task(
        uuid: const Uuid().v8(),
        mode: ViewMode.child,
        title: 'Tarefa da criança 1',
        description: 'Descrição para a tarefa da criança',
        startDate: _generateDate(13, 10),
        isAllDay: false,
      ),
    );

    addTask(
      Task(
        uuid: const Uuid().v8(),
        mode: ViewMode.child,
        title: 'Tarefa da criança 2',
        description: 'Descrição para a tarefa da criança',
        startDate: _generateDate(20, 10),
        isAllDay: false,
      ),
    );
  }

  List<Task> get tasks => _tasks;

  List<Task> get events => tasks.where((task) => task.recurrence == null && !task.isAllDay).toList();
  List<Task> get routines => tasks.where((task) => task.recurrence != null || task.isAllDay).toList();

  List<Task> get completedTasks {
    return tasks.where((task) => task.isCompleted).toList();
  }
    
  List<Task> get pendingTasks {
    return tasks.where((task) => !task.isCompleted).toList();
  }

  List<Task> tasksFor({ViewMode? mode, DateTime? date}) {
    mode = mode ?? ViewMode.parent;
    List<Task> list = _tasks.where((task) => task.mode == mode).toList();

    if (date != null) {
      list = tasksForDate(date: date).where((task) => task.mode == mode).toList();
    }

    return list;
  }

  List<Task> tasksForDate({required DateTime date, List<Task>? list}) {
    date = date;
    list = list ?? _tasks;

    final DateTime start = DateTime(date.year, date.month, date.day);
    final DateTime end = DateTime(date.year, date.month, date.day, 23, 59);

    return list.where((task) {
      final DateTime taskStart = task.startDate;
      final DateTime taskEnd = task.endDate;

      return taskStart.isAtSameMomentAs(start) ||
          taskEnd.isAtSameMomentAs(end) ||
          (taskStart.isAfter(start) && taskStart.isBefore(end)) ||
          (taskEnd.isAfter(start) && taskEnd.isBefore(end));
    }).toList();
  }

  Task? nextTaskFor({required ViewMode mode}) {
    Task? nextTask;
    final List<Task> tasksByMode = tasksFor(mode: mode);

    for (int i = 0; nextTask == null && i < tasksByMode.length; i++) {
      if (!tasksByMode[i].isCompleted) {
        nextTask = tasksByMode[i];
      }
    }

    return nextTask;
  }

  void addTask(Task task) {
    int start = 0;
    int end = _tasks.length - 1;
    int mid = 0;

    while (start <= end) {
      mid = (start + end) ~/ 2;
      if (_tasks[mid].compare(task) < 0) {
        start = mid + 1;
      } else {
        end = mid - 1;
      }
    }

    _tasks.insert(start, task);
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.removeAt(_tasks.indexWhere((element) => element.uuid == task.uuid));
    notifyListeners();
  }

  void updateTask(Task task) {
    final int index = _tasks.indexWhere((element) => element.uuid == task.uuid);
    if (index != -1) {
      _tasks[index].update(
        title: task.title,
        description: task.description,
        startDate: task.startDate,
        endDate: task.endDate,
        isAllDay: task.isAllDay,
        recurrence: task.recurrence,
        dayOfMonth: task.dayOfMonth,
        repeat: task.repeat,
        owner: task.owner,
        icon: task.icon,
        isCompleted: task.isCompleted,
      );

      notifyListeners();
    }
  }

  void toggleTask(Task task) {
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
