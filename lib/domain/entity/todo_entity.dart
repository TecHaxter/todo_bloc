part of 'entity.dart';

@freezed
class TodoEntity extends Equatable
    with _$TodoEntity
    implements EntityMapper<TodoModel> {
  const TodoEntity._();
  const factory TodoEntity({
    int? id,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? completedAt,
    DateTime? dueTill,
  }) = _TodoEntity;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        createdAt,
        completedAt,
        dueTill,
      ];

  @override
  TodoModel toModel(obj) {
    return TodoModel(
      id: id,
      title: title,
      description: description,
      createdAt: createdAt,
      completedAt: completedAt,
      dueTill: dueTill,
    );
  }
}
