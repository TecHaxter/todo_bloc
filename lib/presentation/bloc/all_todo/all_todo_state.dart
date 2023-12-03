part of '../bloc.dart';

abstract class AllTodoState {}

class AllTodoStateEmpty extends AllTodoState {
  final String? message;
  AllTodoStateEmpty(this.message);
}

class AllTodoStateFailed extends AllTodoState {
  final String message;
  AllTodoStateFailed(this.message);
}

class AllTodoStateLoaded extends AllTodoState {
  final List<TodoEntity> todos;
  AllTodoStateLoaded(this.todos);
}
