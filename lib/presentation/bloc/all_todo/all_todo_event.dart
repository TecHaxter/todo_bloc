part of '../bloc.dart';

abstract class AllTodoEvent {}

class OnFetchAllTodo extends AllTodoEvent {}

class OnCreateTodoSuccess extends AllTodoEvent {
  final TodoEntity? todoEntity;
  OnCreateTodoSuccess(this.todoEntity);
}
