import 'package:armiyaapp/widget/card.dart';
import 'package:flutter/material.dart';

class PastAppointments extends StatelessWidget {
  const PastAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 60, right: 10, left: 10),
            child: Column(
              children: [
                ScheduleDropdown(),
                ScheduleDropdown(),
                ScheduleDropdown(),
              ],
             
            ),
          ),
        ],
      ),
    );
  }
}
