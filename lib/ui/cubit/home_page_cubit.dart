// ignore_for_file: non_constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/data/dao/expence_dao.dart';

import '../../data/repo/expence_repo.dart';

class HomePageCubit extends Cubit<List<ExpenceDao>> {
  HomePageCubit() : super([]);
  var expenceRepo = ExpenceRepository();

  Future<void> getExpence() async {
    emit(await expenceRepo.getExpence());
  }

  Future<void> deleteExpence(int Id) async {
    await expenceRepo.deleteExpence(Id);
    getExpence();
  }

  Future<void> findExpence(String query) async {
    var res = await expenceRepo.findExpence(query);
    emit(res);
  }
}
