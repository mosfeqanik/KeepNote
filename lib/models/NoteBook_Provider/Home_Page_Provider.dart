import 'package:flutter/cupertino.dart';
import 'package:keepnote/models/note.dart';

class HomePageProvider extends ChangeNotifier {
  List<NoteBook> _notebooks = [];
  bool _isLoading = true;

  List<NoteBook> get notebooks => _notebooks;

  set notebooks(List<NoteBook> value) {
    _notebooks = value;
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();

  }
}
