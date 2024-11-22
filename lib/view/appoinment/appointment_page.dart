// // appointment_view.dart

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import 'package:multi_dropdown/multi_dropdown.dart';
// import 'package:provider/provider.dart';

// import '../../providers/appoinment/appoinment_provider.dart';
// import 'appointment_calender/appointment_calender_service.dart';
// import 'appointment_calender/appointment_calender_widget.dart';
// import 'appointment_calender/model/calender_model.dart';
// import 'appointment_calender/model/facility_model.dart';

// class AppointmentPage extends StatefulWidget {
//   const AppointmentPage({super.key});

//   @override
//   State createState() => _AppointmentPageState();
// }

// class _AppointmentPageState extends State<AppointmentPage> {
//   List<FacilitySelectModel>? facilityModel;
//   CalendarInfoModel? calendarInfoModel = CalendarInfoModel();
//   Map<int, List<DateTime>> serviceTimeSlots = {};

//   ValueNotifier<List<Hizmetler>?> hizmetListesi = ValueNotifier([]);
//   List<Hizmetler>? seciliHizmetList = [];
//   int? selectedFacilityId;
//   int? selectedServiceId;
//   List<int> selectedServiceIds = [];
//   DateTime selectedDate = DateTime.now();

//   bool isLoading = true;
//   @override
//   void initState() {
//     super.initState();
//     _fetchFacilities();
//   }

//   Future _fetchFacilities() async {
//     try {
//       setState(() {
//         isLoading = true;
//       });
//       facilityModel =
//           await AppointmentService().fetchFacilities().whenComplete(() {
//         setState(() {});
//       });
//       await fetchHizmetModel();
//       setState(() {
//         isLoading = false;
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Tesisler alınamadı: $e'),
//         ),
//       );
//     }
//   }

//   Future fetchHizmetModel() async {
//     try {
//       hizmetListesi?.value = await AppointmentService()
//           .fetchServices(
//         selectedServiceId ?? facilityModel?.first.tesisId ?? 0,
//       )
//           .whenComplete(() {
//         setState(() {});
//         log('fetchHizmetModel Hizmetler yüklendi: $hizmetListesi');
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Tesisler alınamadı: $e'),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Randevu Oluştur'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Randevu Oluştur',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 15),
//               const Text(
//                 'Tesis Seçimi',
//                 style: TextStyle(fontSize: 16),
//               ),
//               const SizedBox(height: 10),
//               // 1. Tesis Seçimi Dropdown
//               Container(
//                 margin: const EdgeInsets.all(4),
//                 padding: const EdgeInsets.all(4),
//                 decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: const BorderRadius.all(Radius.circular(12))),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton<int>(
//                     hint: const Text('Tesis Seçiniz'),
//                     value: selectedServiceId,
//                     isExpanded: true,
//                     items: facilityModel?.map((facility) {
//                       return DropdownMenuItem<int>(
//                         onTap: () {
//                           selectedFacilityId = facility.tesisId;
//                           fetchHizmetModel();
//                         },
//                         value: facility.tesisId ?? 0,
//                         child: Text(facility.tesisAd ?? 'Bilinmeyen Tesis'),
//                       );
//                     }).toList(),
//                     onChanged: (value) async {
//                       setState(() {
//                         selectedServiceId = value;
//                         selectedFacilityId = value;
//                       });
//                     },
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),
//               // 2. Hizmet Seçimi (MultiDropdown)
//               const Text(
//                 "Hizmet Seçimi",
//                 style: TextStyle(fontSize: 16),
//               ),

//               ValueListenableBuilder(
//                   valueListenable: hizmetListesi,
//                   builder: (context, liste, child) {
//                     if (isLoading) {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//                     return MultiDropdown<int>(
//                       controller: MultiSelectController(),
//                       items: liste?.map((service) {
//                             return DropdownItem<int>(
//                               value: service.hizmetId ?? 0,
//                               label: service.hizmetAd ?? 'Bilinmeyen Hizmet',
//                             );
//                           }).toList() ??
//                           [],
//                       onSelectionChange: (selectedIds) async {
//                         selectedServiceIds = selectedIds;

//                         // provider.resetToCalendar();
//                         // provider.setSelectedServices(selectedIds);
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

//                               selectedServiceIds.remove(id);

//                               // provider.setSelectedServices(updatedIds);
//                             },
//                           )
//                         ]);
//                       },
//                     );
//                   }),

//               const SizedBox(height: 20),

//               // Takvim
//               if (facilityModel != null && selectedServiceIds.isNotEmpty)
//                 AppointmentCalenderWidget(
//                   onDateSelected: (DateTime date) async {
//                     selectedDate = date;
//                     calendarInfoModel =
//                         await AppointmentService().fetchServiceDetails(
//                       selectedFacilityId: selectedFacilityId ?? 0,
//                       selectedServiceIds: selectedServiceIds,
//                     );

//                     final list = hizmetListesi.value
//                         ?.where((s) => selectedServiceIds.contains(s.hizmetId))
//                         .toList();
//                     seciliHizmetList = list;
//                     setState(() {});
//                   },
//                 ),
//               const SizedBox(height: 20),
//               // Saat Dilimleri
//               Visibility(
//                 visible: calendarInfoModel?.randevu != null,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Randevu Saati Seçimi',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     const Text(
//                       'Mavi Randevu eklenebilir',
//                       style: TextStyle(color: Colors.blue),
//                     ),
//                     const SizedBox(height: 10),

//                     const Text(
//                       'Hizmet Adı',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     const SizedBox(height: 10),

//                     // Wrap(
//                     //   spacing: 8.0,
//                     //   children: provider.selectedServices.map((service) {
//                     //     return Chip(
//                     //       label: Text(
//                     //         '${service.hizmetAd ?? 'Hizmet'} - Kapasite: ${service.saatlikKapasite ?? 'Bilinmiyor'}',
//                     //       ),
//                     //     );
//                     //   }).toList(),
//                     // ),
//                     const SizedBox(height: 10),
//                     // Saat Dilimlerini Listele (Her Hizmet için)
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: seciliHizmetList?.length ?? 0,
//                       itemBuilder: (context, serviceIndex) {
//                         final service = seciliHizmetList?[serviceIndex];
//                         final serviceId = service?.hizmetId!;
//                         final serviceSlots =
//                             Provider.of<AppointmentProvider>(context)
//                                 .generateTimeSlots();

//                         // Renk haritasını al
//                         final colorMap = AppointmentService().kontrolEt(
//                           existingAppointments:
//                               calendarInfoModel?.randevu ?? [],
//                           currentUserId: 0,
//                           selectedDate: selectedDate,
//                           selectedServiceIds: selectedServiceIds,
//                           serviceTimeSlots: serviceTimeSlots,
//                           randevuList: calendarInfoModel?.randevu ?? [],
//                           hizmetId:
//                               seciliHizmetList?[serviceIndex].hizmetId ?? 0,
//                           selectedServices: seciliHizmetList
//                                   ?.map((e) => Bilgi(
//                                         hizmetId: e.hizmetId,
//                                         hizmetAd: e.hizmetAd,
//                                         saatlikKapasite: e.saatlikKapasite,
//                                         randevuZamanlayici:
//                                             e.randevuZamanlayici,
//                                       ))
//                                   .toList() ??
//                               [],

//                           // currentUserId: provider.currentUser?.id ?? 0,
//                         );

//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Hizmet Adı ve Kapasite Bilgisi
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: 10,
//                               ),
//                               child: Text(
//                                 '${service?.hizmetAd ?? 'Hizmet'} - Kapasite: ${service?.saatlikKapasite ?? 'Bilinmiyor'}',
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             // Saat Dilimleri
//                             serviceSlots.isNotEmpty
//                                 ? GridView.builder(
//                                     shrinkWrap: true,
//                                     physics:
//                                         const NeverScrollableScrollPhysics(),
//                                     padding: const EdgeInsets.all(8.0),
//                                     gridDelegate:
//                                         const SliverGridDelegateWithMaxCrossAxisExtent(
//                                       maxCrossAxisExtent:
//                                           150.0, // Adjusted width
//                                       mainAxisSpacing: 8.0,
//                                       crossAxisSpacing: 8.0,
//                                       childAspectRatio: 3 / 1,
//                                     ),
//                                     itemCount: serviceSlots.length,
//                                     itemBuilder: (context, slotIndex) {
//                                       final timeSlot = serviceSlots[slotIndex];
//                                       final periyot =
//                                           Provider.of<AppointmentProvider>(
//                                                   context)
//                                               .servicePeriyots[serviceId]!;
//                                       final bitisSaati = timeSlot?.add(DateTime(
//                                           0, 0, 0, periyot, 0, 0, 0, 0));
//                                       final formattedStartTime =
//                                           DateFormat('HH:mm').format(
//                                               timeSlot?.first ??
//                                                   DateTime.now());

//                                       // Geçmiş saat dilimlerini kontrol et
//                                       bool isPast = false;

//                                       // Renk haritasına göre rengi belirle
//                                       Color slotColor = Colors.blue.shade100;
//                                       if (colorMap
//                                           .containsKey(formattedStartTime)) {
//                                         slotColor =
//                                             colorMap[formattedStartTime]!;
//                                       }

//                                       return Opacity(
//                                         opacity: isPast ? 0.5 : 1.0,
//                                         child: GestureDetector(
//                                           onTap: isPast ||
//                                                   slotColor == Colors.green ||
//                                                   slotColor == Colors.red
//                                               ? null // Geçmiş saatler, kullanıcı tarafından alınmış ve başkaları tarafından alınmış saatler için tıklamayı devre dışı bırak
//                                               : () {
//                                                   // Saat dilimi seçimini işleme
//                                                   // provider.selectTimeSlot(
//                                                   //     timeSlot, serviceId);
//                                                 },
//                                           child: Chip(
//                                             label: Row(
//                                               mainAxisSize: MainAxisSize.min,
//                                               children: [
//                                                 Text(
//                                                   '$formattedStartTime ',
//                                                   style: const TextStyle(
//                                                     color: Colors.black,
//                                                     fontSize: 12,
//                                                   ),
//                                                 ),
//                                                 // Ekstra göstergeler eklemek isterseniz burada yapabilirsiniz
//                                               ],
//                                             ),
//                                             backgroundColor: slotColor,
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   )
//                                 : const Text(
//                                     'Bu hizmet için uygun saat dilimi bulunmamaktadır.',
//                                     style: TextStyle(color: Colors.red),
//                                   ),

//                             const SizedBox(height: 20),
//                           ],
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
