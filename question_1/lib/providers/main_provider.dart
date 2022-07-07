import 'package:flutter/cupertino.dart';

class MainProvider extends ChangeNotifier {
  String? takeDataUser = '';

  changeDataUser(String user) {
    takeDataUser = user;
    notifyListeners();
  }
}
