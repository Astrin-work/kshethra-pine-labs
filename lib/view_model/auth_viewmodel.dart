import 'package:flutter/material.dart';

import 'package:kshethra_mini/view/language_select_view.dart';
import 'package:kshethra_mini/view/login_view.dart';

import '../api_services/api_service.dart';

class AuthViewmodel extends ChangeNotifier {
  TextEditingController userNameController = TextEditingController(text: 'u');
  TextEditingController passwordController = TextEditingController(text: 'u');

  final loginKey = GlobalKey<FormState>();

  bool _isPassVissible = false;
  bool get isPassVissible => _isPassVissible;

  final ApiService _apiService = ApiService();

  void tooglePass() {
    _isPassVissible = !_isPassVissible;
    notifyListeners();
  }

  void navigateHomeOrLogin(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then(
          (_) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      ),
    );
  }

  void selectLanguagePageNavigate(BuildContext context) async {
    bool valid = loginKey.currentState?.validate() ?? false;
    if (valid) {
      final username = userNameController.text.trim();
      final password = passwordController.text.trim();

      try {
        final token = await ApiService().login(username, password);
        print('Token: $token');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LanguageSelectView()),
        );
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${e.toString()}')),
        );
      }
    }
  }

}
