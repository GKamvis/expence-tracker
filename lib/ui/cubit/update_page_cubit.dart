import 'package:myapp/data/repo/expence_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePageCubit extends Cubit<void> {
  UpdatePageCubit() : super(0);

  var expenceRepo = ExpenceRepository();
  // ignore: non_constant_identifier_names
  Future<void> updateExpence(int Id ,  String Name, double Expences) async {
    await expenceRepo.updateExpence(Id, Name, Expences);
  }
}
