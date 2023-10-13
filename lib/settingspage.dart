import 'package:riverpod/riverpod.dart';
import 'package:state_riverpod/theme_provider.dart';

class NotiferState extends StateNotifier<List<Notes>>{
  NotiferState():super([]);

  void addnotes(Notes note){
    state=[...state,note];
  }
  void removenotes(Notes note){
    state=state.where((_note) => _note!=note).toList();
  }
}