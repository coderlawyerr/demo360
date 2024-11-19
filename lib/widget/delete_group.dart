

// import 'package:armiyaapp/model/uyegruplari.dart';
// import 'package:armiyaapp/providers/appoinment/appoinment_provider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class GroupAdd extends StatefulWidget {
//   const GroupAdd({Key? key ,required this.selectedServicesIds}) : super(key:key);
//    final List<int> selectedServicesIds;
//   @override
//   State<GroupAdd> createState() => _GroupAddState();
// }

// class _GroupAddState extends State<GroupAdd> {
//   List<Uyegruplari> uyegruplari = [];
//   bool isLoading = true;
//   String ? erorr;
//   Uyegruplari? selectedGroup;

//   @override
//   void initState(){
//     super.initState();
//     _fetchGroups();
//   }
 
//  Future<void>_fetchGroups()async{
//   try{
//     setSteate((){
//       isLoading = true;
//       error = null;
//     });
//     final response = await AppointmnetService().fetchGroupDetails(
//     selectedFacilityId :AppointmentProvider().selectedFacility ??0,
//     selectedServiceIds:widget.selectedServicesIds,
    
//     );
//     if(response !=null && response.uyegruplari != null){
//       setState(() {
//         uyegrupları =reesponse.uyegruplari !
//         .whereType<Uyegruplari>()
//         .where((group) => group != null)
//         .toList();
//         isLoading =false ;
//       });
//     }else{
//       setState(() {
        
//       });
//     }
//   }
//  }









//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: Appbar(
//         title : Text('GROUP EKLE'),
       
//       ),
//       body:_buildBody();
//     );
//   }


//   Widget _buildBody(){
//     if(isLoading){
//       return Center(child: CircularProgressIndicator(),);
//     }

//   if(erorr != null){
//     return Center(
//       child:Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//          Text(error!),
//          const SizedBox(height: 16,),
//          ElevatedButton(
//           onPressed: _fetchGroups,
//            child: Text('Tekrar Dene'),
//          ),
//         ],
//       ),
    
//     ),
    
//   }
//   if(uyegruplari.isEmpty){
//     return Center(child:Text("heuz grup ekelenmdı"))
//   }

//   return ListView.builder(
//    shrinkWrap: true,
//    itemCount: uyegruplar,
  