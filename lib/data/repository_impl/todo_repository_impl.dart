part of 'repository_impl.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoDataSource todoDataSourceImpl;
  const TodoRepositoryImpl(
    this.todoDataSourceImpl,
  );
  @override
  Future<Responser<List<TodoEntity>?>> getAllTodo() async {
    try {
      final res = await todoDataSourceImpl.getAllTodo();
      if (res.isFailed) {
        throw 'Error occurred while fetching the Todos';
      }
      final data = res.data?.map((e) => e.toEntity(null)).toList();
      return Success(data);
    } catch (e) {
      return Failed(e.toString());
    }
  }

  @override
  Future<Responser<TodoEntity?>> getTodo(int i) {
    // TODO: implement getTodo
    throw UnimplementedError();
  }

  @override
  Future<Responser<TodoEntity?>> setTodo(TodoEntity todo) async {
    try {
      final res = await todoDataSourceImpl.setTodo(todo.toModel(null));
      if (res.isFailed) {
        throw 'Error occurred while setting the Todo';
      }
      final data = res.data?.toEntity(null);
      return Success(data);
    } catch (e) {
      return Failed(e.toString());
    }
  }
}
