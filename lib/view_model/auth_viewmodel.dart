import 'package:flutter/material.dart';
import 'package:kshethra_mini/view/language_select_view.dart';

class AuthViewmodel extends ChangeNotifier{
   bool _isPassVissible = false;
  bool get isPassVissible => _isPassVissible;

    void tooglePass() {
    _isPassVissible = !_isPassVissible;
    notifyListeners();
  }
   void selectLanguagePageNavigate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LanguageSelectView()),
    );
  }
}