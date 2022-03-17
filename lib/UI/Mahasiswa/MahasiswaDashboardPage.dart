import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:presensiblebeacon/UI/Mahasiswa/Presensi/MahasiswaPresensiDashboardPage.dart'
    as Presensi;
import 'package:presensiblebeacon/UI/Mahasiswa/Jadwal/MahasiswaJadwalDashboardPage.dart'
    as Jadwal;
import 'package:presensiblebeacon/UI/Mahasiswa/Riwayat/MahasiswaRiwayatDashboardPage.dart'
    as Riwayat;
// import 'package:presensiblebeacon/UI/Mahasiswa/Akun/MahasiswaAkunDashboardPage.dart'
//     as Akun;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sk_alert_dialog/sk_alert_dialog.dart';

class MahasiswaDashboardPage extends StatefulWidget {
  @override
  _MahasiswaDashboardPageState createState() => _MahasiswaDashboardPageState();
}

// class _MahasiswaDashboardPageState extends State<MahasiswaDashboardPage>
//     with SingleTickerProviderStateMixin {
class _MahasiswaDashboardPageState extends State<MahasiswaDashboardPage> {
  int index = 1;

  String npm = "";
  String namamhs = "";

  final screens = [
    new Jadwal.MahasiswaJadwalDashboardPage(),
    new Presensi.MahasiswaPresensiDashboardPage(),
    new Riwayat.MahasiswaRiwayatDashboardPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  getDataMahasiswa() async {
    SharedPreferences loginMahasiswa = await SharedPreferences.getInstance();

    setState(() {
      npm = loginMahasiswa.getString('npm');
      namamhs = loginMahasiswa.getString('namamhs');
    });
  }

  @override
  Widget build(BuildContext context) {
    getDataMahasiswa();
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
                  icon: Icon(Icons.schedule_outlined),
                  selectedIcon: Icon(
                    Icons.schedule,
                    color: Colors.black,
                  ),
                  label: 'Jadwal'),
              NavigationDestination(
                  icon: Icon(Icons.arrow_upward_outlined),
                  selectedIcon: Icon(
                    Icons.arrow_upward,
                    color: Colors.black,
                  ),
                  label: 'Presensi'),
              NavigationDestination(
                  icon: Icon(Icons.history_outlined),
                  selectedIcon: Icon(Icons.history, color: Colors.black),
                  label: 'Riwayat'),
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
                      text: namamhs ?? '-',
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
                              child: Text(namamhs ?? '-',
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
                            npm ?? '-',
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
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Informasi Akun',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onTap: () {
                Get.toNamed('/mahasiswa/dashboard/akun/informasi');
              },
            ),
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
