import 'package:armiyaapp/const/const.dart';
import 'package:armiyaapp/data/app_shared_preference.dart';
import 'package:armiyaapp/model/usermodel.dart';
import 'package:armiyaapp/services/auth_service.dart';

import 'package:armiyaapp/view/home_page.dart';

import 'package:armiyaapp/widget/button.dart';
import 'package:armiyaapp/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import '../navigator/custom_navigator.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  LoginPage({super.key});

  Future<void> login(BuildContext context) async {
    final String email = emailController.text;
    final String password = passwordController.text;
    final AppNavigator nav = AppNavigator.instance;

    try {
      // AuthService üzerinden login işlemi
      final response = await _authService.login(email, password);
      print(response);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Gelen yanıtı User modeline dönüştür
        UserModel user = UserModel.fromJson(responseData);

        // Yanıtın durumunu kontrol et
        if (user.status == true) {
          // Giriş başarılı
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${user.message}')),
          );
          SharedDataService().saveLoginData(responseData.toString());
          // Kullanıcı verilerini Hive kutusuna kaydet
          //      var box = Hive.box<User>('userBox');
          //     await box.put('currentUser', user); // Kullanıcı bilgilerini kaydet

          // Kullanıcı bilgilerini konsola yazdır

          print("Ad Soyad: ${user.isimsoyisim}");
          print("Yetki Grubu: ${user.yetkiGrubu}");
          print("Özel Yetkiler: ${user.ozelYetkiler}");

          // Giriş yapan kullanıcı bilgilerini işleyin

          nav.push(context: context, routePage: const HomePage());
          // Giriş başarılı olursa yönlendirme
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${user.message}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Giriş başarısız! ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Bir hata oluştu: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bir hata oluştu: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "HOŞGELDİNİZ",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      color: primaryColor),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Email",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
              ),
              CustomTextField(
                suffixIcon: Icon(Icons.email, color: Colors.grey),
                controller: emailController,
                hintText: "E-Posta Adresi & Telefon",
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Şifre",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
              ),
              CustomTextField(
                suffixIcon: Icon(Icons.key_rounded, color: Colors.grey),
                controller: passwordController,
                hintText: "Şifre",
                keyboardType: TextInputType.text,
                isPassword: true,
              ),
              const SizedBox(height: 45),
              Center(
                child: CustomButton(
                  text: "GİRİŞ YAP",
                  onPressed: () {
                    login(context);
                  },
                  icon: null,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
