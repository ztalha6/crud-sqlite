import 'package:flutter_sqlite/app/data/model/item_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ItemDatabase {
  static final ItemDatabase instance = ItemDatabase._init();

  static Database? _database;

  ItemDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('items_database.db');
    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT
      )
      ''');
  }

  Future<List<Item>> getItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('items');

    return List.generate(maps.length, (index) {
      return Item.fromJson(maps[index]);
    });
  }

  Future<void> insertItem(Item item) async {
    final db = await database;
    final id = await db.insert(
      'items',
      item.toJsonWithoutId(),
    );
    item.id = id;
  }

  Future<void> updateItem(Item item) async {
    final db = await database;
    await db
        .update('items', item.toJson(), where: 'id = ?', whereArgs: [item.id]);
  }

  Future<void> deleteItem(int id) async {
    final db = await database;
    await db.delete('items', where: 'id = ?', whereArgs: [id]);
  }
}
