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
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../providers/appoinment/appoinment_provider.dart';

class ActiveAppointment extends StatefulWidget {
  const ActiveAppointment({super.key});

  @override
  State<ActiveAppointment> createState() => _ActiveAppointmentState();
}

class _ActiveAppointmentState extends State<ActiveAppointment> {
  UserModel? myusermodel;
  AppointmentProvider provider = AppointmentProvider();

  late final Future<List<DenemeCard>?> cardim;
  List<RandevuModel>? aktifrandevular;
  Kullanicibilgisi? kullanicibilgim;
  Hizmetbilgisi? hizmetbilgim;
  Tesisbilgisi? tesisbilgim;
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
    final body = {'token': '71joQRTKKC5R86NccWJzClvNFuAj07w03rB', 'aktifrandevular': '1', 'kullanici_id': myusermodel?.id?.toString() ?? ""};

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        aktifrandevular = [];
        List<dynamic> jsonData = json.decode(response.body);
        aktifrandevular?.addAll(jsonData.map((item) => RandevuModel.fromJson(item)).toList());

        return aktifrandevular;
      } else {
        return [];
      }
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
        kullanicibilgim = Kullanicibilgisi.fromJson(jsonData);
      }

      final response1 = await http.post(Uri.parse(url), headers: headers, body: body1);
      print("response1${response1.body}");
      if (response1.statusCode == 200) {
        dynamic jsonData = json.decode(response1.body);
        tesisbilgim = Tesisbilgisi.fromJson(jsonData);
      }
      final response2 = await http.post(Uri.parse(url), headers: headers, body: body2);
      print("response2${response2.body}");
      if (response2.statusCode == 200) {
        dynamic jsonData = json.decode(response2.body);
        hizmetbilgim = Hizmetbilgisi.fromJson(jsonData);
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
    init();
    cardim = deneme();
    super.initState();
  }

  init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = Provider.of<AppointmentProvider>(context, listen: false);
      provider.fetchServices(24);
      provider.fetchFacilities().catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tesisler alınamadı: $error')),
        );
      });
    });

    await deneme();
    await fetchRandevuList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Randevularınızı, randevu gününü başlangıç saatinden en geç 60 dakika öncesine kadar iptal edebilirsiniz",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey),
              ),
              Expanded(
                child: aktifrandevular == null
                    ? const Center(child: CircularProgressIndicator())
                    : aktifrandevular!.isEmpty
                        ? const Center(child: Text('Veri bulunamadı'))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: aktifrandevular?.length ?? 0,
                            itemBuilder: (context, index) {
                              final randevu = aktifrandevular?[index];

                              return AppointmentCard(
                                buttonText: "Randevuyu iptal et!",
                                title: provider.facilities.where((e) => e.tesisId == randevu?.tesisId).first.tesisAd ??
                                    "", // appointment?.tesisbilgisimodel?.tesisAd ??"",
                                subtitle: provider.services.isEmpty == true
                                    ? ""
                                    : provider.services.where((e) => e.hizmetId == randevu?.hizmetId).first.hizmetAd ??
                                        "", // appointment?.hizmetbilgisimodel?.hizmetAd ??"",
                                date: randevu?.baslangicTarihi?.split(" ").first.toString() ?? "boş",
                                startTime: "${randevu?.baslangicTarihi?.split(" ").last ?? "boş"}-${randevu?.bitisTarihi?.split(" ").last ?? ""}",
                                endTime: randevu?.bitisTarihi?.split(" ").first ?? "",
                                onButtonPressed: () {
                                  // Randevuya tıklama işlemi
                                },
                              );
                            },
                          ),
              ),

              // Randevu kartlarını listele
            ],
          ),
        ),
      ),
    );
    // Randevu kartlarını listele
  }
}
