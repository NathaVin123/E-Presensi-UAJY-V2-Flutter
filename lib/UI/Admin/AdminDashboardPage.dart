import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

// import 'package:presensiblebeacon/UI/Admin/Menu/MenuAdminDashboardPage.dart'
//     as Menu;

// import 'package:presensiblebeacon/UI/Admin/Akun/AkunAdminDashboardPage.dart'
//     as Akun;

import 'package:presensiblebeacon/UI/Admin/BeaconDashboardPage.dart' as Beacon;

import 'package:presensiblebeacon/UI/Admin/RuanganDashboardPage.dart'
    as Ruangan;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sk_alert_dialog/sk_alert_dialog.dart';

class AdminDashboardPage extends StatefulWidget {
  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

// class _AdminDashboardPageState extends State<AdminDashboardPage>
//     with SingleTickerProviderStateMixin {
class _AdminDashboardPageState extends State<AdminDashboardPage> {
  int index = 0;

  String npp = "";
  String namaadm = "";

  final screens = [
    new Beacon.BeaconDashboardPage(),
    new Ruangan.RuanganDashboardPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  getDataAdmin() async {
    SharedPreferences loginAdmin = await SharedPreferences.getInstance();
    setState(() {
      npp = loginAdmin.getString('npp');
      namaadm = loginAdmin.getString('namaadm');
    });
  }

  @override
  Widget build(BuildContext context) {
    getDataAdmin();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor: Colors.blue[200],
              labelTextStyle: MaterialStateProperty.all(TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans'))),
          child: NavigationBar(
            height: 65,
            backgroundColor: Colors.blue[100],
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            selectedIndex: index,
            animationDuration: Duration(seconds: 1),
            onDestinationSelected: (index) =>
                setState(() => this.index = index),
            destinations: [
              NavigationDestination(
                  icon: Icon(Icons.bluetooth_outlined),
                  selectedIcon: Icon(
                    Icons.bluetooth_rounded,
                    color: Colors.black,
                  ),
                  label: 'Pengaturan Beacon'),
              NavigationDestination(
                  icon: Icon(Icons.door_sliding_outlined),
                  selectedIcon: Icon(
                    Icons.door_sliding,
                    color: Colors.black,
                  ),
                  label: 'Pengaturan Ruangan')
            ],
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 40, left: 14),
                    child: Initicon(
                      text: namaadm ?? '-',
                      backgroundColor: Colors.grey[400],
                      size: 80,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(namaadm ?? '-',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans',
                                      fontSize: 18)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            npp ?? '-',
                            style:
                                TextStyle(fontFamily: 'OpenSans', fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey,
              ),
            ),
            // ListTile(
            //   title: Row(
            //     children: [
            //       Icon(
            //         Icons.person,
            //         color: Colors.black,
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text(
            //         'Informasi Akun',
            //         style: TextStyle(
            //             fontSize: 18,
            //             color: Colors.black,
            //             fontFamily: 'OpenSans',
            //             fontWeight: FontWeight.bold),
            //       ),
            //     ],
            //   ),
            //   onTap: () {
            //     Get.toNamed('/dosen/dashboard/akun/informasi');
            //   },
            // ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.info_rounded,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Tentang',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onTap: () {
                Get.toNamed('/tentang');
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Keluar',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onTap: () {
                SKAlertDialog.show(
                  context: context,
                  type: SKAlertType.buttons,
                  title: 'KELUAR',
                  message: 'Apakah anda yakin ingin keluar?',
                  okBtnText: 'Ya',
                  okBtnTxtColor: Colors.white,
                  okBtnColor: Colors.red,
                  cancelBtnText: 'Tidak',
                  cancelBtnTxtColor: Colors.white,
                  cancelBtnColor: Colors.grey,
                  onOkBtnTap: (value) async {
                    SharedPreferences autoLogin =
                        await SharedPreferences.getInstance();
                    autoLogin.clear();

                    Get.offAllNamed('/');

                    Fluttertoast.showToast(
                        msg: 'Anda telah keluar',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 14.0);
                  },
                  onCancelBtnTap: (value) {},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
