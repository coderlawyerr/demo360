import 'package:armiyaapp/widget/appointmentcard.dart';
import 'package:flutter/material.dart';

class ActiveAppointment extends StatefulWidget {
  const ActiveAppointment({super.key});

  @override
  State<ActiveAppointment> createState() => _ActiveAppointmentState();
}

class _ActiveAppointmentState extends State<ActiveAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Sola yaslama
            children: [
              const Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Sol tarafa yaslama
              ),
              const Text(
                "Randevularınızı, randevu gününü başlangıç saatinden  en geç  60 dakika öncesine  kadar iptal edebilirsiniz",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey),
              ),
              SizedBox(
                height: 20,
              ),
              AppointmentCard(
                buttonText: "RANDEVU AL",
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
                buttonText: "RANDEVU AL",
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
                buttonText: "RANDEVU AL",
                title: 'Galata Spor Ve Eğlence Merkezi',
                subtitle: 'Fitness Salonu',
                date: '12.10.2025',
                time: '15:30',
                onButtonPressed: () {},
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
