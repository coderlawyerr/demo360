import 'dart:convert';

import 'package:armiyaapp/data/app_shared_preference.dart';
import 'package:armiyaapp/model/deneme.dart';
import 'package:armiyaapp/model/hizmet_bilgisi.dart';
import 'package:armiyaapp/model/kullanici_bilgisi.dart';
import 'package:armiyaapp/model/tesisbilgisi.dart';
import 'package:armiyaapp/model/usermodel.dart';
import 'package:armiyaapp/view/appoinment/appointment_calender/model/randevu_model.dart';
import 'package:flutter/material.dart';

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
  late final Future<List<DenemeCard>?> cardim;
  List<RandevuModel>? aktifrandevular;
  kullanicibilgisi? kullanicibilgim;
  hizmetbilgisi? hizmetbilgim;
  tesisbilgisi? tesisbilgim;
  List<DenemeCard> denemecardim = [];

  getUser() async {
    myusermodel = await SharedDataService().getLoginData();
  }

  Future<void> fetchData() async {
    const url = "https://demo.gecis360.com/randevu/randevularim.php";
    const headers = {
      "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
      "accept-language": "tr-TR,tr;q=0.9,en-US;q=0.8,en;q=0.7",
      "cookie": "PHPSESSID=0ms1fk84dssk9s3mtfmmdsjq24; language=tr",
      "priority": "u=0, i",
      "referer": "https://demo.gecis360.com/randevu/randevularim.php",
      "sec-ch-ua": '"Google Chrome";v="131", "Chromium";v="131", "Not_A Brand";v="24"',
      "sec-ch-ua-mobile": "?0",
      "sec-ch-ua-platform": '"Windows"',
      "sec-fetch-dest": "document",
      "sec-fetch-mode": "navigate",
      "sec-fetch-site": "same-origin",
      "sec-fetch-user": "?1",
      "upgrade-insecure-requests": "1",
      "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        print("Response body: ${response.body}");
      } else {
        print("Failed to load data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

 
  /////
  Future<List<RandevuModel>?> fetchRandevuList() async {
    await getUser();
    const url = 'https://demo.gecis360.com/api/randevu/olustur/index.php';
    const headers = {
      'Authorization': 'Basic cm9vdEBnZWNpczM2MC5jb206MTIzNDEyMzQ=',
      'PHPSESSID': '0ms1fk84dssk9s3mtfmmdsjq24',
    };
    final body = {'token': '71joQRTKKC5R86NccWJzClvNFuAj07w03rB', 'aktifrandevular': '1', 'kullanici_id': "1"};

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        aktifrandevular = jsonData.map((item) => RandevuModel.fromJson(item)).toList();
        return aktifrandevular;
      } else {}
    } catch (e) {
      throw Exception('İstek sırasında hata oluştu: $e');
    }
  }

  Future<List<DenemeCard>?> deneme() async {
    await getUser();
    const url = 'https://demo.gecis360.com/api/genel/index.php';
    const headers = {
      'Authorization': 'Basic cm9vdEBnZWNpczM2MC5jb206MTIzNDEyMzQ=',
      'PHPSESSID': '0ms1fk84dssk9s3mtfmmdsjq24',
    };
    final body = {'token': '71joQRTKKC5R86NccWJzClvNFuAj07w03rB', 'kullanicibilgisi': '1'};
    final body1 = {'token': '71joQRTKKC5R86NccWJzClvNFuAj07w03rB', 'tesisbilgisi': '6'};
    final body2 = {'token': '71joQRTKKC5R86NccWJzClvNFuAj07w03rB', 'hizmetbilgisi': '25'};
    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);
      debugPrint("response${response.body}");
      if (response.statusCode == 200) {
        dynamic jsonData = json.decode(response.body);
        kullanicibilgim = kullanicibilgisi.fromJson(jsonData);
      }

      final response1 = await http.post(Uri.parse(url), headers: headers, body: body1);
      print("response1${response1.body}");
      if (response1.statusCode == 200) {
        dynamic jsonData = json.decode(response1.body);
        tesisbilgim = tesisbilgisi.fromJson(jsonData);
      }
      final response2 = await http.post(Uri.parse(url), headers: headers, body: body2);
      print("response2${response2.body}");
      if (response2.statusCode == 200) {
        dynamic jsonData = json.decode(response2.body);
        hizmetbilgim = hizmetbilgisi.fromJson(jsonData);
      }
      /*for (var i = 0; i < hizmetbilgim!.length; i++) {
        DenemeCard gelen = DenemeCard();
        gelen.kullanicibilgisimodel = kullanicibilgim;
        gelen.hizmetbilgisimodel = hizmetbilgim![i];
        gelen.tesisbilgisimodel = tesisbilgim![i];
        denemecardim!.add(gelen);
      }*/
      DenemeCard gelen = DenemeCard();
      gelen.kullanicibilgisimodel = kullanicibilgim;
      gelen.hizmetbilgisimodel = hizmetbilgim;
      gelen.tesisbilgisimodel = tesisbilgim;
      denemecardim.add(gelen);
      return denemecardim;
    } catch (e) {
      throw Exception('İstek sırasında hata oluştu: $e');
    }
  }

  @override
  void initState() {
    fetchRandevuList4 = fetchRandevuList();
    cardim = deneme();
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
              FutureBuilder<List<DenemeCard>?>(
                  future: cardim,
                  builder: (
                    context,
                    snapshot2,
                  ) {
                    if (snapshot2.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot2.hasError) {
                      return Center(child: SelectableText('Hata: ${snapshot2.error}'));
                    } else if (snapshot2.hasData) {
                      return FutureBuilder<List<RandevuModel>?>(
                        future: fetchRandevuList4,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Hata: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            final data = snapshot.data!;
                            final data2 = snapshot2.data!;
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: data2.length,
                              itemBuilder: (context, index) {
                                final appointment = data[index];
                                final bet = data2[index];
                                print(bet?.hizmetbilgisimodel?.randevuZamanlayici?.toString() ?? "");
                                print(bet.kullanicibilgisimodel!.isimsoyisim);
                                return AppointmentCard(
                                  buttonText: "İptal Edilen Randevu",
                                  title: bet.tesisbilgisimodel?.tesisAd ?? "",
                                  subtitle: bet.hizmetbilgisimodel?.hizmetAd ?? "",
                                  date: appointment.timestamp?.split(" ").first.toString() ?? "boş",
                                  startTime:
                                      "${bet.hizmetbilgisimodel?.randevuZamanlayici?.baslangicSaati ?? "boş"}-${bet.hizmetbilgisimodel?.randevuZamanlayici?.bitisSaati ?? ""}",
                                  endTime: bet.hizmetbilgisimodel?.aktifsaatBitis ?? "",
                                  onButtonPressed: () {
                                    // Randevuya tıklama işlemi
                                  },
                                );
                              },
                            );
                          } else {
                            return const Center(child: Text('iptal edilen randevu yok'));
                          }
                        },
                      );
                    } else {
                      return Center(child: Text("iptal yok "));
                    }
                  }),

              // Randevu kartlarını listele
            ],
          ),
        ),
      ),
    );
    // Randevu kartlarını listele
  }
}
