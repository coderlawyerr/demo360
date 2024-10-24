// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class AppoinmentService {
//   final String baseUrl = 'https://demo.gecis360.com/api/randevu/olustur/index.php';




//   // 1. Tesisleri API'den Çekme
//   Future<void> fetchFacilities() async {
//     // setState(() {
//     //   isLoading = true; // Yükleniyor durumunu aktif et
//     // });

//     try {
//       final response = await http.post(
//         Uri.parse('https://demo.gecis360.com/api/randevu/olustur/index.php'),
//         headers: {
//           'Content-Type': 'application/x-www-form-urlencoded',
//           'Accept-CharSet': 'utf-8'
//         },
//         body: {
//           'tesislergetir': '1',
//           'token': '71joQRTKKC5R86NccWJzClvNFuAj07w03rB'
//         },
//       );

//       print('HTTP Status Code: ${response.statusCode}');
//       print('HTTP Response Body: ${response.body}');

//       if (response.statusCode == 200) {
//         if (response.body.isEmpty) {
//           throw Exception('API boş yanıt döndü.');
//         }

//         final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
//         debugPrint('Gelen JSON: $jsonResponse');

//         if (jsonResponse is List) {
//           setState(() {
//             tesisler =
//                 jsonResponse.map((item) => Facility.fromJson(item)).toList();
//           });
//         } else {
//           print('API yanıtı beklenen formatta değil: $jsonResponse');
//           throw Exception('Beklenen formatta veri gelmedi.');
//         }
//       } else {
//         print('Veri çekilemedi. HTTP Durum Kodu: ${response.statusCode}');
//         throw Exception('Veri çekilemedi. Lütfen tekrar deneyin.');
//       }
//     } catch (e) {
//       debugPrint('Tesisleri alırken hata oluştu: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Tesisleri alırken hata oluştu: $e')),
//       );
//     } finally {
//       setState(() {
//         isLoading = false; // Yükleniyor durumunu pasif et
//       });
//     }
//   }




//   // Login fonksiyonu
//   Future<http.Response> login(String email, String password) async {
//     final String url = '$baseUrl';

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: <String, String>{
//           'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
//         },
//         body: {
//           'kullaniciadi': email,
//           'sifre': password,
//           'token': "71joQRTKKC5R86NccWJzClvNFuAj07w03rB",
//         },
//       );

//       return response;
//     } catch (e) {
//       throw Exception('Login işlemi sırasında hata oluştu: $e');
//     }
//   }
// }
