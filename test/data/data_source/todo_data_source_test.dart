import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_bloc/core/helpers/helpers.dart';
import 'package:todo_bloc/data/data_source/data_source.dart';
import 'package:todo_bloc/data/model/model.dart';

import '../../mock/mocker.mocks.dart';

void main() {
  late MockSqfliteService mockSqfliteService;
  late TodoDataSource todoDataSourceImpl;

  setUp(() {
    mockSqfliteService = MockSqfliteService();
    todoDataSourceImpl = TodoDataSourceImpl(mockSqfliteService);
  });

  getAllWhenResponse(DateTime time) => [
        {
          'id': 1,
          'title': 'Lorem',
          'description': 'Lorem Ipsum Lorem Ipsume',
          'createdAt': time.toIso8601String(),
          'completedAt': null,
          'dueTill': (time..add(const Duration(days: 10))).toIso8601String(),
        },
        {
          'id': 2,
          'title': 'Lorem',
          'description': 'Lorem Ipsum Lorem Ipsume',
          'createdAt': time.toIso8601String(),
          'completedAt': null,
          'dueTill': (time..add(const Duration(days: 10))).toIso8601String(),
        },
      ];

  getAllResponse(DateTime time) => [
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

  group('Get All Todo Models', () {
    test('should return a list of todo model when Success ', () async {
      //arrange
      DateTime time = DateTime.now();
      when(
        mockSqfliteService.getAll(),
      ).thenAnswer(
        (realInvocation) async => getAllWhenResponse(time),
      );
      //act
      final res = await todoDataSourceImpl.getAllTodo();
      final result = res.data;
      //assert
      expect(result, getAllResponse(time));
    });

    test('should return a Failed when some error occures', () async {
      //arrange
      when(
        mockSqfliteService.getAll(),
      ).thenThrow(
        'Unknown Error',
      );
      //act
      final res = await todoDataSourceImpl.getAllTodo();
      //assert
      expect(res, isA<Failed>());
      expect(() => res.data, throwsUnimplementedError);
    });
  });
}
