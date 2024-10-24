// import 'dart:convert'; // JSON işlemleri için
// import 'package:armiyaapp/model/new_model/newmodel.dart';
// import 'package:http/http.dart' as http;

// Future<List<Randevu>> getUserAppointments(int userId) async {
  


//   try {
//     final response = await http.post(
//      Uri.parse('https://demo.gecis360.com/api/randevu/olustur/index.php'),
//        headers: {
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//           body: {
//           'tesissecim': facilityId.toString(),
//           'token': _token,
//         },
//     );

//     if (response.statusCode == 200) {
//       // API'den gelen cevabı parse et
//       final List<dynamic> appointmentData = jsonDecode(response.body);

//       // Gelen veriyi Randevu modeline dönüştür
//       return appointmentData.map((data) {
//         return Randevu.fromMap(data);
//       }).toList();
//     } else {
//       print(
//           'Failed to fetch appointments. Status code: ${response.statusCode}');
//       return [];
//     }
//   } catch (e) {
//     print('Error fetching appointments: $e');
//     return [];
//   }
// }


