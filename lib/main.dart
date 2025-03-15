import 'package:flutter/material.dart';
import 'package:kshethra_mini/view/language_select_view.dart';
import 'package:kshethra_mini/view/login_view.dart';
import 'package:kshethra_mini/view/payment_complete_screen.dart';
import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => HomePageViewmodel())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginView(), debugShowCheckedModeBanner: false);
  }
}
