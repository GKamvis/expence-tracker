// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/data/dao/expence_dao.dart';
import 'package:myapp/ui/cubit/update_page_cubit.dart';

import '../cubit/home_page_cubit.dart';

class UpdateEcpence extends StatelessWidget {
  UpdateEcpence({super.key});
  var tfController = TextEditingController();
  var tfController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ExpenceDao expence =
        ModalRoute.of(context)!.settings.arguments as ExpenceDao;
    final TextEditingController nameController =
        TextEditingController(text: expence.Name);
    final TextEditingController expencesController =
        TextEditingController(text: expence.Expences.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Column(
              
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
                controller: nameController,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
                   fillColor: Theme.of(context).colorScheme.primary,

                  hintText: 'Update  your Expence',
                )),
            TextField( 
              keyboardType: TextInputType.number,
                controller: expencesController,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
                 fillColor: Theme.of(context).colorScheme.primary,

                  hintText: 'Update your expense amount',
                )),
            ElevatedButton(
                onPressed: () {
                  context.read<UpdatePageCubit>().updateExpence(
                      expence.Id,
                      nameController.text,
                      double.parse(expencesController.text));
                  context.read<HomePageCubit>().getExpence();
                  Navigator.pushNamed(context, '/home');
                },
                child: const Text('update'))
          ],
        )),
      ),
    );
  }
}
