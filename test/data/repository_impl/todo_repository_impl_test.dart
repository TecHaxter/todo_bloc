import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_bloc/core/helpers/helpers.dart';
import 'package:todo_bloc/data/model/model.dart';
import 'package:todo_bloc/data/repository_impl/repository_impl.dart';
import 'package:todo_bloc/domain/entity/entity.dart';
import 'package:todo_bloc/domain/repository/repository.dart';

import '../../mock/mocker.mocks.dart';

void main() {
  late MockTodoDataSource mockTodoDataSourceImpl;
  late TodoRepository todoRepositoryImpl;

  setUp(() {
    mockTodoDataSourceImpl = MockTodoDataSource();
    todoRepositoryImpl = TodoRepositoryImpl(mockTodoDataSourceImpl);
  });

  List<TodoModel> getAllWhenResponse(DateTime time) => [
        TodoModel(
          id: 1,
          title: 'Lorem',
          description: 'Lorem Ipsum Lorem Ipsume',
          createdAt: time,
          completedAt: null,
          dueTill: (time..add(const Duration(days: 10))),
        ),
        TodoModel(
          id: 2,
          title: 'Lorem',
          description: 'Lorem Ipsum Lorem Ipsume',
          createdAt: time,
          completedAt: null,
          dueTill: (time..add(const Duration(days: 10))),
        ),
      ];

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

  group('Get All Todo Entity', () {
    test('should return a list of todo entity when success', () async {
      //arrange
      DateTime time = DateTime.now();

      when(
        mockTodoDataSourceImpl.getAllTodo(),
      ).thenAnswer(
        (realInvocation) async => Success(getAllWhenResponse(time)),
      );
      //act
      final res = await todoRepositoryImpl.getAllTodo();
      final result = res.data;
      //assert
      expect(result, getAllResponse(time));
    });
    test('should return a Failed entity when Failed', () async {
      //arrange
      when(
        mockTodoDataSourceImpl.getAllTodo(),
      ).thenAnswer(
        (realInvocation) async => Failed('Some error'),
      );
      //act
      final res = await todoRepositoryImpl.getAllTodo();
      //assert
      expect(res, isA<Failed>());
      expect(() => res.data, throwsUnimplementedError);
    });
  });
}
