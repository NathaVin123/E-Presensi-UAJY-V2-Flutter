import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AdminMenuRuanganPage extends StatefulWidget {
  AdminMenuRuanganPage({Key key}) : super(key: key);

  @override
  _AdminMenuRuanganPageState createState() => _AdminMenuRuanganPageState();
}

class _AdminMenuRuanganPageState extends State<AdminMenuRuanganPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(23, 75, 137, 1),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(23, 75, 137, 1),
          centerTitle: true,
          title: Text(
            'Pengaturan Ruangan',
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
                        onTap: () => Get.toNamed('/admin/menu/ruangan/tampil'),
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
                                      'Tampil Perangkat Ruangan',
                                      style: TextStyle(
                                          fontSize: 16,
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
                        onTap: () => Get.toNamed('/admin/menu/ruangan/'),
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
                                      'Ubah Perangkat Ruangan',
                                      style: TextStyle(
                                          fontSize: 16,
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
                        onTap: () => {Get.toNamed('/admin/menu/ruangan/hapus')},
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
                ],
              ),
            ),
          ],
        ));
  }
}
