part of 'view.dart';

class AllTodoView extends StatelessWidget {
  const AllTodoView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AllTodoBloc>().add(OnFetchAllTodo());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('All Todo'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      body: BlocBuilder<AllTodoBloc, AllTodoState>(builder: (context, state) {
        if (state is AllTodoStateFailed) {
          return const Center(child: Text('Failed to fetch Todo'));
        } else if (state is AllTodoStateLoaded) {
          return ListView.separated(
            itemBuilder: (context, index) => InkWell(
              onTap: () {},
              child: Tooltip(
                message: state.todos[index].description ?? '',
                child: ListTile(
                  title: Text(state.todos[index].title ?? ''),
                  subtitle: Text(state.todos[index].description ?? ''),
                  trailing: Checkbox(
                    value: true,
                    onChanged: (s) {},
                  ),
                ),
              ),
            ),
            separatorBuilder: (_, __) => const SizedBox(
              height: 12,
            ),
            itemCount: state.todos.length,
          );
        }
        return const Center(child: Text('Empty Todo'));
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const CreateEditTodoView(),
            ),
          ).then((value) {
            context.read<CreateEditTodoBloc>().add(OnResetCreateTodo());
            context.read<AllTodoBloc>().add(OnFetchAllTodo());
          });
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
