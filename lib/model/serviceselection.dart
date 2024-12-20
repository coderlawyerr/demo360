class Autogenerated {
  List<Hizmetler>? hizmetler;
  Tesisbilgisi? tesisbilgisi;

  Autogenerated({this.hizmetler, this.tesisbilgisi});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    if (json['hizmetler'] != null) {
      hizmetler = (json['hizmetler'] as List)
          .map((v) => Hizmetler.fromJson(v))
          .toList();
    }
    tesisbilgisi = json['tesisbilgisi'] != null
        ? Tesisbilgisi.fromJson(json['tesisbilgisi'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'hizmetler': hizmetler?.map((v) => v.toJson()).toList(),
      'tesisbilgisi': tesisbilgisi?.toJson(),
    };
  }
}

class Hizmetler {
  int? hizmetId;
  String? hizmetAd;
  String? hizmetTuru;
  int? saatlikKapasite;
  String? randevuZamanlayici;
  int? ozelalan;
  int? limitsizkapasite;
  int? misafirKabul;
  int? grupRandevusu;
  int? aktif;

  Hizmetler({
    this.hizmetId,
    this.hizmetAd,
    this.hizmetTuru,
    this.saatlikKapasite,
    this.randevuZamanlayici,
    this.ozelalan,
    this.limitsizkapasite,
    this.misafirKabul,
    this.grupRandevusu,
    this.aktif,
  });

  Hizmetler.fromJson(Map<String, dynamic> json) {
    hizmetId = json['hizmet_id'];
    hizmetAd = json['hizmet_ad'];
    hizmetTuru = json['hizmet_turu'];
    saatlikKapasite = json['saatlik_kapasite'];
    randevuZamanlayici = json['randevu_zamanlayici'];
    ozelalan = json['ozelalan'];
    limitsizkapasite = json['limitsizkapasite'];
    misafirKabul = json['misafir_kabul'];
    grupRandevusu = json['grup_randevusu'];
    aktif = json['aktif'];
  }

  Map<String, dynamic> toJson() {
    return {
      'hizmet_id': hizmetId,
      'hizmet_ad': hizmetAd,
      'hizmet_turu': hizmetTuru,
      'saatlik_kapasite': saatlikKapasite,
      'randevu_zamanlayici': randevuZamanlayici,
      'ozelalan': ozelalan,
      'limitsizkapasite': limitsizkapasite,
      'misafir_kabul': misafirKabul,
      'grup_randevusu': grupRandevusu,
      'aktif': aktif,
    };
  }
}

class Tesisbilgisi {
  int? tesisId;
  String? tesisAd;
  String? tesisTel;
  String? tesisEposta;
  String? tesisAdres;
  String? yetkiliAdi;
  String? yetkiliSoyadi;
  String? yetkiliTel;
  String? yetkiliEposta;
  String? hizmetler;
  int? aktif;

  Tesisbilgisi({
    this.tesisId,
    this.tesisAd,
    this.tesisTel,
    this.tesisEposta,
    this.tesisAdres,
    this.yetkiliAdi,
    this.yetkiliSoyadi,
    this.yetkiliTel,
    this.yetkiliEposta,
    this.hizmetler,
    this.aktif,
  });

  Tesisbilgisi.fromJson(Map<String, dynamic> json) {
    tesisId = json['tesis_id'];
    tesisAd = json['tesis_ad'];
    tesisTel = json['tesis_tel'];
    tesisEposta = json['tesis_eposta'];
    tesisAdres = json['tesis_adres'];
    yetkiliAdi = json['yetkili_adi'];
    yetkiliSoyadi = json['yetkili_soyadi'];
    yetkiliTel = json['yetkili_tel'];
    yetkiliEposta = json['yetkili_eposta'];
    hizmetler = json['hizmetler'];
    aktif = json['aktif'];
  }

  Map<String, dynamic> toJson() {
    return {
      'tesis_id': tesisId,
      'tesis_ad': tesisAd,
      'tesis_tel': tesisTel,
      'tesis_eposta': tesisEposta,
      'tesis_adres': tesisAdres,
      'yetkili_adi': yetkiliAdi,
      'yetkili_soyadi': yetkiliSoyadi,
      'yetkili_tel': yetkiliTel,
      'yetkili_eposta': yetkiliEposta,
      'hizmetler': hizmetler,
      'aktif': aktif,
    };
  }
}
