import 'dart:convert';
import 'package:armiyaapp/data/app_shared_preference.dart';
import 'package:armiyaapp/model/deneme.dart';
import 'package:armiyaapp/model/hizmet_bilgisi.dart';
import 'package:armiyaapp/model/kullanici_bilgisi.dart';
import 'package:armiyaapp/model/passive_model.dart';
import 'package:armiyaapp/model/tesisbilgisi.dart';
import 'package:armiyaapp/model/usermodel.dart';
import 'package:armiyaapp/widget/appointmentcard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PassAppointment extends StatefulWidget {
  const PassAppointment({super.key});

  @override
  State<PassAppointment> createState() => _CanceledAppointment();
}

class _CanceledAppointment extends State<PassAppointment> {
  UserModel? myusermodel;
  late final Future<List<PassiveModel>?> fetchpassivelist4;
  late final Future<List<DenemeCard>?> cardim;
  List<PassiveModel>? pasifrandevular;
  kullanicibilgisi? kullanicibilgim;
  hizmetbilgisi? hizmetbilgim;
  tesisbilgisi? tesisbilgim;
  List<DenemeCard> denemecardim = [];

  getUser() async {
    myusermodel = await SharedDataService().getLoginData();
  }

  Future<List<PassiveModel>?> passiveRandevuList() async {
    await getUser();
    const url = 'https://demo.gecis360.com/api/randevu/olustur/index.php';
    const headers = {
      'Authorization': 'Basic cm9vdEBnZWNpczM2MC5jb206MTIzNDEyMzQ=',
      'PHPSESSID': '0ms1fk84dssk9s3mtfmmdsjq24',
    };
    final body = {'token': '71joQRTKKC5R86NccWJzClvNFuAj07w03rB', 'gecmisrandevular': '1', 'kullanici_id': '1'};

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        pasifrandevular = jsonData.map((item) => PassiveModel.fromJson(item)).toList();
        return pasifrandevular;
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
      if (response.statusCode == 200) {
        dynamic jsonData = json.decode(response.body);
        kullanicibilgim = kullanicibilgisi.fromJson(jsonData);
      }

      final response1 = await http.post(Uri.parse(url), headers: headers, body: body1);
      if (response1.statusCode == 200) {
        dynamic jsonData = json.decode(response1.body);
        tesisbilgim = tesisbilgisi.fromJson(jsonData);
      }

      final response2 = await http.post(Uri.parse(url), headers: headers, body: body2);
      if (response2.statusCode == 200) {
        dynamic jsonData = json.decode(response2.body);
        hizmetbilgim = hizmetbilgisi.fromJson(jsonData);
      }

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
    fetchpassivelist4 = passiveRandevuList();
    cardim = deneme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              FutureBuilder<List<DenemeCard>?>(
                future: cardim,
                builder: (context, snapshot2) {
                  if (snapshot2.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot2.hasError) {
                    return Center(child: Text('Hata: ${snapshot2.error}'));
                  } else if (snapshot2.hasData) {
                    return FutureBuilder<List<PassiveModel>?>(
                      future: fetchpassivelist4,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
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
                              return AppointmentCard(
                                buttonText: "Geçmiş Randevular",
                                title: bet.tesisbilgisimodel!.tesisAd ?? "",
                                subtitle: bet.hizmetbilgisimodel!.hizmetAd ?? "",
                                date: appointment?.timestamp?.split(" ").first.toString() ?? "",
                                startTime: bet.hizmetbilgisimodel!.aktifsaatBaslangic ?? "",
                                endTime: bet.hizmetbilgisimodel!.aktifsaatBitis ?? "",
                                onButtonPressed: () {
                                  // Randevuya tıklama işlemi
                                },
                              );
                            },
                          );
                        } else {
                          return Center(child: Text('Veri bulunamadı'));
                        }
                      },
                    );
                  } else {
                    return Center(child: Text('Veri bulunamadı'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
