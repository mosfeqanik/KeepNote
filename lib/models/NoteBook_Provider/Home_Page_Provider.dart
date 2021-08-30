import 'package:flutter/cupertino.dart';
import 'package:keepnote/models/note.dart';
import 'package:keepnote/models/user.dart';

class HomePageProvider extends ChangeNotifier {

  List<UserModel> _users = [];


  List<NoteBook> _notebooks = [];
  List<NoteBook> get notebooks => _notebooks;
  set notebooks(List<NoteBook> value) {
    _notebooks = value;
  }

  List<UserModel> get users => _users;
  set users(List<UserModel> value) {
    _users = value;
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
