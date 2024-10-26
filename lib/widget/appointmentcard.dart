import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final String locationName;
  final String locationType;
  final String date;
  final String startTime;
  final String endTime;
  final VoidCallback onCancel;

  const AppointmentCard({super.key, 
    required this.locationName,
    required this.locationType,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.white),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              locationName,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              locationType,
              style: const TextStyle(
                color: Color(0xFF6576FF),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: const Color(0xFFEDF2F9),
              child: InfoTile(title: 'Tarih', value: date),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              color: const Color(0xFFEDF2F9),
              child: InfoTile(title: 'Başlangıç Saati', value: startTime),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              color: const Color(0xFFEDF2F9),
              child: InfoTile(title: 'Bitiş Saati', value: endTime),
            ),
            const SizedBox(height: 16),
            Center(
              child: OutlinedButton(
                onPressed: onCancel,
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 242, 241),
                  side: const BorderSide(
                      color: Color.fromARGB(255, 255, 218, 216), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Randevu İptal",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const InfoTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
