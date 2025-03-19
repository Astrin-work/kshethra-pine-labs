import 'package:flutter/material.dart';
import 'package:kshethra_mini/view/login_view.dart';
import 'package:kshethra_mini/view_model/auth_viewmodel.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import 'package:kshethra_mini/view_model/donation_viewmodel.dart';
import 'package:kshethra_mini/view_model/e_hundi_viewmodel.dart';
import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => HomePageViewmodel()),
      ChangeNotifierProvider(create: (_) => EHundiViewmodel()),
      ChangeNotifierProvider(create: (_) => DonationViewmodel()),
      ChangeNotifierProvider(create: (_) => AuthViewmodel()),
      ChangeNotifierProvider(create: (_) => BookingViewmodel()),
      ],
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