import 'package:flutter_test/flutter_test.dart';
import 'package:todo_bloc/data/model/model.dart';
import 'package:todo_bloc/domain/entity/entity.dart';

void main() {
  Map<String, dynamic> json(DateTime time) => {
        'id': 1,
        'title': 'Lorem',
        'description': 'Lorem Ipsum Lorem Ipsume',
        'createdAt': time.toIso8601String(),
        'completedAt': null,
        'dueTill': (time..add(const Duration(days: 10))).toIso8601String(),
      };

  TodoModel todoModel(DateTime time) => TodoModel(
        id: 1,
        title: 'Lorem',
        description: 'Lorem Ipsum Lorem Ipsume',
        createdAt: time,
        completedAt: null,
        dueTill: time..add(const Duration(days: 10)),
      );

  TodoEntity todoEntity(DateTime time) => TodoEntity(
        id: 1,
        title: 'Lorem',
        description: 'Lorem Ipsum Lorem Ipsume',
        createdAt: time,
        completedAt: null,
        dueTill: time..add(const Duration(days: 10)),
      );

  group('Todo Model Testing', () {
    test('should return a Todo Model using a json', () {
      //arrange
      DateTime time = DateTime.now();
      //act
      final result = TodoModel.fromJson(json(time));
      //assert
      expect(
        result,
        todoModel(time),
      );
    });

    test('should return a json using a Todo Model', () {
      //arrange
      DateTime time = DateTime.now();
      //act
      final result = todoModel(time).toJson();
      //assert
      expect(
        result,
        json(time),
      );
    });

    test('should return a TodoEntity using a Todo Model', () {
      //arrange
      DateTime time = DateTime.now();
      //act
      final result = todoModel(time).toEntity(null);
      final expected = todoEntity(time);
      //assert
      expect(
        result,
        expected,
      );
    });
  });
}
