import 'package:armiyaapp/data/app_shared_preference.dart';
import 'package:armiyaapp/model/usermodel.dart';
import 'package:armiyaapp/view/drawer.dart';
import 'package:armiyaapp/view/login.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel? userModel;
  final SharedDataService _sharedDataService = SharedDataService();
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

  // Kullanıcı çıkış işlemleri. Çıkış yaparken oturum bilgilerini temizle ve login sayfasına dön

  void logOut() async {
    await _sharedDataService.removeUserData();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
    // Çıkış yapma işlemleri
    print('Çıkış yapıldı');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 14, // Avatar boyutu
                        backgroundColor: Colors.purple, // Arka plan rengi
                        child: Icon(Icons.people,
                            color: Colors.white, size: 12), // People ikonu
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        userModel?.isimsoyisim ?? "null",
                        style: const TextStyle(
                            fontSize: 16), // Kullanıcı adının boyutu 16
                      ),
                      const SizedBox(
                          width: 4), // Kullanıcı adı ile ikon arasında boşluk
                      PopupMenuButton<String>(
                        icon: const Icon(
                            Icons.arrow_drop_down), // Aşağı ok simgesi
                        onSelected: (value) {
                          if (value == 'profile') {
                            // Profil sayfasına yönlendirme işlemleri
                            print('Profil seçildi');
                          } else if (value == 'logout') {
                            logOut(); // Çıkış yapma işlemi
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem<String>(
                            value: 'profile',
                            child: Text('Profil'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'logout',
                            child: Text('Çıkış Yap'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(4),
                    child: const Text("Süper User"),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      drawer: const MyDrawer(), // MyDrawer'ı burada tanımlıyoruz
      body: const Center(
        child: Text("Ana Sayfa İçeriği"), // Ana sayfa içeriği
      ),
    );
  }
}
