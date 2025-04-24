import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kshethra_mini/view/login_view.dart';
import 'package:kshethra_mini/view_model/auth_viewmodel.dart';
import 'package:kshethra_mini/view_model/booking_viewmodel.dart';
import 'package:kshethra_mini/view_model/donation_viewmodel.dart';
import 'package:kshethra_mini/view_model/e_hundi_viewmodel.dart';
import 'package:kshethra_mini/view_model/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ml'),
        Locale('ta'),
        Locale('te'),
        Locale('hi'),
      ],
      path: 'assets/languages',
      fallbackLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomePageViewmodel()),
          ChangeNotifierProvider(create: (_) => EHundiViewmodel()),
          ChangeNotifierProvider(create: (_) => DonationViewmodel()),
          ChangeNotifierProvider(create: (_) => AuthViewmodel()),
          ChangeNotifierProvider(create: (_) => BookingViewmodel()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      home: LoginView(),
    );

  }
}
