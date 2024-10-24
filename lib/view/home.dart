import 'package:armiyaapp/widget/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedLanguage = 'TR'; // Varsayılan dil kodu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Drawer'ı açmak için
              },
            );
          },
        ),
        title: Row(
          children: [
            DropdownButton<String>(
              value: selectedLanguage,
              icon: Icon(Icons.arrow_drop_down, color: Colors.black),
              underline: SizedBox(), // Alt çizgiyi kaldırıyoruz
              onChanged: (String? newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                });
              },
              items: <String>['TR', 'EN']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(value),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              Text(
                'AHMET ŞENER (#139)',
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(width: 8),
              PopupMenuButton<int>(
                icon: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Text('Profil'),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text('Çıkış Yap'),
                  ),
                ],
                onSelected: (value) {
                  if (value == 1) {
                    // Profil sayfasına yönlendir
                  } else if (value == 2) {
                    // Çıkış yap
                  }
                },
              ),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
      drawer: CustomDrawer(), // Drawer burada tanımlandı
      body: Center(
        child: Text('Ana Sayfa İçeriği'),
      ),
    );
  }
}