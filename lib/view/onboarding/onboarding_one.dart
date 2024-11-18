import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:armiyaapp/const/const.dart';
import 'package:armiyaapp/view/onboarding/onboarding_two.dart';
import 'package:flutter/material.dart';

class OnboardingOne extends StatefulWidget {
  const OnboardingOne({super.key});

  @override
  State<OnboardingOne> createState() => _OnboardingOneState();
}

class _OnboardingOneState extends State<OnboardingOne> {
  @override
  void initState() {
    super.initState();

    // 5 saniye sonra diğer sayfaya geçiş yapacak
    Timer(Duration(seconds: 5), _navigateToNextPage);
  }

  void _navigateToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OnboardingTwo()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx < -10) {
            _navigateToNextPage();
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 60,
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      isRepeatingAnimation: true,
                      animatedTexts: [
                        WavyAnimatedText('G E Ç İ Ş   3 6 0 !'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
