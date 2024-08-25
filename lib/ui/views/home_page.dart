import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myapp/data/dao/expence_dao.dart';
import '../cubit/home_page_cubit.dart';
import '../cubit/search icon cubit/search_cubit.dart';
import '../cubit/theme_cubit/theme_cubit.dart';

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
        backgroundColor: Theme.of(context).colorScheme.background,
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Sum: ${expences.map((e) => e.Expences).reduce((value, element) => value + element)}", style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
                    Expanded(
                      child: ListView.builder(
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
                                  backgroundColor: Theme.of(context).colorScheme.surface,
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
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 219, 203, 203),
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(expence.Name , style: TextStyle(  color: Theme.of(context).colorScheme.secondary), ),
                                  subtitle: Text(expence.Expences.toString() , style: TextStyle( color: Theme.of(context).colorScheme.secondary),),
                                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey,),
                                 // leading:  const Icon(Icons.swipe_left, color: Colors.grey,),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: Text('No expenses found.'));
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.surface,
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
  leading: Icon(Icons.brightness_6),
  title: Text("Toggle Theme"),
  onTap: () {
    context.read<ThemeCubit>().toggleTheme();
    Navigator.pop(context); // Close the drawer
  },
),

            ],
          ),
        ),
      ),
    );
  }
}
