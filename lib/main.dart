import 'package:armiyaapp/model/usermodel.dart';
import 'package:armiyaapp/providers/appoinment/appoinment_provider.dart';
import 'package:armiyaapp/view/appoinment/appoinment_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive'i başlat
  await Hive.initFlutter();

  // TypeAdapter'ı kaydet
  Hive.registerAdapter(UserAdapter());

  // 'userBox' adında bir kutu aç
  await Hive.openBox<User>('userBox');

  // Mevcut kullanıcıyı al
  var box = Hive.box<User>('userBox');
  User? currentUser = box.get('currentUser');

  // Kullanıcı bilgilerini kontrol et
  if (currentUser != null) {
    print("Kullanıcı ID: ${currentUser.iD}");
    print("Ad Soyad: ${currentUser.isimsoyisim}");
    print("Yetki Grubu: ${currentUser.yetkiGrubu}");
    print("Özel Yetkiler: ${currentUser.ozelYetkiler}");
  } else {
    print("Henüz kullanıcı kaydedilmedi.");
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppointmentProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
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
      home: const AppointmentView(),
    );
  }
}
