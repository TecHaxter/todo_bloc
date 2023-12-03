part of '../usecase.dart';

abstract class SetTodoUsecase {
  Future<Responser<TodoEntity?>> call(TodoEntity? todoEntity);
}

class SetTodoUsecaseImpl implements SetTodoUsecase {
  final TodoRepository todoRepositoryImpl;
  const SetTodoUsecaseImpl(this.todoRepositoryImpl);

  @override
  Future<Responser<TodoEntity?>> call(TodoEntity? todoEntity) async {
    try {
      if (todoEntity == null) {
        throw 'Empty todo can not be created';
      }
      return await todoRepositoryImpl.setTodo(todoEntity);
    } catch (e) {
      return Failed(e.toString());
    }
  }
}
