import 'package:armiyaapp/widget/appointmentcard.dart';
import 'package:flutter/material.dart';

class CanceledAppointment extends StatefulWidget {
  const CanceledAppointment({super.key});

  @override
  State<CanceledAppointment> createState() => _CanceledAppointment();
}

class _CanceledAppointment extends State<CanceledAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60, right: 15, left: 15),
        child: Card(
          elevation: 4,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Sola yaslama
              children: [
                const Row(
                  mainAxisAlignment:
                      MainAxisAlignment.start, // Sol tarafa yaslama
                  children: [
                    Text(
                      " İptal Edilen Randevularınız",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Randevularınızı, randevu gününü başlangıç saatinden  en geç  60 dakika öncesine  kadar iptal edebilirsiniz",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey),
                ),
                Card(
                  child: Column(
                    children: [
                      AppointmentCard(
                        locationName: "Mahide Hatun Spor Kompleksi",
                        locationType: "Fitness Salonu",
                        date: "29.10.2024",
                        startTime: "21:30",
                        endTime: "23:00",
                        onCancel: () {
                          // Randevu iptal işlemi burada yapılabilir
                          print("Randevu iptal edildi");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
