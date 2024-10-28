// appointment_view.dart

import 'package:armiyaapp/providers/appoinment/appoinment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class AppointmentView extends StatefulWidget {
  const AppointmentView({super.key});

  @override
  State createState() => _AppointmentViewState();
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4))),
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
                        provider.setSelectedDate(null);
                        provider.calendarController.selectedDate = null;
                        provider.setSelectedServices([]);

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
                  const Text(
                    "Hizmet Seçimi",
                    style: TextStyle(fontSize: 16),
                  ),

                  MultiDropdown(
                    items: provider.services.map((service) {
                      return DropdownItem<int>(
                        value: service.hizmetId!,
                        label: service.hizmetAd ?? 'Bilinmeyen Hizmet',
                      );
                    }).toList(),
                    onSelectionChange: (List<int> selectedIds) async {
                      provider.resetToCalendar();
                      provider.setSelectedServices(selectedIds);
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
                            provider.resetToCalendar();
                            // provider.setSelectedServices(updatedIds);
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
                        provider.buildCalendar(context),
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
                          'Mavi : Randevu eklenebilir',
                          style: TextStyle(color: Colors.blue),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        const Text(
                          'Kırmızı : Kapasite dolu',
                          style: TextStyle(color: Colors.red),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        const Text(
                          'Yeşil: Kayıtlı randevunuz',
                          style: TextStyle(color: Colors.green),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        const Text(
                          'Sarı: Aynı saatte randevunuz var',
                          style: TextStyle(color: Colors.yellow),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.topRight,
                          child: ElevatedButton(
                            onPressed: () {
                              provider.resetToCalendar();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                  0xFF5664D9), // Butonun arka plan rengi
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  8, // Buradaki değeri köşe keskinliğine göre ayarlayabilirsiniz
                                ),
                              ),
                            ),
                            child: const Text(
                              'Takvime Dön',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        // const Text(
                        //   'Hizmet Adı',
                        //   style: TextStyle(fontSize: 16),
                        // ),
                        const SizedBox(height: 10),
                        // Hizmet Adları ve Kapasite Bilgisi
                        // Wrap(
                        //   spacing: 8.0,
                        //   children: provider.selectedServices.map((service) {
                        //     return Chip(
                        //       label: Text(
                        //         '${service.hizmetAd ?? 'Hizmet'} - Kapasite: ${service.saatlikKapasite ?? 'Bilinmiyor'}',
                        //       ),
                        //     );
                        //   }).toList(),
                        // ),
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
                                    []; // saat aralıkları apıden geliyor

                            // Renk haritasını al
                            final colorMap = provider.kontrolEt(serviceId);

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
                                      fontWeight: FontWeight.normal,
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
                                              DateFormat('HH:mm')
                                                  .format(timeSlot);
                                          final formattedEndTime =
                                              DateFormat('HH:mm')
                                                  .format(bitisSaati);

                                          // Geçmiş saat dilimlerini kontrol et
                                          bool isPast =
                                              timeSlot.isBefore(DateTime.now());

                                          // Renk haritasına göre rengi belirle
                                          Color slotColor =
                                              Colors.blue.shade100;
                                          if (colorMap.containsKey(
                                              formattedStartTime)) {
                                            slotColor =
                                                colorMap[formattedStartTime]!;
                                          }

                                          return Opacity(
                                            opacity: isPast ? 0.5 : 1.0,
                                            child: GestureDetector(
                                              onTap: isPast ||
                                                      slotColor ==
                                                          Colors.green ||
                                                      slotColor == Colors.red
                                                  ? null // Geçmiş saatler, kullanıcı tarafından alınmış ve başkaları tarafından alınmış saatler için tıklamayı devre dışı bırak
                                                  : () {
                                                      // Saat dilimi seçimini işleme
                                                      provider.selectTimeSlot(
                                                          timeSlot, serviceId);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              '$formattedStartTime - $formattedEndTime saatleri arasında randevu alındı.'),
                                                        ),
                                                      );
                                                    },
                                              child: Chip(
                                                label: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      '$formattedStartTime - $formattedEndTime',
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    // Ekstra göstergeler eklemek isterseniz burada yapabilirsiniz
                                                  ],
                                                ),
                                                backgroundColor: slotColor,
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : const Text(
                                        'Bu hizmet için uygun saat dilimi bulunmamaktadır.',
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
}
