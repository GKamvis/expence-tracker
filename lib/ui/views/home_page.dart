import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myapp/data/dao/expence_dao.dart';
import '../cubit/home_page_cubit.dart';
import '../cubit/search icon cubit/search_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomePageCubit()..getExpence()),
        BlocProvider(create: (context) => SearchCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<SearchCubit, bool>(
            builder: (context, showSearch) {
              return showSearch
                  ? TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                      ),
                      onChanged: (newQuery) {
                        if (newQuery.isEmpty) {
                          context.read<HomePageCubit>().getExpence();
                        }
                        context.read<HomePageCubit>().findExpence(newQuery);
                      },
                    )
                  : const Text('Home Page');
            },
          ),
          actions: [
            BlocBuilder<SearchCubit, bool>(
              builder: (context, showSearch) {
                return IconButton(
                  onPressed: () {
                    context.read<SearchCubit>().toggleSearch();
                    if (!showSearch) {
                      context.read<HomePageCubit>().getExpence();
                    }
                  },
                  icon: Icon(showSearch ? Icons.cancel : Icons.search),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<HomePageCubit, List<ExpenceDao>>(
            builder: (context, expences) {
              if (expences.isNotEmpty) {
                return ListView.builder(
                  itemCount: expences.length,
                  itemBuilder: (context, index) {
                    var expence = expences[index];
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              context
                                  .read<HomePageCubit>()
                                  .deleteExpence(expence.Id);
                            },
                            icon: Icons.delete,
                            label: "Delete",
                            backgroundColor: Colors.red,
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/update',
                              arguments: expence);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color.fromARGB(255, 219, 203, 203),
                            ),
                          ),
                          child: ListTile(
                            title: Text(expence.Name),
                            subtitle: Text(expence.Expences.toString()),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text('No expenses found.'));
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add').then((_) {
              context.read<HomePageCubit>().getExpence();
            });
          },
          child: const Icon(Icons.add),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 136, 196, 220),
                ),
                child: Text("Settings"),
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text("Dark Mode"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
