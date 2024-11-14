// import 'package:flutter/material.dart';

// class AppointmentCard extends StatelessWidget {
//   final String locationName;
//   final String locationType;
//   final String date;
//   final String startTime;
//   final String endTime;
//   final VoidCallback onCancel;

//   const AppointmentCard({super.key,
//     required this.locationName,
//     required this.locationType,
//     required this.date,
//     required this.startTime,
//     required this.endTime,
//     required this.onCancel,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,

//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//         side: const BorderSide(color: Colors.white),
//       ),
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               locationName,
//               style: const TextStyle(
//                 fontSize: 18,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               locationType,
//               style: const TextStyle(
//                 color: Color(0xFF6576FF),
//                 fontSize: 16,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Card(
//               color: const Color(0xFFEDF2F9),
//               child: InfoTile(title: 'Tarih', value: date),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Card(
//               color: const Color(0xFFEDF2F9),
//               child: InfoTile(title: 'Başlangıç Saati', value: startTime),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Card(
//               color: const Color(0xFFEDF2F9),
//               child: InfoTile(title: 'Bitiş Saati', value: endTime),
//             ),
//             const SizedBox(height: 16),
//             Center(
//               child: OutlinedButton(
//                 onPressed: onCancel,
//                 style: OutlinedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 255, 242, 241),
//                   side: const BorderSide(
//                       color: Color.fromARGB(255, 255, 218, 216), width: 2),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 child: const Text(
//                   "Randevu İptal",
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class InfoTile extends StatelessWidget {
//   final String title;
//   final String value;

//   const InfoTile({super.key, required this.title, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         children: [
//           Text(
//             title,
//             style: const TextStyle(color: Colors.grey, fontSize: 14),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             value,
//             style: const TextStyle(
//               fontWeight: FontWeight.normal,
//               fontSize: 18,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../const/const.dart';

// class AppointmentCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String date;
//   final String time;
//   final String buttonText;
//   final VoidCallback onButtonPressed;

//   const AppointmentCard({
//     Key? key,
//     required this.title,
//     required this.subtitle,
//     required this.date,
//     required this.time,
//     required this.buttonText,
//     required this.onButtonPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.normal,
//               color: Colors.black,
//             ),
//           ),
//           Text(
//             subtitle,
//             style: TextStyle(
//               fontSize: 14,
//               color: primaryColor,
//             ),
//           ),
//           SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,

//             // crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildInfoBox(date, Icons.calendar_today),
//               _buildInfoBox(time, Icons.access_time),
//             ],
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: onButtonPressed,
//             style: ElevatedButton.styleFrom(
//               backgroundColor:
//                   Color.fromARGB(255, 193, 196, 231), // Buton rengi
//               shape: RoundedRectangleBorder(
//                 side: BorderSide(
//                     width: 1, color: Color.fromARGB(255, 70, 88, 255)),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: Text(
//               buttonText,
//               style: TextStyle(color: Color.fromARGB(255, 70, 88, 255)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Tarih ve saat bilgisi için kutu tasarımı
//   Widget _buildInfoBox(String text, IconData icon) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: primaryColor), // İkonu ekle
//           SizedBox(width: 8), // İkon ile metin arasında boşluk
//           Text(
//             text,
//             style: const TextStyle(fontSize: 14, color: Colors.black54),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../const/const.dart';

class AppointmentCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final String time;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const AppointmentCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.time,
    required this.buttonText,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 10, // Gölge yüksekliği
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Kartın köşe yuvarlaklığı
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoBox(date, Icons.calendar_today),
                _buildInfoBox(time, Icons.access_time),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onButtonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromARGB(255, 193, 196, 231), // Buton rengi
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1, color: Color.fromARGB(255, 70, 88, 255)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                buttonText,
                style: TextStyle(color: Color.fromARGB(255, 70, 88, 255)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tarih ve saat bilgisi için kutu tasarımı
  Widget _buildInfoBox(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryColor),
          SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}




/////////////gecmıs  randevu kartı



class PastAppointmentCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final String time;

  const PastAppointmentCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sol tarafta kalın renk şeridi
          Container(
            width: 8,
            height: double.infinity,
            color: Colors.grey.shade400, // Şerit rengi
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Başlık ve alt başlık
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 12),
                  // Tarih ve saat bilgisi için minimalist kutular
                  Row(
                    children: [
                      _buildInfoBox(date, Icons.calendar_today, Colors.grey.shade700),
                      SizedBox(width: 16),
                      _buildInfoBox(time, Icons.access_time, Colors.grey.shade700),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Tarih ve saat bilgisi için minimalist kutu tasarımı
  Widget _buildInfoBox(String text, IconData icon, Color iconColor) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 20),
        SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }
}

