import 'package:armiyaapp/providers/appoinment/appoinment_provider.dart';
import 'package:armiyaapp/splash_screen.dart';
import 'package:armiyaapp/view/active_appointments.dart';
import 'package:armiyaapp/view/appoinment/appoinment_view.dart';
import 'package:armiyaapp/view/appoinment/appointment_page.dart';
import 'package:armiyaapp/view/onboarding/onboarding_one.dart';
import 'package:armiyaapp/view/onboarding/onboarding_two.dart';
import 'package:armiyaapp/widget/cancelbutton.dart';
import 'package:armiyaapp/widget/navigatorbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppointmentProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 238, 238, 238),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      supportedLocales: const [Locale('tr')],
      home: OnboardingOne(),
    );
  }
}
