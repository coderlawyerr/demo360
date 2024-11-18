import 'dart:async';
import 'dart:developer';
import 'package:armiyaapp/const/const.dart';
import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:http/http.dart' as http;

class QRImageFetcher extends StatefulWidget {
  const QRImageFetcher({super.key});

  @override
  State createState() => _QRImageFetcherState();
}

class _QRImageFetcherState extends State<QRImageFetcher> {
  Timer? _timer;
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  String? _imageUrl;

  final String apiUrl = "https://demo.gecis360.com/randevu/qr.php";

  double? _originalBrightness; // Ekran parlaklığını saklamak için değişken

  @override
  void initState() {
    super.initState();
    _fetchImage();
    _getOriginalBrightness(); // Orijinal parlaklığı al
    _setBrightness(1.0); // Uygulama ekran parlaklığını maksimuma ayarla

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _counter.value++;
      if (_counter.value > 5) {
        _counter.value = 0;
      }
      log('Counter: $_counter');
      setState(() {});
    });

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _fetchImage();
    });
  }

  Future<void> _getOriginalBrightness() async {
    _originalBrightness = await ScreenBrightness().current; // Mevcut parlaklığı al
  }

  Future<void> _setBrightness(double brightness) async {
    try {
      await ScreenBrightness().setApplicationScreenBrightness(brightness);
    } catch (e) {
      print("Parlaklık ayarlanırken hata oluştu: $e");
    }
  }

  Future<void> _fetchImage() async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'accept': '*/*',
        'accept-language': 'tr-TR,tr;q=0.9,en-TR;q=0.8,en;q=0.7,en-US;q=0.6',
        'content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'cookie': 'PHPSESSID=6irfbeoeqsmdga2cv8h8n535lv', // Set actual session ID if needed
        'origin': 'https://demo.gecis360.com',
        'priority': 'u=1, i',
        'referer': 'https://demo.gecis360.com/randevu/qr.php',
      },
      body: {
        'qrolustur': '1',
        'id': '1',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _imageUrl = response.body;
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _setBrightness(_originalBrightness ?? 0.5); // Varsayılan parlaklık seviyesine geri dön
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('RANDEVU QR KODU')),
      body: Padding(
        padding: EdgeInsets.all(60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "RANDEVU İÇİN QR KODUNUZ",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            ValueListenableBuilder(
                valueListenable: _counter,
                builder: (context, val, child) {
                  return LinearProgressIndicator(
                    value: 1 / 5 * val,
                    color: Colors.yellow,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF5664D9)),
                  );
                }),
            Center(
              child: _imageUrl != null
                  ? Padding(
                      padding: const EdgeInsets.all(1),
                      child: Image.network(_imageUrl ?? ''),
                    )
                  : const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
