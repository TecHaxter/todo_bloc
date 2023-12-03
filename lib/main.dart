import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/core/resources/injection_container.dart';
import 'package:todo_bloc/presentation/bloc/bloc.dart';
import 'package:todo_bloc/presentation/view/view.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CreateEditTodoBloc>(
          create: (_) => locator<CreateEditTodoBloc>(),
        ),
        BlocProvider<AllTodoBloc>(
          create: (_) => locator<AllTodoBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Todo Bloc',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AllTodoView(),
      ),
    );
  }
}
