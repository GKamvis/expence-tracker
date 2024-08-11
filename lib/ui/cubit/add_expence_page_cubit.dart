// ignore_for_file: non_constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/ui/cubit/home_page_cubit.dart';

import '../../data/repo/expence_repo.dart';

class AddExpencePageCubit extends Cubit<void>{

  AddExpencePageCubit() : super(0);

  var expenceRepo = ExpenceRepository();
  var getExpence = HomePageCubit().getExpence;

  Future<void> addExpence(String ExpenceName , double ExpenceAmount) async {
    await expenceRepo.addExpence(ExpenceName, ExpenceAmount);
    getExpence();
  }

}


