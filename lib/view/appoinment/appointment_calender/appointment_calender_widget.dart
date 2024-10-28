import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'appointment_calender_service.dart';

class AppointmentCalenderWidget extends StatefulWidget {
  const AppointmentCalenderWidget({super.key, required this.onDateSelected});
  final Function(DateTime) onDateSelected;
  @override
  State<AppointmentCalenderWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AppointmentCalenderWidget> {
  final CalendarController calendarController = CalendarController();

  final aktifGunSayisi = 0;
  @override
  void initState() {
    AppointmentService()
        .fetchServiceDetails(selectedFacilityId: 1, selectedServiceIds: []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  calendarController.backward!();
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              IconButton(
                onPressed: () {
                  calendarController.forward!();
                },
                icon: const Icon(Icons.arrow_forward_ios_sharp),
              ),
              TextButton(
                onPressed: () {
                  calendarController.displayDate = DateTime.now();
                },
                child: const Text('Bugün'),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SfCalendar(
            controller: calendarController,
            onSelectionChanged: (calendarSelectionDetails) {
              DateTime? selected = calendarSelectionDetails.date;
              if (selected == null) return;

              // Geçmiş tarihi kontrol et (bugün ve geleceği seçebilir)
              DateTime today = DateTime.now();
              DateTime? maxDate;
              if (aktifGunSayisi > 0) {
                maxDate = today.add(Duration(days: aktifGunSayisi));
              }

              if (selected.isBefore(today.subtract(const Duration(days: 1))) ||
                  (maxDate != null && selected.isAfter(maxDate))) {
                // Geçmiş veya izin verilen maksimum tarihten sonra bir tarih seçildi
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Bu tarih seçilemez.'),
                  ),
                );
                return;
              }

              widget.onDateSelected(selected);

              // Tarihi seç ve saat dilimlerini göster
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                try {
                  // await selectDate(context, selected);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Servis detayları alınamadı: $e'),
                    ),
                  );
                }
              });
            },
            view: CalendarView.month,
            timeZone: 'Turkey Standard Time',
            timeSlotViewSettings:
                const TimeSlotViewSettings(timeFormat: 'HH:mm'),
            monthViewSettings: const MonthViewSettings(
              showTrailingAndLeadingDates:
                  false, // Trailing ve leading tarihleri gizle
              dayFormat: 'd',
            ),
            minDate: DateTime.now(),
            maxDate: aktifGunSayisi > 0
                ? DateTime.now().add(Duration(days: aktifGunSayisi))
                : DateTime.now().add(
                    const Duration(days: 365)), // aktifGunSayisi 0 ise 1 yıl
            monthCellBuilder: (BuildContext context, MonthCellDetails details) {
              DateTime date = details.date;
              DateTime today = DateTime.now();
              DateTime? maxDate;
              if (aktifGunSayisi > 0) {
                maxDate = today.add(Duration(days: aktifGunSayisi));
              }

              bool isSelectable = true;
              if (date.isBefore(today.subtract(const Duration(days: 1)))) {
                isSelectable = false;
              } else if (maxDate != null && date.isAfter(maxDate)) {
                isSelectable = false;
              }

              // print('Date: $date, Selectable: $isSelectable');

              return Container(
                decoration: BoxDecoration(
                  color: isSelectable ? Colors.white : Colors.grey[300],
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(
                      color: isSelectable ? Colors.black : Colors.grey,
                      fontWeight:
                          isSelectable ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
