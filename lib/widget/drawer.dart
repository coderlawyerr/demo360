
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: 50), // Üstte boşluk bırakmak için
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Anasayfa'),
            onTap: () {},
          ),

          ////////////////Randevu
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text('Randevu Oluştur'),
              onTap: () {},
            ),
          ),

          ListTile(
            leading: const Icon(Icons.meeting_room),
            title: const Text("Randevu Oluştur"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
