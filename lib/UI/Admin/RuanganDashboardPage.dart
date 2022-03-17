import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class RuanganDashboardPage extends StatefulWidget {
  RuanganDashboardPage({Key key}) : super(key: key);

  @override
  State<RuanganDashboardPage> createState() => _RuanganDashboardPageState();
}

class _RuanganDashboardPageState extends State<RuanganDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Pengaturan Ruangan',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans'),
          ),
          backgroundColor: Colors.blue[100],
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }),
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
                    // onTap: () => Get.toNamed('/admin/menu/ruangan/menu'),
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                left: 14, right: 14, bottom: 14),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(25),
                              onTap: () =>
                                  Get.toNamed('/admin/menu/ruangan/tampil'),
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
                                            'Tampil Ruangan',
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
                              onTap: () => Get.toNamed('/admin/menu/ruangan/'),
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
                                            'Ubah Perangkat Ruangan',
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
                                  {Get.toNamed('/admin/menu/ruangan/hapus')},
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
