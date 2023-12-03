part of 'data_source.dart';

abstract class TodoDataSource {
  Future<Responser<TodoModel?>> getTodo(int i);

  Future<Responser<List<TodoModel>?>> getAllTodo();

  Future<Responser<TodoModel?>> setTodo(TodoModel todo);
}

class TodoDataSourceImpl implements TodoDataSource {
  final SqfliteService sqfliteServiceImpl;
  const TodoDataSourceImpl(this.sqfliteServiceImpl);

  @override
  Future<Responser<List<TodoModel>?>> getAllTodo() async {
    try {
      final res = await sqfliteServiceImpl.getAll();
      final data = res.map((e) => TodoModel.fromJson(e)).toList();
      return Success(data);
    } catch (e) {
      return Failed('Error occurred in TodoDataSource due to ${e.toString()}');
    }
  }

  @override
  Future<Responser<TodoModel?>> getTodo(int i) {
    // TODO: implement getTodo
    throw UnimplementedError();
  }

  @override
  Future<Responser<TodoModel?>> setTodo(TodoModel todo) async {
    try {
      final res = await sqfliteServiceImpl.insert(todo.toJson());
      final data = todo.copyWith(id: res);
      return Success(data);
    } catch (e) {
      return Failed(
          'Error occurred in TodoDataSource setTodo due to ${e.toString()}');
    }
  }
}
