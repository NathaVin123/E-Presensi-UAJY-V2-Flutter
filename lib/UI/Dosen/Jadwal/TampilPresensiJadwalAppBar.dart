import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presensiblebeacon/UI/Dosen/Jadwal/PresensiManual/MahasiswaPresensiManualPage.dart'
    as TampilMahasiswa;
import 'package:presensiblebeacon/UI/Dosen/Jadwal/PresensiManual/DosenPresensiManualPage.dart'
    as TampilDosen;

class TampilPresensiJadwalAppBar extends StatefulWidget {
  TampilPresensiJadwalAppBar({Key key}) : super(key: key);

  @override
  State<TampilPresensiJadwalAppBar> createState() =>
      _TampilPresensiJadwalAppBarState();
}

class _TampilPresensiJadwalAppBarState
    extends State<TampilPresensiJadwalAppBar> {
  int index = 0;

  final screens = [
    // TampilHadir.DosenTampilKehadiranPesertaKelasPageTes(),
    TampilDosen.DosenPresensiManualPage(),
    TampilMahasiswa.MahasiswaPresensiManualPage(),
  ];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  icon: Icon(Icons.person_outlined),
                  selectedIcon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  label: 'Dosen'),
              NavigationDestination(
                label: 'Mahasiswa',
                icon: Icon(Icons.person_outlined),
                selectedIcon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
