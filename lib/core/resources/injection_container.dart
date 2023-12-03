import 'package:get_it/get_it.dart';
import 'package:todo_bloc/core/services/services.dart';
import 'package:todo_bloc/data/data_source/data_source.dart';
import 'package:todo_bloc/data/repository_impl/repository_impl.dart';
import 'package:todo_bloc/domain/repository/repository.dart';
import 'package:todo_bloc/domain/usecase/usecase.dart';
import 'package:todo_bloc/presentation/bloc/bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(
    () => AllTodoBloc(
      locator<GetAllTodosUsecase>(),
    ),
  );

  locator.registerFactory(
    () => CreateEditTodoBloc(
      locator<SetTodoUsecase>(),
      locator<AllTodoBloc>(),
    ),
  );

  locator.registerLazySingleton<SqfliteService>(
    () => SqfliteServiceImpl(),
  );

  locator.registerLazySingleton<TodoDataSource>(
    () => TodoDataSourceImpl(locator<SqfliteService>()),
  );

  locator.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(locator<TodoDataSource>()),
  );

  locator.registerLazySingleton<GetAllTodosUsecase>(
    () => GetAllTodosUsecaseImpl(
      locator<TodoRepository>(),
    ),
  );

  locator.registerLazySingleton<SetTodoUsecase>(
    () => SetTodoUsecaseImpl(
      locator<TodoRepository>(),
    ),
  );
}
