// appointment_provider.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:armiyaapp/model/autogenerated.dart';
import 'package:armiyaapp/model/new_model/newmodel.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // Tesis ve hizmet listeleri
  List<Facility> _facilities = [];
  List<Facility> get facilities => _facilities;
  List<Bilgi> _services = [];
  List<Bilgi> get services => _services;
  List<Bilgi> _selectedServices = [];
  List<Bilgi> get selectedServices => _selectedServices;
  // Her hizmete ait saat dilimlerini saklamak için
  Map<int, List<DateTime>> _serviceTimeSlots = {};
  Map<int, List<DateTime>> get serviceTimeSlots => _serviceTimeSlots;
  // Her hizmetin periyot değerlerini saklamak için
  Map<int, int> _servicePeriyots = {};
  Map<int, int> get servicePeriyots => _servicePeriyots;
  List<Randevu> _existingAppointments = [];
  List<Randevu> get existingAppointments => _existingAppointments;
  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;
  int aktifGunSayisi =
      0; // Aktif gün sayısını buraya ekleyin veya dinamik olarak alın
  // Seçili tesis ve hizmet ID'leri
  int? _selectedFacilityId;
  int? get selectedFacilityId => _selectedFacilityId;
  List<int> _selectedServiceIds = [];

  List<int> get selectedServiceIds => _selectedServiceIds;
  // Durum değişkenleri
  bool _showCalendar = false;
  bool get showCalendar => _showCalendar;
  bool _showTimeSlots = false;
  bool get showTimeSlots => _showTimeSlots;
  // API Token
  final String _token = '71joQRTKKC5R86NccWJzClvNFuAj07w03rB';
  // CalendarController
  final CalendarController calendarController = CalendarController();
  // Tesisleri API'den Çekme
  Future<void> fetchFacilities() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await http.post(
        Uri.parse('https://demo.gecis360.com/api/randevu/olustur/index.php'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept-CharSet': 'utf-8'
        },
        body: {
          'tesislergetir': '1',
          'token': _token,
        },
      );
      print('HTTP Status Code: ${response.statusCode}');
      print('HTTP Response Body: ${response.body}');
      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          throw Exception('API boş yanıt döndü.');
        }

        final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

        if (jsonResponse is List) {
          _facilities =
              jsonResponse.map((item) => Facility.fromJson(item)).toList();
        } else {
          throw Exception('Beklenen formatta veri gelmedi.');
        }
      } else {
        throw Exception('Veri çekilemedi. Lütfen tekrar deneyin.');
      }
    } catch (e) {
      print('Tesisleri alırken hata oluştu: $e');
      throw e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Seçilen Tesis'e Bağlı Hizmetleri API'den Çekme
  Future<void> fetchServices(int facilityId) async {
    _isLoading = true;
    notifyListeners();

    // Temizleme işlemleri
    _services = [];
    _selectedServiceIds = [];
    _selectedServices = [];
    _serviceTimeSlots = {};
    _servicePeriyots = {};
    _selectedDate = null;
    _existingAppointments = [];
    _showCalendar = false;
    _showTimeSlots = false;

    try {
      final response = await http.post(
        Uri.parse('https://demo.gecis360.com/api/randevu/olustur/index.php'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'tesissecim': facilityId.toString(),
          'token': _token,
        },
      );

      print('Hizmetler API HTTP Status Code: ${response.statusCode}');
      print('Hizmetler API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          throw Exception('API boş yanıt döndü.');
        }

        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['hizmetler'] != null &&
            jsonResponse['hizmetler'] is List) {
          _services = List<Bilgi>.from(
            jsonResponse['hizmetler'].map((x) => Bilgi.fromMap(x)),
          );

          if (_services.isNotEmpty) {
            _showCalendar = false;
          } else {
            _showCalendar = false;
          }
        } else {
          throw Exception('Hizmetler listesi beklenen formatta değil.');
        }
      } else {
        throw Exception('Hizmetler API isteği başarısız oldu.');
      }
    } catch (e) {
      print('Hizmetler API hatası: $e');
      throw e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Seçilen Hizmetleri Ayarlama
  void setSelectedServices(List<int> serviceIds) {
    _selectedServiceIds = serviceIds;
    _selectedServices =
        _services.where((s) => serviceIds.contains(s.hizmetId)).toList();
    _showCalendar = serviceIds.isNotEmpty;
    _showTimeSlots = false;
    _selectedDate = null;
    _serviceTimeSlots = {};
    _servicePeriyots = {};
    _existingAppointments = [];
    notifyListeners();
  }

  // Seçilen Tesis
  void setSelectedFacility(int facilityId) {
    _selectedFacilityId = facilityId;
    notifyListeners();
  }

  // Seçilen Tarihi Ayarlama
  void setSelectedDate(DateTime? date) {
    _selectedDate = date;
    notifyListeners();
  }

  // Seçilen Tarihi Ayarlama ve Saat Dilimlerini Gösterme
  Future<void> selectDate(BuildContext context, DateTime selected) async {
    // Geçmiş tarihi kontrol et (bugün ve geleceği seçebilir)
    DateTime today = DateTime.now();
    DateTime? maxDate;
    if (aktifGunSayisi > 0) {
      maxDate = today.add(Duration(days: aktifGunSayisi));
    }

    if (selected.isBefore(today.subtract(const Duration(days: 1))) ||
        (maxDate != null && selected.isAfter(maxDate))) {
      // Geçmiş veya izin verilen maksimum tarihten sonra bir tarih seçildi
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bu tarih seçilemez.'),
        ),
      );
      return;
    }

    _selectedDate = selected;
    _showTimeSlots = true;
    _showCalendar = false;
    notifyListeners();

    try {
      await fetchServiceDetails();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Servis detayları alınamadı: $e'),
        ),
      );
    }
  }

  // Seçilen Tesis ve Hizmetlere Bağlı Servis Detaylarını Çekme
  Future<void> fetchServiceDetails() async {
    if (_selectedServiceIds.isEmpty || _selectedFacilityId == null) {
      throw Exception('Lütfen bir tesis ve en az bir hizmet seçiniz.');
    }

    try {
      final response = await http.post(
        Uri.parse('https://demo.gecis360.com/api/randevu/olustur/index.php'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'tesisid': _selectedFacilityId.toString(),
          'hizmetsecim':
              _selectedServiceIds.toString(), // Virgülle ayrılmış string
          'token': _token,
        },
      );

      print('TimeSlotsPage Gelen Yanıt: ${response.body}');

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          throw Exception('API boş yanıt döndü.');
        }

        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['bilgi'] != null && jsonResponse['bilgi'] is List) {
          _selectedServices = List<Bilgi>.from(
              jsonResponse['bilgi'].map((x) => Bilgi.fromMap(x)));

          // 'randevu' listesi içerisinden mevcut randevuları çekme
          if (jsonResponse['randevu'] != null &&
              jsonResponse['randevu'] is List) {
            List<Randevu> randevuList = List<Randevu>.from(
                jsonResponse['randevu'].map((x) => Randevu.fromMap(x)));

            _existingAppointments = randevuList.where((r) {
              if (r.baslangictarihi == null) return false;
              return r.baslangictarihi!.year == _selectedDate!.year &&
                  r.baslangictarihi!.month == _selectedDate!.month &&
                  r.baslangictarihi!.day == _selectedDate!.day &&
                  _selectedServiceIds.contains(r.hizmetid);
            }).toList();
          }

          generateTimeSlots();
        } else {
          throw Exception('Beklenen formatta veri gelmedi.');
        }
      } else {
        throw Exception('Servis detayları getirilemedi.');
      }
    } catch (e) {
      print('Hata: $e');
      throw e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

////////////////////////////////////////////////////////////////////////////////////////////
  // Her hizmet için ayrı saat dilimleri oluşturma
  void generateTimeSlots() {
    if (_selectedServices.isEmpty || _selectedDate == null) return;
    // Mevcut saat dilimlerini temizle
    _serviceTimeSlots.clear();
    _servicePeriyots.clear();
    for (var hizmet in _selectedServices) {
      if (hizmet.zamanlayiciList == null || hizmet.zamanlayiciList!.isEmpty)
        continue;
      // Haftanın günü (1=Monday, ..., 7=Sunday) → Pazar 0 olmalı
      int selectedWeekday = _selectedDate!.weekday % 7;

      // Bu güne ait zamanlayıcıyı bulma
      final schedule = hizmet.zamanlayiciList!.firstWhere(
        (zaman) => zaman.gun == selectedWeekday,
        orElse: () => RandevuZamanlayici(
            gun: selectedWeekday,
            baslangicSaati: '09:00',
            bitisSaati: '17:00',
            periyot: 30), // Varsayılan değerler
      );
      // Periyot değerini al
      final periyot = schedule.periyot;
      _servicePeriyots[hizmet.hizmetId!] = periyot;
      // Başlangıç ve bitiş saatlerini parse etme
      final baslangicParts = schedule.baslangicSaati.split(':');
      final bitisParts = schedule.bitisSaati.split(':');
      if (baslangicParts.length != 2 || bitisParts.length != 2) {
        print(
            'Saat formatı hatalı: baslangic = ${schedule.baslangicSaati}, bitis = ${schedule.bitisSaati}');
        continue;
      }
      final baslangicSaat = int.tryParse(baslangicParts[0]) ?? 0;
      final baslangicDakika = int.tryParse(baslangicParts[1]) ?? 0;
      final bitisSaat = int.tryParse(bitisParts[0]) ?? 0;
      final bitisDakika = int.tryParse(bitisParts[1]) ?? 0;

      DateTime startTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        baslangicSaat,
        baslangicDakika,
      );

      DateTime endTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        bitisSaat,
        bitisDakika,
      );
      List<String> slots = [];
      while (startTime.isBefore(endTime)) {
        String formatted = DateFormat('HH:mm').format(startTime);
        slots.add(formatted);
        startTime = startTime.add(Duration(minutes: periyot));
      }
      // Mevcut randevulara göre dolu saat dilimlerini çıkarma
      Set<String> bookedSlots = _existingAppointments
          .where((r) => r.hizmetid == hizmet.hizmetId)
          .map((r) => r.baslangicsaati ?? '')
          .toSet();

      Set<String> availableSlots = slots.toSet(); // Tüm slotları göster

      // Zaman dilimlerini DateTime nesnelerine çevirme
      List<DateTime> finalTimeSlots = availableSlots.map((slot) {
        final parts = slot.split(':');
        return DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
          int.parse(parts[0]),
          int.parse(parts[1]),
        );
      }).toList()
        ..sort(); // Saat dilimlerini sırala

      _serviceTimeSlots[hizmet.hizmetId!] = finalTimeSlots;
    }

    notifyListeners();
  }

///////////////////////////////////////////////////////////////////////////
  // Takvime Dönme Fonksiyonu
  void resetToCalendar() {
    _showTimeSlots = false;
    _selectedDate = null;
    _serviceTimeSlots = {};
    _servicePeriyots = {};
    notifyListeners();
  }
}


///////////////////////////////////
///randevu 

// Future<void> fetchRandevular(DateTime selectedDate) async {
//   try {
//     // API'den randevu verilerini alın (örnek URL ve method, bunu kendi API'nize göre düzenleyin)
//     final response = await http.get(Uri.parse('https://demo.gecis360.com/api/login/index.php'));
//     if (response.statusCode == 200) {
//       // JSON verisini çözümleyin
//       Map<String, dynamic> jsonData = json.decode(response.body);
//       randevu = List<Randevu>.from(jsonData['randevu'].map((x) => Randevu.fromMap(x))).toList();
//       notifyListeners(); // Dinleyicilere güncellemeyi bildirin
//     } else {
//       throw Exception('Randevular alınamadı');
//     }
//   } catch (error) {
//     print('Hata: $error');
//   }
// }