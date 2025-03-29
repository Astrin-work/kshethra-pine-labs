import 'package:flutter/material.dart';
import 'package:kshethra_mini/view/language_select_view.dart';
import 'package:kshethra_mini/view/login_view.dart';

class AuthViewmodel extends ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final loginKey = GlobalKey<FormState>();

  bool _isPassVissible = false;
  bool get isPassVissible => _isPassVissible;

  void tooglePass() {
    _isPassVissible = !_isPassVissible;
    notifyListeners();
  }

  void navigateHomeOrLogin(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then(
      (_) => Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
      ),
    );
  }

  void selectLanguagePageNavigate(BuildContext context) {
    bool valid = loginKey.currentState?.validate() ?? false;
    if (valid) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LanguageSelectView()),
      );
    }
  }
}
