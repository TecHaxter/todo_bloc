part of 'services.dart';

abstract class HiveService {
  Future<void> openBox();

  Future<void> put(Map<String, dynamic> data);

  Future<Map<String, dynamic>> get(String key);

  Future<List<Map<String, dynamic>>> getAll(List<String> keys);

  Future<void> clear();

  Future<void> delete(String key);
  Future<void> deleteAll(List<String> keys);
}

class HiveServiceImpl implements HiveService {
  late CollectionBox box;

  @override
  Future<void> openBox() async {
    final boxCollection = await BoxCollection.open(
      'todo_bloc_db', // Name of your database
      {'todo_bloc'}, // Names of your boxes
      path:
          './', // Path where to store your boxes (Only used in Flutter / Dart IO)
    );
    box = await boxCollection.openBox<Map>('todo_bloc');
  }

  @override
  Future<void> put(Map<String, dynamic> data) async {
    await box.put(box.name, data);
  }

  @override
  Future<Map<String, dynamic>> get(String key) async {
    return await box.get(key);
  }

  @override
  Future<List<Map<String, dynamic>>> getAll(List<String> keys) async {
    final res = await box.getAll(keys);
    final data = res.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    return data;
  }

  @override
  Future<void> clear() async {
    return await box.clear();
  }

  @override
  Future<void> delete(String key) async {
    return await box.delete(key);
  }

  @override
  Future<void> deleteAll(List<String> keys) async {
    return await box.deleteAll(keys);
  }
}
