import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:armiyaapp/const/const.dart';
import 'package:armiyaapp/view/login.dart';
import 'package:flutter/material.dart';

class OnboardingTwo extends StatefulWidget {
  const OnboardingTwo({super.key});

  @override
  State<OnboardingTwo> createState() => _OnboardingTwoState();
}

class _OnboardingTwoState extends State<OnboardingTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 100, left: 30, right: 30),
        child: Stack(
          // Stack widget'ı ekledik
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Image.asset(
                    'assets/onboarding.png',
                    width: 250, // Genişlik
                    height: 250, // Yükseklik
                    fit: BoxFit.cover, // Görüntü ölçekleme
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.centerLeft, // Sol tarafa yaslama
                    child: Text(
                      "Hayalinizdeki sağlıklı yaşam için bir adım atın!",
                      style: TextStyle(
                        fontFamily: 'DM Sans', // Font family adını buraya yazın
                        fontSize: 20, // Font boyutunu isteğinize göre ayarlayın
                        color: Colors.black, // Metin rengini ayarlayın
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60, // Yüksekliği ayarladık
                    child: Align(
                      alignment: Alignment.centerLeft, // Yazıyı sola yaslamak için Align kullanıyoruz
                      child: DefaultTextStyle(
                        style: TextStyle(
                          color: primaryColor, // Yazı rengini beyaz yaptık
                          fontSize: 20, // Font boyutunu 40 yaptık
                        ),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          isRepeatingAnimation: true,
                          animatedTexts: [
                            WavyAnimatedText('Geçiş 360 !'), // WavyAnimatedText kullanıldı
                          ],
                        ),
                      ),
                    ),
                  ),

                  // SizedBox(
                  //   height: 10,
                  // ),

                  // SizedBox(height: 15),
                  // Align(
                  //   alignment: Alignment.centerLeft, // Sol tarafa yaslama
                  //   child: Text(
                  //     "DEMO 360",
                  //     style: TextStyle(
                  //       fontFamily: 'DM Sans', // Font family adını buraya yazın
                  //       fontSize: 40, // Font boyutunu isteğinize göre ayarlayın
                  //       color: myColor,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              right: 0, // Sağdan 0 birim mesafe
              child: GestureDetector(
                onTap: () {
                  // Yönlendirme işlemi
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // Oval şekil için
                    color: primaryColor,
                  ),
                  width: 70, // Yeni genişlik
                  height: 70, // Yeni yükseklik
                  child: Icon(
                    Icons.arrow_forward_rounded, // İleri ok ikonu
                    color: Colors.white, // İkon rengi
                    size: 35, // İkon boyutu (isteğe göre ayarlayabilirsiniz)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
