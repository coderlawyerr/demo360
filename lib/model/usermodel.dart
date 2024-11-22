class UserModel {
  bool? status;
  String? message;
  Kullanicibilgisi? kullanicibilgisi;
  String? isimsoyisim;
  String? yetkiGrubu;
  String? ozelYetkiler;

  UserModel({this.status, this.message, this.kullanicibilgisi, this.isimsoyisim, this.yetkiGrubu, this.ozelYetkiler});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    kullanicibilgisi = json['kullanicibilgisi'] != null ? new Kullanicibilgisi.fromJson(json['kullanicibilgisi']) : null;
    isimsoyisim = json['isimsoyisim'];
    yetkiGrubu = json['yetki_Grubu'];
    ozelYetkiler = json['ozelYetkiler'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.kullanicibilgisi != null) {
      data['kullanicibilgisi'] = this.kullanicibilgisi!.toJson();
    }
    data['isimsoyisim'] = this.isimsoyisim;
    data['yetki_Grubu'] = this.yetkiGrubu;
    data['ozelYetkiler'] = this.ozelYetkiler;
    return data;
  }
}

class Kullanicibilgisi {
  int? id;
  String? isimsoyisim;
  String? kullaniciadi;
  String? eposta;
  String? ulkekodu;
  String? telefon;
  String? sifre;
  String? yetkiGrubu;
  String? ozelYetkiler;
  int? hesapdurumu;
  String? sessions;
  int? silinenleriGoster;
  Null? token;
  Null? tematercihleri;
  String? magictoken;
  Null? olusturmaTarihi;
  Null? profilResmi;
  Null? tckimlikno;
  String? cinsiyet;
  Null? uyeEvtel;
  Null? uyeAdres;
  int? uyeIl;
  int? uyeIlce;
  String? misafirDurumu;
  String? tesisler;
  String? uyelikler;
  String? odemeSekli;
  String? kartId;
  String? geciciQrkod;
  Null? medeniHali;
  Null? esAdi;
  Null? evlilikTarihi;
  Null? esDogumtarihi;
  Null? aileAdres;
  Null? aileIl;
  Null? aileIlce;
  Null? firmaAd;
  Null? firmaUnvan;
  Null? firmaCeptel;
  Null? firmaIstel;
  Null? firmaKimlik;
  Null? firmaEposta;
  Null? firmaAdres;
  Null? firmaIl;
  Null? firmaIlce;
  Null? webadres;
  Null? digerbilgiler;
  Null? uyeDogumyeri;
  Null? uyeDogumtarihi;
  Null? uyeEgitim;
  Null? uyeKangrubu;
  Null? aracplakasi;
  Null? uyeHobiler;
  Null? uyeFobiler;
  Null? acilAd1;
  Null? acilSoyad1;
  Null? acilTel1;
  Null? acilAd2;
  Null? acilSoyad2;
  Null? acilTel2;
  Null? acilAd3;
  Null? acilSoyad3;
  Null? acilTel3;
  Null? acilAd4;
  Null? acilSoyad4;
  Null? acilTel4;
  Null? acilAd5;
  Null? acilSoyad5;
  Null? acilTel5;
  int? uyeDurumu;
  Null? detaylar;
  String? yaptirimCezalari;
  int? sifreDegistirildimi;
  String? girisHakki;

  Kullanicibilgisi(
      {this.id,
      this.isimsoyisim,
      this.kullaniciadi,
      this.eposta,
      this.ulkekodu,
      this.telefon,
      this.sifre,
      this.yetkiGrubu,
      this.ozelYetkiler,
      this.hesapdurumu,
      this.sessions,
      this.silinenleriGoster,
      this.token,
      this.tematercihleri,
      this.magictoken,
      this.olusturmaTarihi,
      this.profilResmi,
      this.tckimlikno,
      this.cinsiyet,
      this.uyeEvtel,
      this.uyeAdres,
      this.uyeIl,
      this.uyeIlce,
      this.misafirDurumu,
      this.tesisler,
      this.uyelikler,
      this.odemeSekli,
      this.kartId,
      this.geciciQrkod,
      this.medeniHali,
      this.esAdi,
      this.evlilikTarihi,
      this.esDogumtarihi,
      this.aileAdres,
      this.aileIl,
      this.aileIlce,
      this.firmaAd,
      this.firmaUnvan,
      this.firmaCeptel,
      this.firmaIstel,
      this.firmaKimlik,
      this.firmaEposta,
      this.firmaAdres,
      this.firmaIl,
      this.firmaIlce,
      this.webadres,
      this.digerbilgiler,
      this.uyeDogumyeri,
      this.uyeDogumtarihi,
      this.uyeEgitim,
      this.uyeKangrubu,
      this.aracplakasi,
      this.uyeHobiler,
      this.uyeFobiler,
      this.acilAd1,
      this.acilSoyad1,
      this.acilTel1,
      this.acilAd2,
      this.acilSoyad2,
      this.acilTel2,
      this.acilAd3,
      this.acilSoyad3,
      this.acilTel3,
      this.acilAd4,
      this.acilSoyad4,
      this.acilTel4,
      this.acilAd5,
      this.acilSoyad5,
      this.acilTel5,
      this.uyeDurumu,
      this.detaylar,
      this.yaptirimCezalari,
      this.sifreDegistirildimi,
      this.girisHakki});

  Kullanicibilgisi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isimsoyisim = json['isimsoyisim'];
    kullaniciadi = json['kullaniciadi'];
    eposta = json['eposta'];
    ulkekodu = json['ulkekodu'];
    telefon = json['telefon'];
    sifre = json['sifre'];
    yetkiGrubu = json['yetki_Grubu'];
    ozelYetkiler = json['ozelYetkiler'];
    hesapdurumu = json['hesapdurumu'];
    sessions = json['sessions'];
    silinenleriGoster = json['silinenleriGoster'];
    token = json['token'];
    tematercihleri = json['tematercihleri'];
    magictoken = json['magictoken'];
    olusturmaTarihi = json['olusturma_tarihi'];
    profilResmi = json['profil_resmi'];
    tckimlikno = json['tckimlikno'];
    cinsiyet = json['cinsiyet'];
    uyeEvtel = json['uye_evtel'];
    uyeAdres = json['uye_adres'];
    uyeIl = json['uye_il'];
    uyeIlce = json['uye_ilce'];
    misafirDurumu = json['misafir_durumu'];
    tesisler = json['tesisler'];
    uyelikler = json['uyelikler'];
    odemeSekli = json['odeme_sekli'];
    kartId = json['kart_id'];
    geciciQrkod = json['gecici_qrkod'];
    medeniHali = json['medeni_hali'];
    esAdi = json['es_adi'];
    evlilikTarihi = json['evlilik_tarihi'];
    esDogumtarihi = json['es_dogumtarihi'];
    aileAdres = json['aile_adres'];
    aileIl = json['aile_il'];
    aileIlce = json['aile_ilce'];
    firmaAd = json['firma_ad'];
    firmaUnvan = json['firma_unvan'];
    firmaCeptel = json['firma_ceptel'];
    firmaIstel = json['firma_istel'];
    firmaKimlik = json['firma_kimlik'];
    firmaEposta = json['firma_eposta'];
    firmaAdres = json['firma_adres'];
    firmaIl = json['firma_il'];
    firmaIlce = json['firma_ilce'];
    webadres = json['webadres'];
    digerbilgiler = json['digerbilgiler'];
    uyeDogumyeri = json['uye_dogumyeri'];
    uyeDogumtarihi = json['uye_dogumtarihi'];
    uyeEgitim = json['uye_egitim'];
    uyeKangrubu = json['uye_kangrubu'];
    aracplakasi = json['aracplakasi'];
    uyeHobiler = json['uye_hobiler'];
    uyeFobiler = json['uye_fobiler'];
    acilAd1 = json['acil_ad1'];
    acilSoyad1 = json['acil_soyad1'];
    acilTel1 = json['acil_tel1'];
    acilAd2 = json['acil_ad2'];
    acilSoyad2 = json['acil_soyad2'];
    acilTel2 = json['acil_tel2'];
    acilAd3 = json['acil_ad3'];
    acilSoyad3 = json['acil_soyad3'];
    acilTel3 = json['acil_tel3'];
    acilAd4 = json['acil_ad4'];
    acilSoyad4 = json['acil_soyad4'];
    acilTel4 = json['acil_tel4'];
    acilAd5 = json['acil_ad5'];
    acilSoyad5 = json['acil_soyad5'];
    acilTel5 = json['acil_tel5'];
    uyeDurumu = json['uye_durumu'];
    detaylar = json['detaylar'];
    yaptirimCezalari = json['yaptirim_cezalari'];
    sifreDegistirildimi = json['sifre_degistirildimi'];
    girisHakki = json['giris_hakki'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isimsoyisim'] = this.isimsoyisim;
    data['kullaniciadi'] = this.kullaniciadi;
    data['eposta'] = this.eposta;
    data['ulkekodu'] = this.ulkekodu;
    data['telefon'] = this.telefon;
    data['sifre'] = this.sifre;
    data['yetki_Grubu'] = this.yetkiGrubu;
    data['ozelYetkiler'] = this.ozelYetkiler;
    data['hesapdurumu'] = this.hesapdurumu;
    data['sessions'] = this.sessions;
    data['silinenleriGoster'] = this.silinenleriGoster;
    data['token'] = this.token;
    data['tematercihleri'] = this.tematercihleri;
    data['magictoken'] = this.magictoken;
    data['olusturma_tarihi'] = this.olusturmaTarihi;
    data['profil_resmi'] = this.profilResmi;
    data['tckimlikno'] = this.tckimlikno;
    data['cinsiyet'] = this.cinsiyet;
    data['uye_evtel'] = this.uyeEvtel;
    data['uye_adres'] = this.uyeAdres;
    data['uye_il'] = this.uyeIl;
    data['uye_ilce'] = this.uyeIlce;
    data['misafir_durumu'] = this.misafirDurumu;
    data['tesisler'] = this.tesisler;
    data['uyelikler'] = this.uyelikler;
    data['odeme_sekli'] = this.odemeSekli;
    data['kart_id'] = this.kartId;
    data['gecici_qrkod'] = this.geciciQrkod;
    data['medeni_hali'] = this.medeniHali;
    data['es_adi'] = this.esAdi;
    data['evlilik_tarihi'] = this.evlilikTarihi;
    data['es_dogumtarihi'] = this.esDogumtarihi;
    data['aile_adres'] = this.aileAdres;
    data['aile_il'] = this.aileIl;
    data['aile_ilce'] = this.aileIlce;
    data['firma_ad'] = this.firmaAd;
    data['firma_unvan'] = this.firmaUnvan;
    data['firma_ceptel'] = this.firmaCeptel;
    data['firma_istel'] = this.firmaIstel;
    data['firma_kimlik'] = this.firmaKimlik;
    data['firma_eposta'] = this.firmaEposta;
    data['firma_adres'] = this.firmaAdres;
    data['firma_il'] = this.firmaIl;
    data['firma_ilce'] = this.firmaIlce;
    data['webadres'] = this.webadres;
    data['digerbilgiler'] = this.digerbilgiler;
    data['uye_dogumyeri'] = this.uyeDogumyeri;
    data['uye_dogumtarihi'] = this.uyeDogumtarihi;
    data['uye_egitim'] = this.uyeEgitim;
    data['uye_kangrubu'] = this.uyeKangrubu;
    data['aracplakasi'] = this.aracplakasi;
    data['uye_hobiler'] = this.uyeHobiler;
    data['uye_fobiler'] = this.uyeFobiler;
    data['acil_ad1'] = this.acilAd1;
    data['acil_soyad1'] = this.acilSoyad1;
    data['acil_tel1'] = this.acilTel1;
    data['acil_ad2'] = this.acilAd2;
    data['acil_soyad2'] = this.acilSoyad2;
    data['acil_tel2'] = this.acilTel2;
    data['acil_ad3'] = this.acilAd3;
    data['acil_soyad3'] = this.acilSoyad3;
    data['acil_tel3'] = this.acilTel3;
    data['acil_ad4'] = this.acilAd4;
    data['acil_soyad4'] = this.acilSoyad4;
    data['acil_tel4'] = this.acilTel4;
    data['acil_ad5'] = this.acilAd5;
    data['acil_soyad5'] = this.acilSoyad5;
    data['acil_tel5'] = this.acilTel5;
    data['uye_durumu'] = this.uyeDurumu;
    data['detaylar'] = this.detaylar;
    data['yaptirim_cezalari'] = this.yaptirimCezalari;
    data['sifre_degistirildimi'] = this.sifreDegistirildimi;
    data['giris_hakki'] = this.girisHakki;
    return data;
  }
}
