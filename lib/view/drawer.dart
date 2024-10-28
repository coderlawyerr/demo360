import 'package:flutter/material.dart';

import '../navigator/custom_navigator.dart';
import 'appoinment/appoinment_view.dart';
import 'qr_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final AppNavigator nav = AppNavigator.instance;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            ExpansionTile(
              leading: Icon(Icons.calendar_today, color: Colors.grey[90]),
              title: Text('Randevularım',
                  style: TextStyle(color: Colors.grey[90])),
              children: [
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text('Aktif Randevularım',
                        style: TextStyle(color: Colors.grey[90])),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    nav.push(
                        context: context, routePage: const AppointmentView());
                    // Aktif Randevularım sayfasına yönlendirme kodu
                  },
                ),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text('İptal Edilen Randevularım',
                        style: TextStyle(color: Colors.grey[90])),
                  ),
                  onTap: () {
                    Navigator.pop(context);

                    nav.push(
                        context: context, routePage: const AppointmentView());
                    // İptal Edilen Randevularım sayfasına yönlendirme kodu
                  },
                ),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text('Geçmiş Randevularım',
                        style: TextStyle(color: Colors.grey[90])),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    nav.push(
                        context: context, routePage: const AppointmentView());
                    // Geçmiş Randevularım sayfasına yönlendirme kodu
                  },
                ),
              ],
            ),
            _createDrawerItem(
              icon: Icons.add_box,
              text: 'Randevu Oluştur',
              onTap: () {
                Navigator.pop(context);
                // Randevu oluşturma sayfasına yönlendirme kodu
              },
            ),
            _createDrawerItem(
              icon: Icons.event,
              text: 'Randevu Ekle',
              onTap: () {
                Navigator.pop(context);
                // Randevu ekleme sayfasına yönlendirme kodu
              },
            ),
            _createDrawerItem(
              icon: Icons.qr_code,
              text: 'QR Kod',
              onTap: () {
                Navigator.pop(context);
                nav.push(context: context, routePage: QRImageFetcher());
                // QR Kod sayfasına yönlendirme kodu
              },
            ),
            const Spacer(),
            ListTile(
              title: const Text('Versiyon 1.0.0',
                  style: TextStyle(color: Color.fromARGB(255, 75, 75, 75))),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    GestureTapCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[90]), // İkonun rengi gri
      title: Text(
        text,
        style: TextStyle(color: Colors.grey[90]), // Yazının rengi gri
      ),
      onTap: onTap,
    );
  }
}
