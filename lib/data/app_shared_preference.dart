import 'dart:convert';
import 'dart:developer';

import 'package:armiyaapp/model/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedDataService {

  // Bu bizim kullanıcımızın giriş bilgilerini tutan keyimiz olsun
 String userLoginKey ="loginKey";


// Bu function bizim kullanıcı bilgilerimizi tutatacak
  Future<void> saveLoginData(String loginData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.setString(userLoginKey, loginData);
   
  }


// Buda kaydettiğimiz bilgileri çekeceğimiz yer
 Future<UserModel?> getLoginData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
final modelData=  prefs.getString(userLoginKey);
log(modelData.toString());
String correctedString = modelData?.replaceAllMapped(RegExp(r'(\w+):'), (match) => '"${match[1]}":')
    .replaceAllMapped(RegExp(r': ([^"{\[][^,]*)'), (match) => ': "${match[1]}"') ??"";

Map<String,dynamic> jsonData = jsonDecode( correctedString);

return UserModel.fromJson(jsonData);
   
  }


  



// Buda kullanıcı çıkış yapacağı zaman kullanacağımız function

  Future<bool> removeUserData()async{
  
    final SharedPreferences prefs = await SharedPreferences.getInstance();


   return prefs.remove(userLoginKey);

  }
}
 