import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'model_class.dart';


class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  static Future<Database> initDB() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'app_database.db');

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE icons (
          id INTEGER PRIMARY KEY,
          icon TEXT,
          email TEXT,
          categoryName TEXT
        )
      ''');
    });
  }

  static Future<void> insertIcon(IconModel icon) async {
    final db = await database;
    await db.insert('icons', icon.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<IconModel>> getIcons() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('icons');
    return List.generate(maps.length, (i) {
      return IconModel(
        id: maps[i]['id'],
        icon: maps[i]['icon'],
        email: maps[i]['email'],
        categoryName: maps[i]['categoryName'],
      );
    });
  }
}
