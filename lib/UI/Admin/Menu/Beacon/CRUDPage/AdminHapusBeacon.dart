// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:presensiblebeacon/API/APIService.dart';
// import 'package:presensiblebeacon/MODEL/Beacon/ListBeaconModel.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AdminHapusBeacon extends StatefulWidget {
//   AdminHapusBeacon({Key key}) : super(key: key);

//   @override
//   _AdminHapusBeaconState createState() => _AdminHapusBeaconState();
// }

// class _AdminHapusBeaconState extends State<AdminHapusBeacon> {
//   ListBeaconResponseModel listBeaconResponseModel;

//   List<Data> beaconListSearch = List<Data>();

//   @override
//   void initState() {
//     super.initState();

//     listBeaconResponseModel = ListBeaconResponseModel();

//     Timer.periodic(Duration(seconds: 1), (Timer t) {
//       getListBeacon();
//       Future.delayed(Duration(seconds: 5), () {
//         t.cancel();
//       });
//     });
//   }

//   void getListBeacon() async {
//     setState(() {
//       print(listBeaconResponseModel.toJson());

//       APIService apiService = new APIService();

//       apiService.getListBeacon().then((value) async {
//         listBeaconResponseModel = value;

//         beaconListSearch = value.data;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Color.fromRGBO(23, 75, 137, 1),
//         centerTitle: true,
//         title: Text(
//           'Hapus Beacon',
//           style: TextStyle(
//               color: Colors.white,
//               fontFamily: 'WorkSansMedium',
//               fontWeight: FontWeight.bold),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => getListBeacon(),
//         label: Text(
//           'Segarkan',
//           style: TextStyle(
//               fontWeight: FontWeight.bold, fontFamily: 'WorkSansMedium'),
//         ),
//         icon: Icon(Icons.search_rounded),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
//       backgroundColor: Color.fromRGBO(23, 75, 137, 1),
//       body: listBeaconResponseModel.data == null
//           ? Container(
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       CircularProgressIndicator(
//                         color: Colors.white,
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         'Mohon Tunggu..',
//                         style: TextStyle(
//                             fontSize: 15,
//                             fontFamily: 'WorkSansMedium',
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                       Text(
//                         'Silakan tekan tombol "Segarkan" jika bermasalah',
//                         style: TextStyle(
//                             fontSize: 15,
//                             fontFamily: 'WorkSansMedium',
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           : Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Colors.grey[200],
//                         borderRadius: BorderRadius.circular(25)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           hintText: 'Cari Beacon',
//                           border: InputBorder.none,
//                           focusedBorder: InputBorder.none,
//                           enabledBorder: InputBorder.none,
//                           errorBorder: InputBorder.none,
//                           disabledBorder: InputBorder.none,
//                         ),
//                         style: const TextStyle(
//                             fontFamily: 'WorkSansSemiBold',
//                             fontSize: 16.0,
//                             color: Colors.black),
//                         onChanged: (text) {
//                           text = text.toLowerCase();
//                           setState(() {
//                             beaconListSearch =
//                                 listBeaconResponseModel.data.where((beacon) {
//                               var namabeacon = beacon.namadevice.toLowerCase();
//                               return namabeacon.contains(text);
//                             }).toList();
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                       itemCount: beaconListSearch?.length,
//                       itemBuilder: (context, index) {
//                         if (beaconListSearch[index].status == 1 ||
//                             beaconListSearch[index].status == null) {
//                           return Padding(
//                             padding: const EdgeInsets.only(
//                                 left: 12, right: 12, top: 8, bottom: 8),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.grey[200],
//                                   borderRadius: BorderRadius.circular(25)),
//                               child: new ListTile(
//                                 title: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       new Text(
//                                         beaconListSearch[index].namadevice,
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontFamily: 'WorkSansMedium',
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       new Text(
//                                         'UUID',
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           fontFamily: 'WorkSansMedium',
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       new Text(
//                                         beaconListSearch[index].uuid,
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           fontFamily: 'WorkSansMedium',
//                                         ),
//                                       ),
//                                       new Text(
//                                         'Jarak Minimal',
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           fontFamily: 'WorkSansMedium',
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       new Text(
//                                         '${beaconListSearch[index].jarakmin} m',
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           fontFamily: 'WorkSansMedium',
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 onTap: () async {
//                                   SharedPreferences adminHapusBeacon =
//                                       await SharedPreferences.getInstance();

//                                   await adminHapusBeacon.setString(
//                                       'uuid', beaconListSearch[index].uuid);

//                                   await adminHapusBeacon.setString('namadevice',
//                                       beaconListSearch[index].namadevice);

//                                   await Get.toNamed(
//                                       '/admin/menu/beacon/detail/hapus');
//                                 },
//                               ),
//                             ),
//                           );
//                         } else
//                           return SizedBox(
//                             height: 0,
//                           );
//                       }),
//                 ),
//               ],
//             ),
//       //     )
//       //   ],
//       // ),
//     );
//   }
// }
