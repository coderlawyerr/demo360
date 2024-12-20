import 'dart:ui';
import 'package:armiyaapp/data/app_shared_preference.dart';
import 'package:armiyaapp/model/usermodel.dart';

import 'package:armiyaapp/view/appoinment/appoinment_view.dart';

import 'package:armiyaapp/view/qr_page.dart';
import 'package:armiyaapp/view/tabbar/tabbar.dart';
import 'package:armiyaapp/view/login.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:armiyaapp/const/const.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel? userModel;
  final SharedDataService _sharedDataService = SharedDataService();
  int _page = 0; // Bottom navigation'da seçili olan sayfa

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  // Kullanıcı adını ayarlamak için bir fonksiyon
  getUserData() async {
    _sharedDataService.getLoginData().then((userData) {
      userModel = userData;
      setState(() {});
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  // Her sekme için ilgili sayfa widget'ını döndüren fonksiyon
  Widget getSelectedPage(int index) {
    switch (index) {
      case 0:
        return MyTabbar(); // Randevular
      case 1:
        return AppointmentView(); // Randevu Oluştur
      case 2:
        return QRImageFetcher(); // QR Kod
      default:
        return MyTabbar(); // Varsayılan sayfa
    }
  }

  // Çıkış uyarısı için bulanık arka planlı alert dialog
  void showExitDialog() {
    showDialog(
      context: context,
      barrierDismissible: true, // Kullanıcının dialog dışında tıklayarak kapatmasına izin verir
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Arka plan bulanıklığı
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Çıkış Yapmak Üzeresin !'),
            content: Text('Çıkmak istediğinizden emin misiniz?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Dialogu kapat
                },
                child: Text('Hayır', style: TextStyle(color: Colors.black)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Dialogu kapat
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('Evet', style: TextStyle(color: primaryColor)),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page,
        items: <Widget>[
          Icon(Icons.event, size: 30, color: Colors.white), // Randevular
          Icon(Icons.add, size: 30, color: Colors.white), // Randevu Oluştur
          Icon(Icons.qr_code, size: 30, color: Colors.white), // QR Kod
          Icon(Icons.exit_to_app, size: 30, color: Colors.white), // Çıkış
        ],
        color: primaryColor,
        buttonBackgroundColor: primaryColor,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 500),
        onTap: (index) {
          setState(() {
            _page = index;
          });

          // Eğer çıkış sayfası (index == 3) seçildiyse dialog göster
          if (index == 3) {
            showExitDialog();
          }
        },
        letIndexChange: (index) => true,
      ),
      body: getSelectedPage(_page), // Alt menüden seçilen sayfayı burada gösteriyoruz
    );
  }
}
