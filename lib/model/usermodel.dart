import 'package:hive_flutter/adapters.dart';

part 'usermodel.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  bool? status;

  @HiveField(1)
  String? message;

  @HiveField(2)
  int? iD;

  @HiveField(3)
  String? isimsoyisim;

  @HiveField(4)
  String? yetkiGrubu;

  @HiveField(5)
  String? ozelYetkiler;

  User({
    this.status,
    this.message,
    this.iD,
    this.isimsoyisim,
    this.yetkiGrubu,
    this.ozelYetkiler,
  });

  User.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    iD = json['ID'];
    isimsoyisim = json['isimsoyisim'];
    yetkiGrubu = json['yetki_Grubu'];
    ozelYetkiler = json['ozelYetkiler'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = this.status;
    data['message'] = this.message;
    data['ID'] = this.iD;
    data['isimsoyisim'] = this.isimsoyisim;
    data['yetki_Grubu'] = this.yetkiGrubu;
    data['ozelYetkiler'] = this.ozelYetkiler;
    return data;
  }
}
