part of '../bloc.dart';

abstract class CreateEditTodoEvent {}

class OnTitleChanged extends CreateEditTodoEvent {
  final String? title;
  OnTitleChanged(
    this.title,
  ) : super();
}

class OnDescriptionChanged extends CreateEditTodoEvent {
  final String? description;
  OnDescriptionChanged(
    this.description,
  ) : super();
}

class OnDueTillChanged extends CreateEditTodoEvent {
  final DateTime? date;
  OnDueTillChanged(
    this.date,
  ) : super();
}

class OnCreateTodo extends CreateEditTodoEvent {
  OnCreateTodo() : super();
}

class OnResetCreateTodo extends CreateEditTodoEvent {
  OnResetCreateTodo() : super();
}

class OnCreateTodoError extends CreateEditTodoEvent {
  OnCreateTodoError() : super();
}
