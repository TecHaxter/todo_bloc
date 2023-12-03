part of '../bloc.dart';

@freezed
class CreateEditTodoState with _$CreateEditTodoState {
  const factory CreateEditTodoState({
    int? id,
    String? title,
    String? description,
    String? descriptionError,
    DateTime? createdAt,
    DateTime? completedAt,
    DateTime? dueTill,
    //Errors
    String? titleError,
    String? dueTillError,
    String? createTodoError,
    //Success check
    bool? isCreateTodoSuccess,
  }) = _CreateEditTodoState;
}
