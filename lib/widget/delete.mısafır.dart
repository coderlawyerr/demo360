// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MisafirAddPerson extends StatefulWidget {
//   const MisafirAddPerson({super.key});

//   @override
//   State<MisafirAddPerson> createState() => _MisafirAddPersonState();
// }

// class _MisafirAddPersonState extends State<MisafirAddPerson> {
//   List<Map<String,String>> misafirKartlari =[];
//   final TextEditingController tcController = TextEditingController();
//   final TextEditingController adSoyadController = TextEditingController();
//   final TextEditingController telefonController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();


//  @override
//  void initState (){
//   _loadMisafirKartlari();
//  }
// Future<void> _sendData(String tc , String adSoyad ,String telefon, String email)async{
//   final SharedPreferences prefs = await SharedPreferences getInstance();

//   ///yenı mısafır 
//   setState(() {
//     misafirKartlari.add({
//       'tc' : tc,
//       'adSoyad' : adSoyad,
//       'telefon' : telefon,
//       'email' : email,
//     });
//   });
//   await prefs.SetString('misafirBilgileri',json.encode(misasfirKartlari));

//   final url = Uri.parse("https://demo.gecis360.com/api/randevu/olustur/index.php");
//   final token = "71joQRTKKC5R86NccWJzClvNFuAj07w03rB";
//   final response = await http.post (
//     url, headers:{
//        'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//     },
//     body:json.encode({
//       'tc' : tc,
//       'adSoyad' : adSoyad,
//       'telefon' : telefon,
//       'email' : email,
//     }),
//   );
//     if (response.statusCode == 200) {
//       print('Veri başarıyla gönderildi: ${response.body}');
//     } else {
//       print('POST isteği başarısız: ${response.statusCode}');
//       print('Yanıt: ${response.body}');
//     }

// }







// Future<void> _loadMisafirKartlari() async{
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//    final String? misafrJson = prefs.getString("misafirBilgileri");
//    if (misafirJson  != null){
//     setState(() {
//       misafirKartlari = List<Map<String,String>>.from(
//        jsonDecode(misafirJson ).map(
//         (item) => Map<String,String>.from (item as Map<String,dynamic>),

       
//        ),
      
      
      
//       );
//     });
//    }
// }
//  Future<void>_removeMisafirFromPrefs(String tc)async{
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   setState(() {
//     misafirKartlari.removeWhere((misafir)=>misafir['tc'] ==tc);
//   });
//   await prefs.setString('misafirBilgileri',json.encode(misafirKartlari));
//  }
  
//   Widget _buildMisafirCard(Map<String,String>misafir){
//     final tcController = TextEditingController(text:misafir ['tc']);
//     final adSoyadController = TextEditingController(text:misafir['adSoyad']);
//     final telefonController = TextEditingController (text: misafir ['telefon']);
//      final email = TextEditingController (text: misafir ['teleemailfon']);
//     return Card(
//       elevation:10,
//       color: Colors.red,
//        child:Padding(padding: EdgeInsets.all(10),
//         child:Column(children: [
//           Text("Misafir",),
//           Row(
//             children: [
//               IconButton(onPressed: _removeMisafirFromPrefs(tcController.text),
//                icon: Icons.delete,color:Colors.red),
//             Expanded(child: Column(children: [
//                     _buildTextField(
//                           label: "Misafir TC", controller: tcController),
//                       SizedBox(height: 5),
//                       _buildTextField(
//                           label: "Ad Soyad", controller: adSoyadController),
//                       SizedBox(height: 5),
//                       _buildTextField(
//                           label: "Telefon Numarası",
//                           controller: telefonController),
//                       SizedBox(height: 5),
//                       _buildTextField(
//                           label: "E-posta", controller: emailController),
//                           ElevatedButton(onPressed: (){}, child: child)
//             ],))
//             ],
//           )
//         ],)
//        ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title:Text("Misafir Ekleme"),
//       ),
//       body: SingleChildScrollView(
//         child:Column(
//           children: [

//           ],
//         )
//       ),
//       floatingActionButton: FloatingActionButton(onPressed: (){}),
//     );
//   }
// }