import 'package:armiyaapp/data/app_shared_preference.dart';
import 'package:armiyaapp/view/home_page.dart';
import 'package:armiyaapp/view/login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SharedDataService _dataService = SharedDataService();

  @override
  void initState() {
    initUserData();
    super.initState();
  }

// Kullanıcı daha önce oturup açmış ise home page e git açmamış ise logine
  initUserData() async {
    await Future.delayed(const Duration(seconds: 1));
    await _dataService.getLoginData().then((res) {
      if (res == null) {
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [CircularProgressIndicator(), Text("Yükleniyor..")],
        ),
      ),
    );
  }
}



// Email : 