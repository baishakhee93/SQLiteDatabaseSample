// tasks_database.dart
import 'package:room_database_sample/task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TasksDatabase {
  static final TasksDatabase instance = TasksDatabase._();
  static Database? _database;

  TasksDatabase._();

  factory TasksDatabase() {
    return instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'tasks_database.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT, completed INTEGER)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Add the 'description' column
          await db.execute('ALTER TABLE tasks ADD COLUMN description TEXT');
        }
        // Add additional migration steps for other versions if needed
      },

    );

  }

  Future<List<Task>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length, (index) {
      return Task(
        id: maps[index]['id'],
        title: maps[index]['title'],
        description: maps[index]['description'],
        completed: maps[index]['completed'] == 1,
      );
    });
  }

  Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert('tasks', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateTask(Task task) async {
    final db = await database;
    await db.update('tasks', task.toMap(),
        where: 'id = ?', whereArgs: [task.id]);
  }

  Future<void> deleteTask(int taskId) async {
    final db = await database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [taskId]);
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
