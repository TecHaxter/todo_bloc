part of 'repository.dart';

abstract class TodoRepository {
  Future<Responser<TodoEntity?>> getTodo(int i);

  Future<Responser<List<TodoEntity>?>> getAllTodo();

  Future<Responser<TodoEntity?>> setTodo(TodoEntity todo);
}
