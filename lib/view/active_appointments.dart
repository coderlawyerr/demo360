// import 'package:armiyaapp/widget/appointmentcard.dart';
// import 'package:flutter/material.dart';

// class ActiveAppointment extends StatefulWidget {
//   const ActiveAppointment({super.key});

//   @override
//   State<ActiveAppointment> createState() => _ActiveAppointmentState();
// }

// class _ActiveAppointmentState extends State<ActiveAppointment> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start, // Sola yaslama
//             children: [
//               const Row(
//                 mainAxisAlignment:
//                     MainAxisAlignment.start, // Sol tarafa yaslama
//               ),
//               const Text(
//                 "Randevularınızı, randevu gününü başlangıç saatinden  en geç  60 dakika öncesine  kadar iptal edebilirsiniz",
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.normal,
//                     color: Colors.grey),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               AppointmentCard(
//                 buttonText: "RANDEVU AL",
//                 title: 'Galata Spor Ve Eğlence Merkezi',
//                 subtitle: 'Fitness Salonu',
//                 date: '12.10.2025',
//                 time: '15:30',
//                 onButtonPressed: () {},
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               AppointmentCard(
//                 buttonText: "RANDEVU AL",
//                 title: 'Galata Spor Ve Eğlence Merkezi',
//                 subtitle: 'Fitness Salonu',
//                 date: '12.10.2025',
//                 time: '15:30',
//                 onButtonPressed: () {},
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               AppointmentCard(
//                 buttonText: "RANDEVU AL",
//                 title: 'Galata Spor Ve Eğlence Merkezi',
//                 subtitle: 'Fitness Salonu',
//                 date: '12.10.2025',
//                 time: '15:30',
//                 onButtonPressed: () {},
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:armiyaapp/data/app_shared_preference.dart';
import 'package:armiyaapp/model/usermodel.dart';
import 'package:armiyaapp/view/appoinment/appointment_calender/model/randevu_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:armiyaapp/providers/appoinment/appoinment_provider.dart';
import 'package:armiyaapp/widget/appointmentcard.dart';
import 'package:http/http.dart' as http;

class ActiveAppointment extends StatefulWidget {
  const ActiveAppointment({super.key});

  @override
  State<ActiveAppointment> createState() => _ActiveAppointmentState();
}

class _ActiveAppointmentState extends State<ActiveAppointment> {
  UserModel? myusermodel;
  late final Future<List<RandevuModel>?> fetchRandevuList4;

  List<RandevuModel>? aktifrandevular;
  getUser() async {
    myusermodel = await SharedDataService().getLoginData();
  }

  /////
  Future<List<RandevuModel>?> fetchRandevuList() async {
    await getUser();
    const url = 'https://demo.gecis360.com/api/randevu/olustur/index.php';
    const headers = {
      'Authorization': 'Basic cm9vdEBnZWNpczM2MC5jb206MTIzNDEyMzQ=',
      'PHPSESSID': '0ms1fk84dssk9s3mtfmmdsjq24',
    };
    final body = {'token': '71joQRTKKC5R86NccWJzClvNFuAj07w03rB', 'aktifrandevular': '1', 'kullanici_id': '1'};

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);
      print(response.toString());
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        aktifrandevular = jsonData.map((item) => RandevuModel.fromJson(item)).toList();
        return aktifrandevular;
      } else {}
    } catch (e) {
      throw Exception('İstek sırasında hata oluştu: $e');
    }
  }

  @override
  void initState() {
    fetchRandevuList4 = fetchRandevuList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Randevularınızı, randevu gününü başlangıç saatinden en geç 60 dakika öncesine kadar iptal edebilirsiniz",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey),
              ),
              SizedBox(height: 20),

              ///  Text(myusermodel?.isimsoyisim.toString() ?? "isim yok"),
              // Text(myusermodel?.kullanicibilgisi?.id.toString() ?? "isim yok"),
              FutureBuilder<List<RandevuModel>?>(
                future: fetchRandevuList4,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Hata: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return SizedBox(
                      height: 300,
                      width: 400,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final appointment = data[index];
                          return AppointmentCard(
                            buttonText: "RANDEVU AL",
                            title: appointment?.hizmetId.toString() ?? "",
                            subtitle: appointment?.kullaniciadi.toString() ?? "",
                            date: appointment?.timestamp?.split(" ").first.toString() ?? "",
                            time: appointment?.baslangicTarihi?.split(" ").last.toString() ?? "",
                            onButtonPressed: () {
                              // Randevuya tıklama işlemi
                            },
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(child: Text('Randevu bulunamadı.'));
                  }
                },
              ),

              // Randevu kartlarını listele
            ],
          ),
        ),
      ),
    );
  }
}
