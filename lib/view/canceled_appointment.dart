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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 5, left: 5),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Sola yaslama
              children: [
                const Row(
                  mainAxisAlignment:
                      MainAxisAlignment.start, // Sol tarafa yaslama
                ),
                const SizedBox(
                  height: 10,
                ),
                AppointmentCard(
                  buttonText: "GERİ AL",
                  title: 'Galata Spor Ve Eğlence Merkezi',
                  subtitle: 'Fitness Salonu',
                  date: '12.10.2025',
                  time: '15:30',
                  onButtonPressed: () {},
                ),
                SizedBox(
                  height: 10,
                ),
                AppointmentCard(
                  buttonText: "GERİ AL",
                  title: 'Galata Spor Ve Eğlence Merkezi',
                  subtitle: 'Fitness Salonu',
                  date: '12.10.2025',
                  time: '15:30',
                  onButtonPressed: () {},
                ),
                SizedBox(
                  height: 10,
                ),
                AppointmentCard(
                  buttonText: "GERİ AL",
                  title: 'Galata Spor Ve Eğlence Merkezi',
                  subtitle: 'Fitness Salonu',
                  date: '12.10.2025',
                  time: '15:30',
                  onButtonPressed: () {},
                ),
                SizedBox(
                  height: 10,
                ),
                // Column(
                //   children: [
                //     Card(
                //       color: Colors.grey,
                //       elevation: 4,
                //       child: Column(
                //         children: [
                //           AppointmentCard(
                //             buttonText: "Geri Al",
                //             title: 'Galata Spor Ve Eğlence Merkezi',
                //             subtitle: 'Fitness Salonu',
                //             date: '12.10.2024',
                //             time: '15:30 - 18:30',
                //             onButtonPressed: () {},
                //           ),
                //         ],
                //       ),
                //     ),
                //     SizedBox(
                //       height: 10,
                //     ),
                //     Card(
                //       elevation: 4,
                //       color: Colors.white,
                //       child: Column(
                //         children: [
                //           AppointmentCard(
                //             buttonText: "Geri Al",
                //             title: 'Galata Spor Ve Eğlence Merkezi',
                //             subtitle: 'Fitness Salonu',
                //             date: '12.10.2024',
                //             time: '15:30 - 18:30',
                //             onButtonPressed: () {},
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
