import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AdminMenuBeaconPage extends StatefulWidget {
  @override
  _AdminMenuBeaconPageState createState() => _AdminMenuBeaconPageState();
}

class _AdminMenuBeaconPageState extends State<AdminMenuBeaconPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(23, 75, 137, 1),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(23, 75, 137, 1),
          centerTitle: true,
          title: Text(
            'Pengaturan Beacon',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'WorkSansMedium',
                fontWeight: FontWeight.bold),
                
          ),
          actions: [
              FutureBuilder(
                future: Connectivity().checkConnectivity(),
                builder: (BuildContext context,
                    AsyncSnapshot<ConnectivityResult> snapshot) {
                  if (snapshot.data == ConnectivityResult.wifi) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        Icons.wifi_rounded,
                        color: Colors.green,
                      ),
                    );
                  } else if (snapshot.data == ConnectivityResult.mobile) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        Icons.signal_cellular_4_bar_rounded,
                        color: Colors.green,
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        Icons.signal_cellular_off_rounded,
                        color: Colors.red,
                      ),
                    );
                  }
                },
              )
            ],
        ),
        body: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 14, right: 14, bottom: 14),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () => Get.toNamed('/admin/menu/beacon/pindai'),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(25)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 24, right: 20, top: 20, bottom: 20),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.search,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 11,
                                    ),
                                    Text(
                                      'Pindai Beacon',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'WorkSansMedium',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 14, right: 14, bottom: 14),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () => Get.toNamed('/admin/menu/beacon/tampil'),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(25)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 24, right: 20, top: 20, bottom: 20),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.list,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 11,
                                    ),
                                    Text(
                                      'Tampil Beacon',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'WorkSansMedium',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 14, right: 14, bottom: 14),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () => Get.toNamed('/admin/menu/beacon/tambah'),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(25)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 24, right: 20, top: 20, bottom: 20),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.plus,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 11,
                                    ),
                                    Text(
                                      'Tambah Beacon',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'WorkSansMedium',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 14, right: 14, bottom: 14),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () => Get.toNamed('/admin/menu/beacon/ubah'),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(25)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 24, right: 20, top: 20, bottom: 20),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.edit,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 11,
                                    ),
                                    Text(
                                      'Ubah Beacon',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'WorkSansMedium',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  // Padding(
                  //     padding: EdgeInsets.only(left: 14, right: 14, bottom: 14),
                  //     child: InkWell(
                  //       borderRadius: BorderRadius.circular(25),
                  //       onTap: () => Get.toNamed('/admin/menu/beacon/hapus'),
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //             color: Colors.grey[200],
                  //             borderRadius: BorderRadius.circular(25)),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: <Widget>[
                  //             Padding(
                  //               padding: EdgeInsets.only(
                  //                   left: 24, right: 20, top: 20, bottom: 20),
                  //               child: Row(
                  //                 children: [
                  //                   Icon(
                  //                     FontAwesomeIcons.trash,
                  //                     color: Colors.black,
                  //                     size: 20,
                  //                   ),
                  //                   SizedBox(
                  //                     width: 11,
                  //                   ),
                  //                   Text(
                  //                     'Hapus Beacon',
                  //                     style: TextStyle(
                  //                         fontSize: 20,
                  //                         fontFamily: 'WorkSansMedium',
                  //                         fontWeight: FontWeight.bold),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     )),
                ],
              ),
            ),
          ],
        ));
  }
}
