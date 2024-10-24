// appointment_view.dart

import 'package:armiyaapp/model/new_model/newmodel.dart';
import 'package:armiyaapp/providers/appoinment/appoinment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentView extends StatefulWidget {
  const AppointmentView({super.key});

  @override
  _AppointmentViewState createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  @override
  void initState() {
    super.initState();
    // Widget ilk oluşturulduğunda tesisleri çek
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<AppointmentProvider>(context, listen: false);
      provider.fetchFacilities().catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tesisler alınamadı: $error')),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Randevu Oluştur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<AppointmentProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Randevu Oluştur',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Tesis Seçimi',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  // 1. Tesis Seçimi Dropdown
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: DropdownButton<int>(
                      underline: const SizedBox(),
                      hint: const Text('Tesis Seçiniz'),
                      value: provider.selectedFacilityId,
                      isExpanded: true,
                      items: provider.facilities.map((facility) {
                        return DropdownMenuItem<int>(
                          value: facility.tesisId,
                          child: Text(facility.tesisAd ?? 'Bilinmeyen Tesis'),
                        );
                      }).toList(),
                      onChanged: (value) async {
                        if (value != null) {
                          provider.setSelectedFacility(value);
                          try {
                            await provider.fetchServices(value);
                            // Hizmetler yüklendiğinde takvimi yeniden göster

                            provider.resetToCalendar(); // Takvimi sıfırla
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Hizmetleri alırken hata oluştu: $e'),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 2. Hizmet Seçimi (MultiDropdown)
                  Text("Hizmet Seçimi"),
                  MultiDropdown(
                    items: provider.services.map((service) {
                      return DropdownItem<int>(
                        value: service.hizmetId!,
                        label: service.hizmetAd ?? 'Bilinmeyen Hizmet',
                      );
                    }).toList(),
                    onSelectionChange: (List<int> selectedIds) async {
                      provider.setSelectedServices(selectedIds);
                      if (selectedIds.isNotEmpty) {
                        // Hizmet seçildiğinde takvimi göstermek için
                      } else {
                        // Hizmet seçimi temizlendiğinde takvimi gizlemek için
                        provider.resetToCalendar();
                      }
                    },
                    selectedItemBuilder: (selectedItems) {
                      // Seçilen hizmetlerin nasıl görüneceğini burada özelleştirebilirsiniz
                      return Wrap(spacing: 8.0, children: [
                        Chip(
                          padding: EdgeInsets.zero,
                          label: Text(selectedItems.label),
                          onDeleted: () {
                            // Chip silindiğinde hizmeti seçili listeden çıkar
                            final id = selectedItems.value;
                            final updatedIds =
                                List<int>.from(provider.selectedServiceIds);
                            updatedIds.remove(id);
                            provider.setSelectedServices(updatedIds);
                          },
                        )
                      ]);
                    },
                  ),
                  const SizedBox(height: 20),
                  // Takvim
                  Visibility(
                    visible: provider.showCalendar,
                    child: Column(
                      children: [
                        // Takvim Kontrolleri
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                provider.calendarController.backward!();
                              },
                              icon: const Icon(Icons.arrow_back_ios_new),
                            ),
                            IconButton(
                              onPressed: () {
                                provider.calendarController.forward!();
                              },
                              icon: const Icon(Icons.arrow_forward_ios_sharp),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                provider.calendarController.displayDate =
                                    DateTime.now();
                              },
                              child: const Text('Bugün'),
                            ),
                          ],
                        ),
                        // Takvim
                        buildCalendar(context, provider),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Saat Dilimleri
                  Visibility(
                    visible: provider.showTimeSlots &&
                        provider.serviceTimeSlots.isNotEmpty,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Randevu Saati Seçimi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Mavi Randevu eklenebilir',
                          style: TextStyle(color: Colors.blue),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.topRight,
                          child: ElevatedButton(
                            onPressed: () {
                              provider.resetToCalendar();
                            },
                            child: const Text('Takvime Dön'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Hizmet Adı',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        // Hizmet Adları ve Kapasite Bilgisi
                        Wrap(
                          spacing: 8.0,
                          children: provider.selectedServices.map((service) {
                            return Chip(
                              label: Text(
                                '${service.hizmetAd ?? 'Hizmet'} - Kapasite: ${service.saatlikKapasite ?? 'Bilinmiyor'}',
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 10),
                        // Saat Dilimlerini Listele (Her Hizmet için)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.selectedServices.length,
                          itemBuilder: (context, serviceIndex) {
                            final service =
                                provider.selectedServices[serviceIndex];
                            final serviceId = service.hizmetId!;
                            final serviceSlots =
                                provider.serviceTimeSlots[serviceId] ??
                                    []; //saat aralıkları apıden gelıyor

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Hizmet Adı ve Kapasite Bilgisi
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: Text(
                                    '${service.hizmetAd ?? 'Hizmet'} - Kapasite: ${service.saatlikKapasite ?? 'Bilinmiyor'}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                // Saat Dilimleri
                                serviceSlots.isNotEmpty
                                    ? GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: const EdgeInsets.all(8.0),
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent:
                                              150.0, // Adjusted width
                                          mainAxisSpacing: 8.0,
                                          crossAxisSpacing: 8.0,
                                          childAspectRatio: 3 / 1,
                                        ),
                                        itemCount: serviceSlots.length,
                                        itemBuilder: (context, slotIndex) {
                                          final timeSlot =
                                              serviceSlots[slotIndex];
                                          final periyot = provider
                                              .servicePeriyots[serviceId]!;
                                          final bitisSaati = timeSlot
                                              .add(Duration(minutes: periyot));
                                          final formattedStartTime =
                                              DateFormat('Hm').format(timeSlot);
                                          final formattedEndTime =
                                              DateFormat('Hm')
                                                  .format(bitisSaati);

                                          // Check if the time slot is in the past
                                          bool isPast =
                                              timeSlot.isBefore(DateTime.now());

                                          return Opacity(
                                            opacity: isPast
                                                ? 0.5
                                                : 1.0, // Reduce opacity for past slots
                                            child: GestureDetector(
                                              onTap: isPast
                                                  ? null // Disable tap for past slots
                                                  : () {
                                                      // Handle time slot selection
                                                      // e.g., provider.selectTimeSlot(timeSlot);
                                                    },
                                              child: Chip(
                                                label: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      '$formattedStartTime - $formattedEndTime',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    // Add availability indicator here (optional)
                                                  ],
                                                ),
                                                backgroundColor:
                                                    Colors.blue.shade100,
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : const Text(
                                        'No available time slots for this service.',
                                        style: TextStyle(color: Colors.red),
                                      ),

                                const SizedBox(height: 20),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

////////   /////////           //////////           ////////////
  // Saat seçimi widget'ı için
  Widget buildCalendar(BuildContext context, AppointmentProvider provider) {
    return SfCalendar(
      controller: provider.calendarController,
      onSelectionChanged: (calendarSelectionDetails) {
        DateTime? selected = calendarSelectionDetails.date;
        if (selected == null) return;

        print('Seçilen Tarih: $selected');

        // Geçmiş tarihi kontrol et (bugün ve geleceği seçebilir)
        DateTime today = DateTime.now();
        DateTime? maxDate;
        if (provider.aktifGunSayisi > 0) {
          maxDate = today.add(Duration(days: provider.aktifGunSayisi));
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

        // Tarihi seç ve saat dilimlerini göster
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          try {
            await provider.selectDate(context, selected);
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
      timeSlotViewSettings: const TimeSlotViewSettings(timeFormat: 'HH:mm'),
      monthViewSettings: const MonthViewSettings(
        showTrailingAndLeadingDates:
            false, // Trailing ve leading tarihleri gizle
        dayFormat: 'd',
      ),
      minDate: DateTime.now(),
      maxDate: provider.aktifGunSayisi > 0
          ? DateTime.now().add(Duration(days: provider.aktifGunSayisi))
          : DateTime.now()
              .add(const Duration(days: 365)), // aktifGunSayisi 0 ise 1 yıl
      monthCellBuilder: (BuildContext context, MonthCellDetails details) {
        DateTime date = details.date;
        DateTime today = DateTime.now();
        DateTime? maxDate;
        if (provider.aktifGunSayisi > 0) {
          maxDate = today.add(Duration(days: provider.aktifGunSayisi));
        }

        bool isSelectable = true;
        if (date.isBefore(today.subtract(const Duration(days: 1)))) {
          isSelectable = false;
        } else if (maxDate != null && date.isAfter(maxDate)) {
          isSelectable = false;
        }

        print('Date: $date, Selectable: $isSelectable');

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
                fontWeight: isSelectable ? FontWeight.normal : FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

//////////////////////
  Map<String, Color> kontrolEt(List<Secilisaatler> secilisaatler,
      List<Randevu> randevular, int girisYapanKullaniciId) {
    Map<String, Color> saatDurumlari = {};

    for (var saat in secilisaatler) {
      bool saatDurumu = false; // Varsayılan durum false

      for (var randevu in randevular) {
        // Başlangıç saatlerini, hizmeti ve kullanıcı ID'lerini kontrol et
        if (saat.baslangicsaati == randevu.baslangicsaati &&
            saat.hizmetad == randevu.hizmetad &&
            saat.hizmetId == randevu.hizmetid &&
            randevu.kullaniciid == girisYapanKullaniciId) {
          // Eğer giriş yapan kullanıcının ID'si ile randevudaki kullanıcı ID'si eşleşiyorsa
          saatDurumu = true; // Durum yeşil
          break; // Eşleşme bulundu, döngüden çık
        }
      }

      // Durumu kontrol et ve uygun rengi belirle
      if (saatDurumu) {
        saatDurumlari[saat.baslangicsaati ?? ''] = Colors.green; // Yeşil
      } else {
        saatDurumlari[saat.baslangicsaati ?? ''] = Colors.red; // Kırmızı
      }
    }

    return saatDurumlari; // Renk durumlarını döndür
  }
}
