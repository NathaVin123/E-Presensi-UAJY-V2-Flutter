// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:presensiblebeacon/API/APIService.dart';
// import 'package:presensiblebeacon/MODEL/Beacon/HapusBeaconModel.dart';
// import 'package:presensiblebeacon/UTILS/LoginProgressHUD.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sk_alert_dialog/sk_alert_dialog.dart';

// class AdminDetailHapusBeacon extends StatefulWidget {
//   AdminDetailHapusBeacon({Key key}) : super(key: key);

//   @override
//   _AdminDetailHapusBeaconState createState() => _AdminDetailHapusBeaconState();
// }

// class _AdminDetailHapusBeaconState extends State<AdminDetailHapusBeacon> {
//   String uuid = "";
//   String namadevice = "";

//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   bool isApiCallProcess = false;

//   GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

//   HapusBeaconRequestModel hapusBeaconRequestModel;

//   @override
//   void initState() {
//     super.initState();

//     hapusBeaconRequestModel = HapusBeaconRequestModel();

//     Timer.periodic(Duration(seconds: 1), (Timer t) {
//       getDataHapusBeacon();
//       Future.delayed(Duration(seconds: 5), () {
//         t.cancel();
//       });
//     });
//   }

//   void getDataHapusBeacon() async {
//     SharedPreferences adminHapusBeacon = await SharedPreferences.getInstance();
//     setState(() {
//       uuid = adminHapusBeacon.getString('uuid');
//       namadevice = adminHapusBeacon.getString('namadevice');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LoginProgressHUD(
//       child: buildHapusBeacon(context),
//       inAsyncCall: isApiCallProcess,
//       opacity: 0,
//     );
//   }

//   Widget buildHapusBeacon(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color.fromRGBO(23, 75, 137, 1),
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Color.fromRGBO(23, 75, 137, 1),
//           centerTitle: true,
//           title: Text(
//             'Hapus Beacon',
//             style: TextStyle(
//                 color: Colors.white,
//                 fontFamily: 'WorkSansMedium',
//                 fontWeight: FontWeight.bold),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(25)),
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Column(
//                   children: <Widget>[
//                     Form(
//                       key: globalFormKey,
//                       child: Column(
//                         children: <Widget>[
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Center(
//                               child: Text(
//                                 'UUID',
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     fontFamily: 'WorkSansMedium',
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Center(
//                               child: Text(
//                                 uuid,
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     fontFamily: 'WorkSansMedium',
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.grey),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Center(
//                               child: Text(
//                                 'Nama Perangkat',
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     fontFamily: 'WorkSansMedium',
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Center(
//                               child: Text(
//                                 namadevice,
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     fontFamily: 'WorkSansMedium',
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.grey),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           MaterialButton(
//                               color: Colors.red,
//                               shape: StadiumBorder(),
//                               padding: EdgeInsets.all(15),
//                               child: Text(
//                                 "Hapus",
//                                 style: const TextStyle(
//                                     fontFamily: 'WorkSansSemiBold',
//                                     fontSize: 18.0,
//                                     color: Colors.white),
//                               ),
//                               onPressed: () {
//                                 SKAlertDialog.show(
//                                   context: context,
//                                   type: SKAlertType.buttons,
//                                   title: 'Hapus ?',
//                                   message:
//                                       'Apakah anda yakin ingin\nmenghapus perangkat ini ?',
//                                   okBtnText: 'Ya',
//                                   okBtnTxtColor: Colors.white,
//                                   okBtnColor: Colors.red,
//                                   cancelBtnText: 'Tidak',
//                                   cancelBtnTxtColor: Colors.white,
//                                   cancelBtnColor: Colors.grey,
//                                   onOkBtnTap: (value) async {
//                                     print(hapusBeaconRequestModel.toJson());

//                                     print(uuid);

//                                     setState(() {
//                                       isApiCallProcess = true;

//                                       hapusBeaconRequestModel.uuid = uuid;
//                                       hapusBeaconRequestModel.status = '0';
//                                     });

//                                     APIService apiService = new APIService();

//                                     apiService
//                                         .hapusBeacon(hapusBeaconRequestModel)
//                                         .then((value) async {
//                                       if (value != null) {
//                                         setState(() {
//                                           isApiCallProcess = false;
//                                         });
//                                       }
//                                       Get.back();

//                                       await Fluttertoast.showToast(
//                                           msg: 'Berhasil Menghapus Beacon',
//                                           toastLength: Toast.LENGTH_SHORT,
//                                           gravity: ToastGravity.BOTTOM,
//                                           timeInSecForIosWeb: 1,
//                                           backgroundColor: Colors.green,
//                                           textColor: Colors.white,
//                                           fontSize: 14.0);
//                                     });
//                                   },
//                                   onCancelBtnTap: (value) {},
//                                 );

//                                 // try {
//                                 //   if (validateAndSave()) {
//                                 //     print(tambahBeaconRequestModel.toJson());

//                                 //     setState(() {
//                                 //       isApiCallProcess = true;
//                                 //     });

//                                 //     APIService apiService = new APIService();
//                                 //     apiService
//                                 //         .postTambahBeacon(
//                                 //             tambahBeaconRequestModel)
//                                 //         .then((value) async {
//                                 //       if (value != null) {
//                                 //         setState(() {
//                                 //           isApiCallProcess = false;
//                                 //         });

//                                 //         Get.back();

//                                 //         Fluttertoast.showToast(
//                                 //             msg:
//                                 //                 'Berhasil Menambahkan Beacon',
//                                 //             toastLength: Toast.LENGTH_SHORT,
//                                 //             gravity: ToastGravity.BOTTOM,
//                                 //             timeInSecForIosWeb: 1,
//                                 //             backgroundColor: Colors.green,
//                                 //             textColor: Colors.white,
//                                 //             fontSize: 14.0);
//                                 //       }
//                                 //     });
//                                 //   }
//                                 // } catch (error) {
//                                 //   Fluttertoast.showToast(
//                                 //       msg:
//                                 //           'Terjadi kesalahan, silahkan coba lagi',
//                                 //       toastLength: Toast.LENGTH_SHORT,
//                                 //       gravity: ToastGravity.BOTTOM,
//                                 //       timeInSecForIosWeb: 1,
//                                 //       backgroundColor: Colors.red,
//                                 //       textColor: Colors.white,
//                                 //       fontSize: 14.0);
//                                 // }
//                               }),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }

//   bool validateAndSave() {
//     final form = globalFormKey.currentState;
//     if (form.validate()) {
//       form.save();
//       return true;
//     }
//     return false;
//   }

//   // _fieldFocusChange(
//   //     BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
//   //   currentFocus.unfocus();
//   //   FocusScope.of(context).requestFocus(nextFocus);
//   // }
// }
