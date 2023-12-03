part of '../usecase.dart';

abstract class GetAllTodosUsecase {
  Future<Responser<List<TodoEntity>?>> call();
}

class GetAllTodosUsecaseImpl implements GetAllTodosUsecase {
  final TodoRepository todoRepositoryImpl;
  const GetAllTodosUsecaseImpl(this.todoRepositoryImpl);

  @override
  Future<Responser<List<TodoEntity>?>> call() {
    return todoRepositoryImpl.getAllTodo();
  }
}
