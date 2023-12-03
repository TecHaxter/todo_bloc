part of '../bloc.dart';

class AllTodoBloc extends Bloc<AllTodoEvent, AllTodoState> {
  final GetAllTodosUsecase getAllTodosUsecaseImpl;
  AllTodoBloc(this.getAllTodosUsecaseImpl) : super(AllTodoStateEmpty(null)) {
    on<OnCreateTodoSuccess>((event, emit) async {
      List<TodoEntity>? todos;
      if (event.todoEntity == null) {
        return;
      }
      if (state is AllTodoStateLoaded) {
        todos = (state as AllTodoStateLoaded).todos;
      }
      todos ??= [];
      todos.add(event.todoEntity!);
      emit(AllTodoStateLoaded(todos));
    });
    on<OnFetchAllTodo>((event, emit) async {
      final res = await getAllTodosUsecaseImpl.call();
      if (res.isSuccess) {
        if (res.data?.isNotEmpty ?? false) {
          emit(AllTodoStateLoaded(res.data!));
        } else {
          emit(AllTodoStateEmpty('Tasks Not found'));
        }
      } else {
        emit(AllTodoStateFailed('Failed to fetch tasks'));
      }
    });
  }
}
