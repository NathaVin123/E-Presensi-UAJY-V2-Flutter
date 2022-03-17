import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MenuAdminDashboardPage extends StatefulWidget {
  MenuAdminDashboardPage({Key key}) : super(key: key);

  @override
  _MenuAdminDashboardPageState createState() => _MenuAdminDashboardPageState();
}

class _MenuAdminDashboardPageState extends State<MenuAdminDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'ADMIN',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontFamily: 'WorkSansMedium'),
          ),
          backgroundColor: Color.fromRGBO(23, 75, 137, 1),
          elevation: 0,
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
        body: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(23, 75, 137, 1)),
          // decoration: BoxDecoration(color: Colors.black),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 14, right: 14, bottom: 14),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      // onTap: () => Get.toNamed('/admin/menu/beacon'),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 24,
                                        right: 20,
                                        top: 20,
                                        bottom: 20),
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.bluetooth,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 11,
                                        ),
                                        Text(
                                          'Pengaturan Beacon',
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
                            ExpansionTile(
                              title: Text(
                                'Lihat lebih detail',
                                style: TextStyle(
                                    fontFamily: 'WorkSansMedium',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                              children: [
                                GetPlatform.isAndroid != null
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: 14, right: 14, bottom: 14),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          onTap: () => Get.toNamed(
                                              '/admin/menu/beacon/pindai'),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 24,
                                                      right: 20,
                                                      top: 20,
                                                      bottom: 20),
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
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'WorkSansMedium',
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))
                                    : SizedBox(
                                        height: 0,
                                      ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 14, right: 14, bottom: 14),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(25),
                                      onTap: () => Get.toNamed(
                                          '/admin/menu/beacon/tampil'),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 24,
                                                  right: 20,
                                                  top: 20,
                                                  bottom: 20),
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
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'WorkSansMedium',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 14, right: 14, bottom: 14),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(25),
                                      onTap: () => Get.toNamed(
                                          '/admin/menu/beacon/tambah'),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 24,
                                                  right: 20,
                                                  top: 20,
                                                  bottom: 20),
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
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'WorkSansMedium',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 14, right: 14, bottom: 14),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(25),
                                      onTap: () => Get.toNamed(
                                          '/admin/menu/beacon/ubah'),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 24,
                                                  right: 20,
                                                  top: 20,
                                                  bottom: 20),
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
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'WorkSansMedium',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 14, right: 14, bottom: 14),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      // onTap: () => Get.toNamed('/admin/menu/ruangan/menu'),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 24, right: 20, top: 20, bottom: 20),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.room_preferences_outlined,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 11,
                                      ),
                                      Text(
                                        'Pengaturan Ruangan',
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
                            ExpansionTile(
                              title: Text(
                                'Lihat lebih detail',
                                style: TextStyle(
                                    fontFamily: 'WorkSansMedium',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 14, right: 14, bottom: 14),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(25),
                                      onTap: () => Get.toNamed(
                                          '/admin/menu/ruangan/tampil'),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 24,
                                                  right: 20,
                                                  top: 20,
                                                  bottom: 20),
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
                                                    'Tampil Perangkat Ruangan',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'WorkSansMedium',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 14, right: 14, bottom: 14),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(25),
                                      onTap: () =>
                                          Get.toNamed('/admin/menu/ruangan/'),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 24,
                                                  right: 20,
                                                  top: 20,
                                                  bottom: 20),
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
                                                    'Ubah Perangkat Ruangan',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'WorkSansMedium',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 14, right: 14, bottom: 14),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(25),
                                      onTap: () => {
                                        Get.toNamed('/admin/menu/ruangan/hapus')
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 24,
                                                  right: 20,
                                                  top: 20,
                                                  bottom: 20),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons.trash,
                                                    color: Colors.black,
                                                    size: 20,
                                                  ),
                                                  SizedBox(
                                                    width: 11,
                                                  ),
                                                  Text(
                                                    'Hapus Perangkat Ruangan',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'WorkSansMedium',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                  height: 900,
                )
                // Padding(
                //     padding: EdgeInsets.only(left: 14, right: 14, bottom: 14),
                //     child: InkWell(
                //       borderRadius: BorderRadius.circular(25),
                //       onTap: () => {},
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
                //                     FontAwesomeIcons.edit,
                //                     color: Colors.black,
                //                     size: 20,
                //                   ),
                //                   SizedBox(
                //                     width: 11,
                //                   ),
                //                   Text(
                //                     'Ubah Jadwal Kelas',
                //                     style: TextStyle(
                //                         fontSize: 16,
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
        ));
  }
}
