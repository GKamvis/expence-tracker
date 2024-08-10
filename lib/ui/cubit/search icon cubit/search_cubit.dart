import 'package:bloc/bloc.dart';
class SearchCubit extends Cubit<bool> {
  SearchCubit() : super(false);
  void toggleSearch() => emit(!state);
  
}
