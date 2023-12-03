part of '../bloc.dart';

class CreateEditTodoBloc
    extends Bloc<CreateEditTodoEvent, CreateEditTodoState> {
  final SetTodoUsecase setTodoUsecaseImpl;
  final AllTodoBloc allTodoBloc;
  CreateEditTodoBloc(
    this.setTodoUsecaseImpl,
    this.allTodoBloc,
  ) : super(const CreateEditTodoState()) {
    on<OnTitleChanged>((event, emit) {
      print(event.title);
      emit(state.copyWith(title: event.title));
    });
    on<OnDescriptionChanged>((event, emit) {
      print(event.description);
      emit(state.copyWith(description: event.description));
    });
    on<OnDueTillChanged>((event, emit) {
      print(event.date);
      emit(state.copyWith(dueTill: event.date));
    });
    on<OnResetCreateTodo>((event, emit) {
      emit(
        state.copyWith(
          id: null,
          title: null,
          description: null,
          descriptionError: null,
          createdAt: null,
          completedAt: null,
          dueTill: null,
          titleError: null,
          dueTillError: null,
          createTodoError: null,
          isCreateTodoSuccess: null,
        ),
      );
    });
    on<OnCreateTodoError>((event, emit) async {
      await Future.delayed(const Duration(seconds: 2));
      emit(
        state.copyWith(
          id: null,
          title: null,
          description: null,
          descriptionError: null,
          createdAt: null,
          completedAt: null,
          dueTill: null,
          titleError: null,
          dueTillError: null,
          createTodoError: null,
          isCreateTodoSuccess: null,
        ),
      );
    });
    on<OnCreateTodo>((event, emit) async {
      if (state.title?.isEmpty ?? true) {
        emit(state.copyWith(titleError: 'Title is Required'));
        return;
      }
      TodoEntity? todoEntity = TodoEntity(
        id: state.id,
        title: state.title,
        description: state.description,
        dueTill: state.dueTill,
        createdAt: DateTime.now(),
      );
      final res = await setTodoUsecaseImpl.call(todoEntity);
      inspect(res);
      if (res.isFailed) {
        emit(
            state.copyWith(createTodoError: 'Failed to set TODO ${res.error}'));
        return;
      }
      allTodoBloc.add(OnCreateTodoSuccess(res.data));
      emit(state.copyWith(
        isCreateTodoSuccess: true,
      ));
    });
  }
}
