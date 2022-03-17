// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_blue/flutter_blue.dart';
// import 'package:presensiblebeacon/UI/Login/LoginPage.dart';
// // import 'package:system_settings/system_settings.dart';

// class BluetoothOff extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: StreamBuilder<BluetoothState>(
//           stream: FlutterBlue.instance.state,
//           initialData: BluetoothState.unknown,
//           builder: (c, snapshot) {
//             final state = snapshot.data;
//             if (state == BluetoothState.on) {
//               return LoginPage();
//             }
//             return BluetoothOffScreen(state: state);
//           }),
//     );
//   }
// }

// class BluetoothOffScreen extends StatelessWidget {
//   const BluetoothOffScreen({Key key, this.state}) : super(key: key);

//   final BluetoothState state;

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//     return Container(
//       color: Color.fromRGBO(23, 75, 137, 1),
//       child: Center(
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(25),
//             boxShadow: [
//               BoxShadow(
//                   color: Theme.of(context).hintColor.withOpacity(0.2),
//                   offset: Offset(0, 10),
//                   blurRadius: 20)
//             ],
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Icon(
//                   Icons.bluetooth_disabled,
//                   size: 150.0,
//                   color: Colors.red,
//                 ),
//                 // Text('Bluetooth dalam keadaan mati,',
//                 //     style: TextStyle(
//                 //         decoration: TextDecoration.none,
//                 //         fontFamily: 'WorkSansMedium',
//                 //         fontSize: 16.0,
//                 //         fontWeight: FontWeight.bold,
//                 //         color: Colors.black)),
//                 Text('Silahkan aktifkan bluetooth anda,',
//                     style: TextStyle(
//                         decoration: TextDecoration.none,
//                         fontFamily: 'WorkSansMedium',
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black)),
//                 Text('lalu kembali ke aplikasi.',
//                     style: TextStyle(
//                         decoration: TextDecoration.none,
//                         fontFamily: 'WorkSansMedium',
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black)),
//                 SizedBox(
//                   height: 25,
//                 ),
//                 // MaterialButton(
//                 //   shape: RoundedRectangleBorder(
//                 //     borderRadius: BorderRadius.circular(25),
//                 //   ),
//                 //   onPressed: () => SystemSettings.bluetooth(),
//                 //   color: Colors.blue[600],
//                 //   padding: EdgeInsets.all(10.0),
//                 //   child: Column(
//                 //     // Replace with a Row for horizontal icon + text
//                 //     children: <Widget>[
//                 //       // Icon(
//                 //       //   Icons.bluetooth_connected_rounded,
//                 //       //   color: Colors.white,
//                 //       // ),
//                 //       Padding(
//                 //         padding: EdgeInsets.all(10),
//                 //         child: Text("Aktifkan",
//                 //             style: TextStyle(
//                 //               color: Colors.white,
//                 //               fontSize: 20,
//                 //               fontFamily: 'WorkSansSemiBold',
//                 //             )),
//                 //       )
//                 //     ],
//                 //   ),
//                 // )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
