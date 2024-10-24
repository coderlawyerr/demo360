import 'package:armiyaapp/model/new_model/hizmetler.dart';
import 'package:armiyaapp/widget/button.dart';
import 'package:flutter/material.dart';

class RandevuWidget extends StatefulWidget {
  final DateTime selectedDate;
  final List<Hizmetler> tumHizmetler;

  const RandevuWidget({
    Key? key,
    required this.selectedDate,
    required this.tumHizmetler,
  }) : super(key: key);

  @override
  State<RandevuWidget> createState() => _RandevuWidgetState();
}

class _RandevuWidgetState extends State<RandevuWidget> {
  List<Hizmetler> filtrelenmisHizmetler = [];
  Hizmetler? secilenHizmet; // Seçilen hizmeti saklayacak değişken

  @override
  void initState() {
    super.initState();
    filtreleHizmetler(widget.selectedDate);
  }

  void filtreleHizmetler(DateTime secilenTarih) {
    setState(() {
      filtrelenmisHizmetler = widget.tumHizmetler.where((hizmet) {
        return hizmet.zamanlayiciList.any((zamanlayici) =>
            zamanlayici.gun == secilenTarih.weekday);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String formattedDate =
        "${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Randevu Saati Seçimi -",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(width: 15),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                ),
                height: 50,
                width: screenWidth * 0.2,
                child: Center(
                  child: Text(
                    formattedDate,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            renkAciklama("Mavi : ", "Randevu Eklenebilir", Colors.blue),
            renkAciklama("Kırmızı : ", "Kapasite Dolu", Colors.red),
            renkAciklama("Yeşil : ", "Kayıtlı Randevunuz", Colors.green),
            renkAciklama("Sarı : ", "Aynı saatte randevunuz var", Colors.yellow),
            SizedBox(height: 40),
            Center(
              child: SizedBox(
                width: 150,
                child: CustomButton(
                  icon: Icons.arrow_back_ios,
                  onPressed: () {},
                  text: "Takvime Dön",
                ),
              ),
            ),
            if (secilenHizmet != null) // Eğer bir hizmet seçildiyse göstereceğiz
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Seçilen Hizmet: ${secilenHizmet!.hizmetAd}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: filtrelenmisHizmetler.length,
            itemBuilder: (context, index) {
              final hizmet = filtrelenmisHizmetler[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    secilenHizmet = hizmet;
                  });
                },
                child: Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hizmet.hizmetAd ?? 'Hizmet Adı Yok',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text('Hizmet Türü: ${hizmet.hizmetTuru ?? 'Belirtilmemiş'}'),
                        Text('Özel Alan: ${hizmet.ozelAlan ?? 0}'),
                        Text('Genel Alan: ${hizmet.limitsizKapasite ?? 0}'),
                        Text('Genel Kullanım: ${hizmet.gunlukGirissayisi ?? 0}'),
                        Text('Randevu Kapasitesi: ${hizmet.saatlikKapasite ?? 0}'),
                        SizedBox(height: 20),
                        
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget renkAciklama(String baslik, String aciklama, Color renk) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: baslik,
              style: TextStyle(color: renk),
            ),
            TextSpan(
              text: aciklama,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
