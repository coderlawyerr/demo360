import 'package:armiyaapp/data/app_shared_preference.dart';
import 'package:armiyaapp/model/usermodel.dart';
import 'package:armiyaapp/services/auth_service.dart';
import 'package:armiyaapp/view/appoinment/appoinment_view.dart';

import 'package:armiyaapp/widget/button.dart';
import 'package:armiyaapp/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  LoginPage({super.key});

  Future<void> login(BuildContext context) async {
    final String email = emailController.text;
    final String password = passwordController.text;

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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AppointmentView()),
          ); // Giriş başarılı olursa yönlendirme
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Giriş Yap",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text("GKS Yönetimi"),
              const SizedBox(height: 24),
              CustomTextField(
                controller: emailController,
                hintText: "E-Posta Adresi & Telefon",
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: passwordController,
                hintText: "Şifre",
                keyboardType: TextInputType.text,
                isPassword: true,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: "Giriş Yap",
                icon: Icons.thumb_up,
                onPressed: () {
                  login(context);
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
