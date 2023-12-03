part of 'view.dart';

class CreateEditTodoView extends StatelessWidget {
  const CreateEditTodoView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController? dueDateController = TextEditingController();
    return BlocListener<CreateEditTodoBloc, CreateEditTodoState>(
      listener: (context, state) {
        if (state.createTodoError?.isNotEmpty ?? false) {
          final snackBar = SnackBar(
            content: Text(state.createTodoError!),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          context.read<CreateEditTodoBloc>().add(OnCreateTodoError());
        }
        if (state.isCreateTodoSuccess ?? false) {
          const snackBar = SnackBar(
            content: Text('Todo Added Successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Create Todo'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BlocBuilder<CreateEditTodoBloc, CreateEditTodoState>(
              builder: (context, state) {
            dueDateController.text = state.dueTill?.toIso8601String() ?? '';
            return Form(
              child: Column(
                children: [
                  TextFormField(
                    initialValue: state.title,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) => state.titleError,
                    onChanged: (value) {
                      context
                          .read<CreateEditTodoBloc>()
                          .add(OnTitleChanged(value));
                    },
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                  TextFormField(
                    initialValue: state.description,
                    onChanged: (value) {
                      context
                          .read<CreateEditTodoBloc>()
                          .add(OnDescriptionChanged(value));
                    },
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                  ),
                  TextFormField(
                    controller: dueDateController,
                    readOnly: true,
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(
                          const Duration(days: 6 * 365),
                        ),
                        lastDate: DateTime.now().add(
                          const Duration(days: 6 * 365),
                        ),
                      ).then((date) {
                        context
                            .read<CreateEditTodoBloc>()
                            .add(OnDueTillChanged(date));
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Due Till',
                      suffixIcon: Icon(
                        Icons.calendar_month,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () {
                      context.read<CreateEditTodoBloc>().add(
                            OnCreateTodo(),
                          );
                    },
                    child: const Text('Create'),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
