// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/ui/cubit/add_expence_page_cubit.dart';

import '../cubit/home_page_cubit.dart';

class AddExpence extends StatelessWidget {
  AddExpence({super.key});
  var tfController = TextEditingController();
  var tfController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
                controller: tfController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
                  hintText: 'Whats your expence ',
                )),
            TextField(
                keyboardType: TextInputType.number,
                controller: tfController2,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
                  hintText: 'How much do you spend? ',
                )),
            ElevatedButton(
                onPressed: () {
                  context.read<AddExpencePageCubit>().addExpence(
                      tfController.text, double.parse(tfController2.text));
                  context.read<HomePageCubit>().getExpence();
                  Navigator.pop(context);
                },
                child: const Text('Submit'))
          ],
        )),
      ),
    );
  }
}
