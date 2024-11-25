import 'package:armiyaapp/model/usermodel.dart';
import 'package:http/http.dart' as http;

class AuthService {
   UserModel? myusermodel;
  final String baseUrl = 'https://demo.gecis360.com/api/login/index.php';

  // Login fonksiyonu
  Future<http.Response> login(String email, String password) async {
    final String url = baseUrl;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
        body: {
          'kullaniciadi': email,
          'sifre': password,
          'token': "71joQRTKKC5R86NccWJzClvNFuAj07w03rB",
        },
      );

      return response;
    } catch (e) {
      throw Exception('Login işlemi sırasında hata oluştu: $e');
    }
  }
}
