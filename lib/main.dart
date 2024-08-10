import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/ui/views/add_expence_page.dart';
import 'package:myapp/ui/views/update_ecpence.dart';
import 'ui/cubit/home_page_cubit.dart';
import 'ui/views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomePageCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 81, 111, 131)),
          useMaterial3: true,
        ),
        home:  const HomePage(),
        routes: {
          '/home': (context) => const HomePage(),
          '/add': (context) => AddExpence(),
          '/update': (context) => UpdateEcpence(),
       
        },
      ),
    );
  }
}
