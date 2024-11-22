// // appointment_service.dart

// import 'dart:convert';
// import 'package:armiyaapp/utils/constants.dart';
// import 'package:http/http.dart' as http;
 
// import 'package:armiyaapp/model/new_model/newmodel.dart';

// import '../view/appoinment/appointment_calender/model/facility_model.dart';

// class AppointmentService {
//   final String _baseUrl = 'https://demo.gecis360.com/api/randevu/olustur/index.php';
//   final String _token = '71joQRTKKC5R86NccWJzClvNFuAj07w03rB';
//   final String _createAppointmentEndpoint = createAppinmentEndPoint; // constants.dart'dan alınıyor

//   // Tesisleri API'den Çekme
//   Future<List<FacilitySelectModel>> fetchFacilities() async {
//     final response = await http.post(
//       Uri.parse(_baseUrl),
//       headers: {
//         'Content-Type': 'application/x-www-form-urlencoded',
//         'Accept-CharSet': 'utf-8'
//       },
//       body: {
//         'tesislergetir': '1',
//         'token': _token,
//       },
//     );
//     if (response.statusCode == 200) {
//       if (response.body.isEmpty) {
//         throw Exception('API boş yanıt döndü.');
//       }

//       final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

//       if (jsonResponse is List) {
//         return jsonResponse.map<FacilitySelectModel>((item) => FacilitySelectModel.fromJson(item)).toList();
//       } else {
//         throw Exception('Beklenen formatta veri gelmedi.');
//       }
//     } else {
//       throw Exception('Veri çekilemedi. Lütfen tekrar deneyin.');
//     }
//   }
//   // Hizmetleri API'den Çekme
//   Future<List<Bilgi>> fetchServices(int facilityId) async {
//     final response = await http.post(
//       Uri.parse('$_baseUrl/$createAppinmentEndPoint'),
//       headers: {
//         'Content-Type': 'application/x-www-form-urlencoded',
//       },
//       body: {
//         'tesissecim': facilityId.toString(),
//         'token': _token,
//       },
//     );
//     if (response.statusCode == 200) {
//       if (response.body.isEmpty) {
//         throw Exception('API boş yanıt döndü.');
//       }
//       final Map<String, dynamic> jsonResponse = json.decode(response.body);
//       if (jsonResponse['hizmetler'] != null && jsonResponse['hizmetler'] is List) {
//         return List<Bilgi>.from(
//           jsonResponse['hizmetler'].map((x) => Bilgi.fromMap(x)),
//         );
//       } else {
//         throw Exception('Hizmetler listesi beklenen formatta değil.');
//       }
//     } else {
//       throw Exception('Hizmetler API isteği başarısız oldu.');
//     }
//   }

//   // Servis Detaylarını API'den Çekme
//   Future<Map<String, dynamic>> fetchServiceDetails({
//     required int selectedFacilityId,
//     required List<int> selectedServiceIds,
//   }) async {
//     final response = await http.post(
//       Uri.parse(_baseUrl),
//       headers: {
//         'Content-Type': 'application/x-www-form-urlencoded',
//       },
//       body: {
//         'tesisid': selectedFacilityId.toString(),
//         'hizmetsecim': selectedServiceIds.join(','), // Virgülle ayrılmış string
//         'token': _token,
//       },
//     );

//     if (response.statusCode == 200) {
//       if (response.body.isEmpty) {
//         throw Exception('API boş yanıt döndü.');
//       }

//       final Map<String, dynamic> jsonResponse = json.decode(response.body);
//       return jsonResponse;
//     } else {
//       throw Exception('Servis detayları getirilemedi.');
//     }
//   }

   


//   ///kalan randevu sayısını apıden cekme
//  Future<int> fetchRemainingAppointments() async {
//   final response = await http.post(
//     Uri.parse('https://demo.gecis360.com/api/randevu/kalan_sayisi.php'),
//     headers: {
//       'Content-Type': 'application/x-www-form-urlencoded',
//       'Accept-CharSet': 'utf-8'
//     },
//     body: {
//       'token': _token, // Token'ınızı burada gönderin.
//     },
//   );
//   if (response.statusCode == 200) {
//     final Map<String, dynamic> jsonResponse = json.decode(response.body);
//     if (jsonResponse.containsKey('kalan_randevu_sayisi')) {
//       return jsonResponse['kalan_randevu_sayisi'];
//     } else {
//       throw Exception('Kalan randevu sayısı bilgisi bulunamadı.');
//     }
//   } else {
//     throw Exception('Kalan randevu sayısı API isteği başarısız oldu. Durum Kodu: ${response.statusCode}');
//   }
// }

// }
