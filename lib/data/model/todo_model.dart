part of 'model.dart';

@freezed
class TodoModel extends Equatable
    with _$TodoModel
    implements ModelMapper<TodoEntity> {
  const TodoModel._();
  const factory TodoModel({
    int? id,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? completedAt,
    DateTime? dueTill,
  }) = _TodoModel;

  factory TodoModel.fromJson(Map<String, Object?> json) =>
      _$TodoModelFromJson(json);

  @override
  TodoEntity toEntity(dynamic obj) {
    return TodoEntity(
      id: id,
      title: title,
      description: description,
      createdAt: createdAt,
      completedAt: completedAt,
      dueTill: dueTill,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        createdAt,
        completedAt,
        dueTill,
      ];
}
