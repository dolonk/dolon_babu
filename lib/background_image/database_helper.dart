import 'dart:async';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/*class BackgroundImageDatabaseHelper {
  static Future<Database>? _database;

  // Create tables for both images and categories
  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = openDatabase(
      join(await getDatabasesPath(), 'image_database.db'),
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE images(id INTEGER PRIMARY KEY, category TEXT, data BLOB)",
        );
        db.execute(
          "CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT)",
        );
        db.execute(
          "CREATE TABLE image_metadata(id INTEGER PRIMARY KEY, category TEXT, height INTEGER, width INTEGER)",
        );
      },
      version: 1,
    );
    return _database!;
  }



// Insert a category into the categories table
  static Future<void> insertCategory(String categoryName) async {
    final db = await database;
    await db.insert(
      'categories',
      {'name': categoryName},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Categories name data save sql: $categoryName");
  }



  // Insert image into the database along with category name
  static Future<void> insertImage(
      String categoryName, Uint8List imageData) async {
    final db = await database;
    await db.insert(
      'images',
      {'category': categoryName, 'data': imageData},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Uint8List data: $imageData");
  }



  static Future<void> insertImageMetadata(
      String categoryName, int height, int width) async {
    final db = await database;
    await db.insert(
      'image_metadata',
      {'category': categoryName, 'height': height, 'width': width},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Image height and width data: $height  $width");
  }




// Retrieve all categories from the categories table
  static Future<List<Map<String, dynamic>>> retrieveCategories() async {
    final db = await database;
    return db.query('categories');
  }



// Retrieve images from the database for a specific category
  static Future<List<Map<String, dynamic>>> retrieveImages(
      String categoryName) async {
    final db = await database;
    return db.query('images', where: 'category = ?', whereArgs: [categoryName]);
  }

}*/

class BackgroundImageDatabaseHelper {
  static Future<Database>? _database;

  // Create tables for both images and categories
  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = openDatabase(
      join(await getDatabasesPath(), 'image_database.db'),
      onCreate: (db, version) {
         db.execute(
          "CREATE TABLE images(id INTEGER PRIMARY KEY, category TEXT, data BLOB, height INTEGER, width INTEGER)",
        );

        db.execute(
          "CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT)",
        );

      },
      version: 1,
    );
    return _database!;
  }


// Insert a category into the categories table
  static Future<void> insertCategory(String categoryName) async {
    final db = await database;
    await db.insert(
      'categories',
      {'name': categoryName},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Categories name data save sql: $categoryName");
  }



  // Insert image into the database along with category name
  static Future<void> insertImage(
      String categoryName, Uint8List imageData, int height, int width) async {
    final db = await database;
    await db.insert(
      'images',
      {
        'category': categoryName,
        'data': imageData,
        'height': height,
        'width': width,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Uint8List data: $imageData");
  }


  /*static Future<void> insertImageMetadata(
      String categoryName, int height, int width) async {
    final db = await database;
    await db.insert(
      'image_metadata',
      {'category': categoryName, 'height': height, 'width': width},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Image height and width data: $height  $width");
  }*/



// Retrieve all categories from the categories table
  static Future<List<Map<String, dynamic>>> retrieveCategories() async {
    final db = await database;
    return db.query('categories');
  }



// Retrieve images from the database for a specific category
  static Future<List<Map<String, dynamic>>> retrieveImages(
      String categoryName) async {
    final db = await database;
    return db.query(
      'images',
      where: 'category = ?',
      whereArgs: [categoryName],
      columns: ['id', 'category', 'data', 'height', 'width'],
    );
  }


}