// import 'package:armiyaapp/const/const.dart';
// import 'package:armiyaapp/const/const.dart';
// import 'package:armiyaapp/const/const.dart';
// import 'package:armiyaapp/model/new_model/newmodel.dart';
// import 'package:armiyaapp/providers/appoinment/appoinment_provider.dart';
// import 'package:armiyaapp/widget/misafir_add.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
// import 'package:multi_dropdown/multi_dropdown.dart';

// class AppointmentView extends StatefulWidget {
//   const AppointmentView({super.key});

//   @override
//   State createState() => _AppointmentViewState();
// }

// class _AppointmentViewState extends State<AppointmentView> {
//   @override
//   void initState() {
//     super.initState();
//     // Widget ilk oluşturulduğunda tesisleri çek
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final provider = Provider.of<AppointmentProvider>(context, listen: false);
//       provider.fetchFacilities().catchError((error) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Tesisler alınamadı: $error')),
//         );
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Consumer<AppointmentProvider>(
//           builder: (context, provider, child) {
//             if (provider.isLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             return SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 80),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'RANDEVU OLUŞTUR',
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.normal,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     const Text(
//                       'Tesis Seçimi',
//                       style: TextStyle(fontSize: 16, color: Colors.grey),
//                     ),
//                     const SizedBox(height: 10),
//                     // 1. Tesis Seçimi Dropdown
//                     Container(
//                       margin: const EdgeInsets.all(3),
//                       padding: const EdgeInsets.all(3),
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey),
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(4))),
//                       child: DropdownButton<int>(
//                         underline: const SizedBox(),
//                         hint: const Text(
//                           'Tesis Seçiniz',
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                         value: provider.selectedFacilityId,
//                         isExpanded: true,
//                         items: provider.facilities.map((facility) {
//                           return DropdownMenuItem<int>(
//                             value: facility.tesisId,
//                             child: Text(facility.tesisAd ?? 'Bilinmeyen Tesis'),
//                           );
//                         }).toList(),
//                         onChanged: (value) async {
//                           provider.setSelectedDate(null);
//                           provider.calendarController.selectedDate = null;
//                           provider.setSelectedServices([]);

//                           if (value != null) {
//                             provider.setSelectedFacility(value);
//                             try {
//                               await provider.fetchServices(value);
//                               // Hizmetler yüklendiğinde takvimi yeniden göster

//                               provider.resetToCalendar(); // Takvimi sıfırla
//                             } catch (e) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(
//                                     'Hizmetleri alırken hata oluştu: $e',
//                                     style: TextStyle(color: primaryColor),
//                                   ),
//                                 ),
//                               );
//                             }
//                           }
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     // 2. Hizmet Seçimi (MultiDropdown)
//                     const Text(
//                       "Hizmet Seçimi",
//                       style: TextStyle(fontSize: 16, color: Colors.grey),
//                     ),

//                     MultiDropdown(
//                       items: provider.services.map((service) {
//                         return DropdownItem<int>(
//                           value: service.hizmetId!,
//                           label: service.hizmetAd ?? 'Bilinmeyen Hizmet',
//                         );
//                       }).toList(),
//                       onSelectionChange: (List<int> selectedIds) async {
//                         provider.resetToCalendar();
//                         provider.setSelectedServices(selectedIds);
//                       },
//                       selectedItemBuilder: (selectedItems) {
//                         // Seçilen hizmetlerin nasıl görüneceğini burada özelleştirebilirsiniz
//                         return Wrap(spacing: 8.0, children: [
//                           Chip(
//                             padding: EdgeInsets.zero,
//                             label: Text(selectedItems.label),
//                             onDeleted: () {
//                               // Chip silindiğinde hizmeti seçili listeden çıkar
//                               final id = selectedItems.value;
//                               final updatedIds =
//                                   List<int>.from(provider.selectedServiceIds);
//                               updatedIds.remove(id);
//                               provider.resetToCalendar();
//                               // provider.setSelectedServices(updatedIds);
//                             },
//                           )
//                         ]);
//                       },
//                     ),

//                     const SizedBox(height: 20),
//                     // Takvim
//                     Visibility(
//                       visible: provider.showCalendar,
//                       child: Column(
//                         children: [
//                           // Takvim Kontrolleri
//                           Row(
//                             children: [
//                               IconButton(
//                                 onPressed: () {
//                                   provider.calendarController.backward!();
//                                 },
//                                 icon: const Icon(Icons.arrow_back_ios_new),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   provider.calendarController.forward!();
//                                 },
//                                 icon: const Icon(Icons.arrow_forward_ios_sharp),
//                               ),
//                               ElevatedButton(
//                                 onPressed: () {
//                                   provider.calendarController.displayDate =
//                                       DateTime.now();
//                                 },
//                                 child: const Text('Bugün'),
//                               ),
//                             ],
//                           ),
//                           // Takvim
//                           provider.buildCalendar(context),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     // Saat Dilimleri
//                     Visibility(
//                       visible: provider.showTimeSlots &&
//                           provider.serviceTimeSlots.isNotEmpty,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Randevu Saati Seçimi',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           const Text(
//                             'Mavi : Randevu eklenebilir',
//                             style: TextStyle(color: Colors.blue),
//                           ),
//                           const SizedBox(
//                             height: 2,
//                           ),
//                           const Text(
//                             'Kırmızı : Kapasite dolu',
//                             style: TextStyle(color: Colors.red),
//                           ),
//                           const SizedBox(
//                             height: 2,
//                           ),
//                           const Text(
//                             'Yeşil: Kayıtlı randevunuz',
//                             style: TextStyle(color: Colors.green),
//                           ),
//                           const SizedBox(
//                             height: 2,
//                           ),
//                           const Text(
//                             'Sarı: Aynı saatte randevunuz var',
//                             style: TextStyle(color: Colors.yellow),
//                           ),
//                           const SizedBox(height: 10),
//                           Align(
//                             alignment: Alignment.topRight,
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 provider.resetToCalendar();
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(
//                                     0xFF5664D9), // Butonun arka plan rengi
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(
//                                     8, // Buradaki değeri köşe keskinliğine göre ayarlayabilirsiniz
//                                   ),
//                                 ),
//                               ),
//                               child: const Text(
//                                 'Takvime Dön',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ),

//                           // Saat Dilimlerini Listele (Her Hizmet için)
//                           ListView.builder(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount: provider.selectedServices.length,
//                             itemBuilder: (context, serviceIndex) {
//                               final service =
//                                   provider.selectedServices[serviceIndex];
//                               final serviceId = service.hizmetId!;
//                               final serviceSlots =
//                                   provider.serviceTimeSlots[serviceId] ??
//                                       []; // saat aralıkları apıden geliyor

//                               // Renk haritasını al
//                               final colorMap = provider.kontrolEt(serviceId);

//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // Hizmet Adı ve Kapasite Bilgisi
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                       vertical: 10,
//                                     ),
//                                     child: Text(
//                                       '${service.hizmetAd ?? 'Hizmet'} - Kapasite: ${service.saatlikKapasite ?? 'Bilinmiyor'}',
//                                       style: const TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.normal,
//                                       ),
//                                     ),
//                                   ),
//                                   // Saat Dilimleri
//                                   serviceSlots.isNotEmpty
//                                       ? GridView.builder(
//                                           shrinkWrap: true,
//                                           physics:
//                                               const NeverScrollableScrollPhysics(),
//                                           padding: const EdgeInsets.all(8.0),
//                                           gridDelegate:
//                                               const SliverGridDelegateWithMaxCrossAxisExtent(
//                                             maxCrossAxisExtent:
//                                                 150.0, // Adjusted width
//                                             mainAxisSpacing: 8.0,
//                                             crossAxisSpacing: 8.0,
//                                             childAspectRatio: 3 / 1,
//                                           ),
//                                           itemCount: serviceSlots.length,
//                                           itemBuilder: (context, slotIndex) {
//                                             final timeSlot =
//                                                 serviceSlots[slotIndex];
//                                             final periyot = provider
//                                                 .servicePeriyots[serviceId]!;
//                                             final bitisSaati = timeSlot.add(
//                                                 Duration(minutes: periyot));
//                                             final formattedStartTime =
//                                                 DateFormat('HH:mm')
//                                                     .format(timeSlot);
//                                             final formattedEndTime =
//                                                 DateFormat('HH:mm')
//                                                     .format(bitisSaati);

//                                             // Geçmiş saat dilimlerini kontrol et
//                                             bool isPast = timeSlot
//                                                 .isBefore(DateTime.now());

//                                             // Renk haritasına göre rengi belirle
//                                             Color slotColor =
//                                                 Colors.blue.shade100;
//                                             if (colorMap.containsKey(
//                                                 formattedStartTime)) {
//                                               slotColor =
//                                                   colorMap[formattedStartTime]!;
//                                             }

//                                             return Opacity(
//                                               opacity: isPast ? 0.5 : 1.0,
//                                               child: GestureDetector(
//                                                 ///////////////
//                                                 onTap: isPast ||
//                                                         slotColor ==
//                                                             Colors.green ||
//                                                         slotColor == Colors.red
//                                                     ? null // Geçmiş saatler, kullanıcı tarafından alınmış ve başkaları tarafından alınmış saatler için tıklamayı devre dışı bırak
//                                                     : () {
//                                                         // Saat dilimi seçimini işleme
//                                                         provider.selectTimeSlot(
//                                                             timeSlot,
//                                                             serviceId);

//                                                         ////////////////////////////////////////////////dıalog acccc
//                                                         showAppointmentDialog(
//                                                             context,
//                                                             timeSlot,
//                                                             service);
//                                                         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                       },
//                                                 child: Chip(
//                                                   label: Row(
//                                                     mainAxisSize:
//                                                         MainAxisSize.min,
//                                                     children: [
//                                                       Text(
//                                                         '$formattedStartTime - $formattedEndTime',
//                                                         style: const TextStyle(
//                                                           color: Colors.black,
//                                                           fontSize: 12,
//                                                         ),
//                                                       ),
//                                                       // Ekstra göstergeler eklemek isterseniz burada yapabilirsiniz
//                                                     ],
//                                                   ),
//                                                   backgroundColor: slotColor,
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         )
//                                       : const Text(
//                                           'Bu hizmet için uygun saat dilimi bulunmamaktadır.',
//                                           style: TextStyle(color: Colors.red),
//                                         ),

//                                   const SizedBox(height: 20),
//                                 ],
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   void showAppointmentDialog(
//       BuildContext context, DateTime selectedTime, Bilgi service) {
//     final provider = Provider.of<AppointmentProvider>(context, listen: false);
//     bool isConfirmed = false; // Randevunun onaylandığını izlemek için

//     String selectedFacility = provider.selectedFacilityId != null
//         ? provider.facilities
//                 .firstWhere((f) => f.tesisId == provider.selectedFacilityId)
//                 .tesisAd ??
//             'Bilinmeyen Tesis'
//         : 'Tesis Seçilmedi';

//     String selectedService = provider.selectedServiceIds.isNotEmpty
//         ? provider.selectedServices.map((s) => s.hizmetAd).join(', ')
//         : 'Hizmet Seçilmedi';

//     // Misafir kabul durumu kontrolü
//     bool isMisafirKabul = service.misafirKabul == 1;

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               title: const Text('Randevu Onayı'),
//               backgroundColor: isConfirmed
//                   ? Colors.green.shade100
//                   : null, // Onaylandıysa yeşil arka plan
//               content: Column(
//                 crossAxisAlignment: CrossAxisAlignment
//                     .start, // Yazıların sola yaslı olmasını sağlar
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Seçilen Tesis:$selectedFacility',
//                   ),
//                   SizedBox(height: 5),
//                   Text('Seçilen Hizmet: $selectedService'),
//                   SizedBox(height: 5),
//                   Text(
//                       'Seçilen Zaman: ${DateFormat('HH:mm').format(selectedTime)}'),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   if (isMisafirKabul) // Misafir kabul durumu kontrolü
//                     Center(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.of(context).pop(); // Diyaloğu kapat
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => MisafirAdd(),
//                             ),
//                           ); // Misafir ekleme sayfasını aç
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xFF5664D9), // Arka plan rengi
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 5, vertical: 5), // Butonun kalınlığı
//                           shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.circular(8), // Oval şekli azaltır
//                           ),
//                         ),
//                         child: Text(
//                           'Misafir Ekle',
//                           style: TextStyle(
//                             color: Colors.white, // Yazı rengi
//                             fontWeight: FontWeight.normal, // Yazı kalınlığı
//                             fontSize: 15, // Yazı boyutu
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     // Randevu onaylandı
//                     setState(() {
//                       isConfirmed = true; // Onay durumu güncellendi
//                     });
//                     Future.delayed(Duration(seconds: 1), () {
//                       Navigator.of(context).pop(); // Bir süre sonra kapat
//                     });
//                   },
//                   child: Text(
//                     'Onayla',
//                     style: TextStyle(color: Color(0xFF5664D9)),
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context)
//                         .pop(); // İptal butonuna basıldığında sadece kapat
//                   },
//                   child: Text(
//                     'İptal',
//                     style: TextStyle(color: Color(0xFF5664D9)),
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }

///////////////////////////////////////////////////////
import 'package:armiyaapp/const/const.dart';
import 'package:armiyaapp/model/new_model/newmodel.dart';
import 'package:armiyaapp/providers/appoinment/appoinment_provider.dart';
import 'package:armiyaapp/providers/appoinment/misafir_add_provider.dart';
import 'package:armiyaapp/widget/misafir_add.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<AppointmentProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'RANDEVU OLUŞTUR',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Tesis Seçimi',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    // 1. Tesis Seçimi Dropdown
                    Container(
                      margin: const EdgeInsets.all(3),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: const BorderRadius.all(Radius.circular(4))),
                      child: DropdownButton<int>(
                        underline: const SizedBox(),
                        hint: const Text(
                          'Tesis Seçiniz',
                          style: TextStyle(color: Colors.grey),
                        ),
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
                                  content: Text(
                                    'Hizmetleri alırken hata oluştu: $e',
                                    style: TextStyle(color: primaryColor),
                                  ),
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
                      style: TextStyle(fontSize: 16, color: Colors.grey),
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
                              final updatedIds = List<int>.from(provider.selectedServiceIds);
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
                                  provider.calendarController.displayDate = DateTime.now();
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
                      visible: provider.showTimeSlots && provider.serviceTimeSlots.isNotEmpty,
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
                          const SizedBox(
                            height: 2,
                          ),
                          const Text(
                            'Kırmızı : Kapasite dolu',
                            style: TextStyle(color: Colors.red),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          const Text(
                            'Yeşil: Kayıtlı randevunuz',
                            style: TextStyle(color: Colors.green),
                          ),
                          const SizedBox(
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
                                backgroundColor: const Color(0xFF5664D9), // Butonun arka plan rengi
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

                          // Saat Dilimlerini Listele (Her Hizmet için)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: provider.selectedServices.length,
                            itemBuilder: (context, serviceIndex) {
                              final service = provider.selectedServices[serviceIndex];
                              final serviceId = service.hizmetId!;
                              final serviceSlots = provider.serviceTimeSlots[serviceId] ?? []; // saat aralıkları apıden geliyor

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
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  // Saat Dilimleri
                                  serviceSlots.isNotEmpty
                                      ? GridView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          padding: const EdgeInsets.all(8.0),
                                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 150.0, // Adjusted width
                                            mainAxisSpacing: 8.0,
                                            crossAxisSpacing: 8.0,
                                            childAspectRatio: 3 / 1,
                                          ),
                                          itemCount: serviceSlots.length,
                                          itemBuilder: (context, slotIndex) {
                                            final timeSlot = serviceSlots[slotIndex];
                                            final periyot = provider.servicePeriyots[serviceId]!;
                                            final bitisSaati = timeSlot.add(Duration(minutes: periyot));
                                            final formattedStartTime = DateFormat('HH:mm').format(timeSlot);
                                            final formattedEndTime = DateFormat('HH:mm').format(bitisSaati);

                                            // Geçmiş saat dilimlerini kontrol et
                                            bool isPast = timeSlot.isBefore(DateTime.now());

                                            // Renk haritasına göre rengi belirle
                                            // Renk haritasına göre rengi belirle
                                            final slotColor = provider.slotColors[formattedStartTime] ?? Colors.blue.shade100;

                                            return Opacity(
                                              opacity: isPast ? 0.5 : 1.0,
                                              child: GestureDetector(
                                                ///////////////
                                                onTap: isPast || slotColor == Colors.green || slotColor == Colors.red
                                                    ? null // Geçmiş saatler, kullanıcı tarafından alınmış ve başkaları tarafından alınmış saatler için tıklamayı devre dışı bırak
                                                    : () {
                                                        // Saat dilimi seçimini işleme
                                                        provider.selectTimeSlot(timeSlot, serviceId);

                                                        ////////////////////////////////////////////////dıalog acccc
                                                        showAppointmentDialog(context, timeSlot, service, serviceIndex, slotIndex);
                                                        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                      },
                                                child: Chip(
                                                  label: Row(
                                                    mainAxisSize: MainAxisSize.min,
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
              ),
            );
          },
        ),
      ),
    );
  }

  void showAppointmentDialog(BuildContext context, DateTime selectedTime, Bilgi service, int serviceIndex, int slotIndex) {
    final provider = Provider.of<AppointmentProvider>(context, listen: false);
    bool isConfirmed = false; // Randevunun onaylandığını izlemek için

    // Seçilen tesis ve hizmet bilgilerini al
    String selectedFacility = provider.selectedFacilityId != null
        ? provider.facilities.firstWhere((f) => f.tesisId == provider.selectedFacilityId).tesisAd ?? 'Bilinmeyen Tesis'
        : 'Tesis Seçilmedi';

    String selectedService = provider.selectedServiceIds.isNotEmpty ? provider.selectedServices.map((s) => s.hizmetAd).join(', ') : 'Hizmet Seçilmedi';

    // Misafir kabul durumu kontrolü
    bool isMisafirKabul = service.misafirKabul == 1;
  
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Bu, modalın tam ekran olmasını sağlar.
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Randevu Onayı',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Container(
                      color: isConfirmed ? Colors.green.shade100 : null,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Seçilen Tesis: $selectedFacility'),
                          SizedBox(height: 5),
                          Text('Seçilen Hizmet: $selectedService'),
                          SizedBox(height: 5),
                          Text('Seçilen Zaman: ${DateFormat('HH:mm').format(selectedTime)}'),
                          SizedBox(
                            height: 5,
                          ),
                          Consumer<MisafirAddProvider>(
                            builder: (context, value, error) {
                              return Visibility(
                                visible: value.misafirList.isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Misafirler'),
                                    Divider(),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxHeight: MediaQuery.of(context).size.height * 0.5, // Maksimum yüksekliği belirler
                                      ),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(), // Render hatalarını önler
                                        itemCount: value.misafirList.length,
                                        itemBuilder: (context, index) {
                                          final misafir = value.misafirList[index];
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                                            child: Text('Ad Soyad: ${misafir['adSoyad'] ?? 'Bilinmiyor'}'),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 30),
                          if (isMisafirKabul)
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                    ),
                                    builder: (context) {
                                      return FractionallySizedBox(
                                        heightFactor: 0.90, // Yüksekliğin 4/3 oranında açılması için
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context).viewInsets.bottom,
                                          ),
                                          child: MisafirAdd(), // MisafirAdd sayfası burada modal olarak açılır
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF5664D9),
                                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Misafir Ekle',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            ////////////////////////// grup randevusuuu
                          
                        
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            if (context.read<MisafirAddProvider>().misafirList.isEmpty) {
                              provider.updateSlotColor(serviceIndex, slotIndex, Colors.green);
                            } else {
                              provider.updateSlotColor(serviceIndex, slotIndex, Colors.yellow);
                            }
                            setState(() {
                              isConfirmed = true;
                            });
                            context.read<MisafirAddProvider>().clearMisafirList();
                            Future.delayed(Duration(seconds: 1), () {
                              Navigator.of(context).pop();
                            });
                          },
                          child: Text(
                            'Onayla',
                            style: TextStyle(color: Color(0xFF5664D9)),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'İptal',
                            style: TextStyle(color: Color(0xFF5664D9)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
