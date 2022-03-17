import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BeaconDashboardPage extends StatefulWidget {
  BeaconDashboardPage({Key key}) : super(key: key);

  @override
  State<BeaconDashboardPage> createState() => _BeaconDashboardPageState();
}

class _BeaconDashboardPageState extends State<BeaconDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Pengaturan Beacon',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans'),
          ),
          backgroundColor: Colors.blue[100],
          leading: IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }),
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
          decoration: BoxDecoration(color: Colors.grey[50]),
          // decoration: BoxDecoration(color: Colors.black),
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    // onTap: () => Get.toNamed('/admin/menu/beacon'),
                    child: Column(
                      children: [
                        GetPlatform.isAndroid != null
                            ? Container(
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(25),
                                      onTap: () => Get.toNamed(
                                          '/admin/menu/beacon/pindai'),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[500],
                                                  offset: Offset(0.0, 0.0),
                                                  blurRadius: 0.75,
                                                  spreadRadius: 0.25)
                                            ],
                                            color: Colors.white,
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
                                                        fontFamily: 'OpenSans',
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
                              )
                            : SizedBox(
                                height: 0,
                              ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 14, right: 14, bottom: 14),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(25),
                              onTap: () =>
                                  Get.toNamed('/admin/menu/beacon/tampil'),
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[500],
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 0.75,
                                          spreadRadius: 0.25)
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25)),
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
                                                fontFamily: 'OpenSans',
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
                            padding: EdgeInsets.only(
                                left: 14, right: 14, bottom: 14),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(25),
                              onTap: () =>
                                  Get.toNamed('/admin/menu/beacon/tambah'),
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[500],
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 0.75,
                                          spreadRadius: 0.25)
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25)),
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
                                                fontFamily: 'OpenSans',
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
                            padding: EdgeInsets.only(
                                left: 14, right: 14, bottom: 14),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(25),
                              onTap: () =>
                                  Get.toNamed('/admin/menu/beacon/ubah'),
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[500],
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 0.75,
                                          spreadRadius: 0.25)
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25)),
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
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}
