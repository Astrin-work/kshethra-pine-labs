import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

import 'package:kshethra_mini/view/language_select_view.dart';
import 'package:kshethra_mini/view/login_view.dart';

import '../api_services/api_service.dart';
import '../utils/app_color.dart';
import '../utils/components/snack_bar_widget.dart';

class AuthViewmodel extends ChangeNotifier {
  // final ApiService _apiService = ApiService();
  final loginKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: "");
  bool _isPassVissible = false;
  bool get isPassVissible => _isPassVissible;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final ValueNotifier<bool> isLoginLoading = ValueNotifier<bool>(false);

  void tooglePass() {
    _isPassVissible = !_isPassVissible;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
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

  Future<void> selectLanguagePageNavigate(BuildContext context) async {
    bool valid = loginKey.currentState?.validate() ?? false;
    if (valid) {
      final username = userNameController.text.trim();
      final password = passwordController.text.trim();

      try {
        final token = await ApiService().login(username, password);
        print('Token: $token');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBarWidget(msg: "Login successful", color: Colors.green).build(context),
        );
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


  void setLoginLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void logout(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBarWidget(msg: "Logout successful", color: kRed).build(context),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginView()),
          (route) => false,
    );
  }

  Future<void> printDeviceDetails() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo android = await deviceInfo.androidInfo;
        print('Device Info [Android]:');
        print('Brand: ${android.brand}');
        print('Device: ${android.device}');
        print('Model: ${android.model}');
        print('Android Version: ${android.version.release}');
        print('Android SDK: ${android.version.sdkInt}');
        print('serial number: ${android.serialNumber}');
        print('id: ${android.id}');
      } else if (Platform.isIOS) {
        IosDeviceInfo ios = await deviceInfo.iosInfo;
        print('Device Info [iOS]:');
        print('Name: ${ios.name}');
        print('Model: ${ios.model}');
        print('System Version: ${ios.systemVersion}');
        print('Identifier for Vendor: ${ios.identifierForVendor}');
      }
    } catch (e) {
      print('Failed to get device info: $e');
    }
  }



}
