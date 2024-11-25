import 'package:armiyaapp/model/hizmet_bilgisi.dart';
import 'package:armiyaapp/model/kullanici_bilgisi.dart';
import 'package:armiyaapp/model/tesisbilgisi.dart';

class DenemeCard {
  hizmetbilgisi? hizmetbilgisimodel;
  kullanicibilgisi? kullanicibilgisimodel;
  tesisbilgisi? tesisbilgisimodel;

  DenemeCard({
    this.hizmetbilgisimodel,
    this.kullanicibilgisimodel,
    this.tesisbilgisimodel,
  });
}
