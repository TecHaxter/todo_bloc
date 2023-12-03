import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_bloc/core/helpers/helpers.dart';
import 'package:todo_bloc/domain/entity/entity.dart';
import 'package:todo_bloc/domain/usecase/usecase.dart';

import '../../../mock/mocker.mocks.dart';

void main() {
  late MockTodoRepository mockTodoRepositoryImpl;
  late GetAllTodosUsecase getAllTodosUsecaseImpl;

  setUp(() {
    mockTodoRepositoryImpl = MockTodoRepository();
    getAllTodosUsecaseImpl = GetAllTodosUsecaseImpl(mockTodoRepositoryImpl);
  });

  List<TodoEntity> getAllResponse(DateTime time) => [
        TodoEntity(
          id: 1,
          title: 'Lorem',
          description: 'Lorem Ipsum Lorem Ipsume',
          createdAt: time,
          completedAt: null,
          dueTill: (time..add(const Duration(days: 10))),
        ),
        TodoEntity(
          id: 2,
          title: 'Lorem',
          description: 'Lorem Ipsum Lorem Ipsume',
          createdAt: time,
          completedAt: null,
          dueTill: (time..add(const Duration(days: 10))),
        ),
      ];

  group('Get All Todos Usecase Tests', () {
    DateTime time = DateTime.now();
    test('should return success of List<TodoEntity>? when Success', () async {
      when(mockTodoRepositoryImpl.getAllTodo())
          .thenAnswer((realInvocation) async => Success(getAllResponse(time)));
      //Act
      final res = await getAllTodosUsecaseImpl.call();
      //Assert
      expect(res, isA<Success>());
      expect(res.data, getAllResponse(time));
    });
    test('should return Failed  when Failed', () async {
      when(mockTodoRepositoryImpl.getAllTodo())
          .thenAnswer((realInvocation) async => Failed('Some Error'));
      //Act
      final res = await getAllTodosUsecaseImpl.call();
      //Assert
      expect(res, isA<Failed>());
      expect(() => res.data, throwsUnimplementedError);
    });
  });
}
