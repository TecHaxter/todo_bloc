part of 'services.dart';

abstract class SqfliteService {
  Future<Database> get database;

  Future<int> insert(
    Map<String, dynamic> data, {
    String tableName,
  });

  Future<List<Map<String, dynamic>>> getAll({
    String tableName,
  });

  Future<List<Map<String, dynamic>>> getAllByFilter({
    required String where,
    required List equalsTo,
    String tableName,
  });

  Future<Map<String, dynamic>?> getById(
    int id, {
    String tableName,
  });

  Future<int> updateById(
    int id,
    Map<String, dynamic> data, {
    String tableName,
  });

  Future<int> delete(
    int id, {
    String tableName,
  });
}

class SqfliteServiceImpl implements SqfliteService {
  static Database? _database;
  static const String todoTableName = 'todo_table';

  @override
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'todo_bloc_database.db');
    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "$todoTableName" (
        "id"	INTEGER NOT NULL UNIQUE,
        "title"	TEXT,
        "description"	TEXT,
        "createdAt"	REAL,
        "completedAt"	REAL,
        "dueTill"	REAL,
        PRIMARY KEY("id" AUTOINCREMENT)
      );
    ''');
  }

  @override
  Future<int> insert(
    Map<String, dynamic> data, {
    String tableName = todoTableName,
  }) async {
    Database db = await database;
    return await db.insert(tableName, data);
  }

  @override
  Future<List<Map<String, dynamic>>> getAll({
    String tableName = todoTableName,
  }) async {
    Database db = await database;
    return await db.query(tableName);
  }

  @override
  Future<List<Map<String, dynamic>>> getAllByFilter({
    required String where,
    required List equalsTo,
    String tableName = todoTableName,
  }) async {
    Database db = await database;
    return await db.query(
      tableName,
      where: where,
      whereArgs: equalsTo,
    );
  }

  @override
  Future<Map<String, dynamic>?> getById(
    int id, {
    String tableName = todoTableName,
  }) async {
    Database db = await database;
    List<Map<String, dynamic>> result =
        await db.query(tableName, where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  @override
  Future<int> updateById(
    int id,
    Map<String, dynamic> data, {
    String tableName = todoTableName,
  }) async {
    Database db = await database;
    return await db.update(tableName, data, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<int> delete(
    int id, {
    String tableName = todoTableName,
  }) async {
    Database db = await database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
