import 'package:mockito/annotations.dart';
import 'package:todo_bloc/core/services/services.dart';
import 'package:todo_bloc/data/data_source/data_source.dart';
import 'package:todo_bloc/domain/repository/repository.dart';

@GenerateMocks([
  HiveService,
  SqfliteService,
  TodoDataSource,
  TodoRepository,
])
void main() {}
