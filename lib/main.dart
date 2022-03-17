import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:presensiblebeacon/UI/Admin/AdminDashboardPage.dart';
import 'package:presensiblebeacon/UI/Dosen/Jadwal/PresensiManual/MahasiswaPresensiManualDetailPage.dart';
import 'package:presensiblebeacon/UI/Dosen/Presensi/Detail/TampilPesertaKelas/DosenAnulirPresensiPage.dart';
import 'package:presensiblebeacon/UI/Dosen/Presensi/Detail/TampilPesertaKelas/DosenTampilKehadiranPesertaKelasPage%20copy.dart';
import 'package:presensiblebeacon/UI/Dosen/Riwayat/TampilPresensiAppBar.dart';
import 'package:presensiblebeacon/UI/Login/LoginAdmin.dart';
import 'package:presensiblebeacon/UI/Admin/Menu/Beacon/CRUDPage/AdminTampilListBeacon.dart';
import 'package:presensiblebeacon/UI/Admin/Menu/Ruangan/AdminHapusRuanganPage.dart';
import 'package:presensiblebeacon/UI/Admin/Menu/Ruangan/AdminMenuRuanganPage.dart';
import 'package:presensiblebeacon/UI/Admin/Menu/Ruangan/AdminUbahRuanganPage.dart';
import 'package:presensiblebeacon/UI/Admin/Menu/Ruangan/AdminTampilRuanganpage.dart';
import 'package:presensiblebeacon/UI/Admin/Menu/Ruangan/Detail/AdminUbahDetailRuanganPage.dart';
// import 'package:presensiblebeacon/UI/Dosen/Presensi/Detail/DosenDetailListKelas.dart';
// import 'package:presensiblebeacon/UI/Dosen/Presensi/Detail/DosenDetailPresensiPage.dart';
import 'package:presensiblebeacon/UI/Dosen/Presensi/Detail/TampilPesertaKelas/DosenTampilKehadiranPesertaKelasPage.dart';
import 'package:presensiblebeacon/UI/Fungsi/PindaiKelasDosenPage.dart';

import 'UI/Admin/Menu/Beacon/CRUDPage/Detail/AdminDetailUbahBeacon.dart';
import 'UI/Admin/Menu/Beacon/CRUDPage/AdminPindaiBeacon.dart';
import 'UI/Admin/Menu/Beacon/CRUDPage/AdminTambahBeacon.dart';
import 'UI/Admin/Menu/Beacon/CRUDPage/AdminUbahBeacon.dart';
import 'UI/Admin/Menu/Beacon/AdminMenuBeaconPage.dart';
import 'UI/Dosen/Jadwal/TampilPresensiJadwalAppBar.dart';
import 'UI/Login/SplashPage.dart';

import 'UI/Fungsi/PindaiKelasMahasiswaPage.dart';

import 'UI/Login/LoginPage.dart';
import 'UI/Login/LoginWidgets/LoginDosen.dart';
import 'UI/Login/LoginWidgets/LoginMahasiswa.dart';

import 'UI/Mahasiswa/MahasiswaDashboardPage.dart';

import 'UI/Mahasiswa/Presensi/MahasiswaPresensiDashboardPage.dart';
// import 'UI/Mahasiswa/Presensi/Detail/MahasiswaDetailPresensiPage.dart';

import 'UI/Mahasiswa/Presensi/Detail/TampilPesertaKelas/MahasiswaTampilPesertaKelasPage.dart';

import 'UI/Mahasiswa/Jadwal/MahasiswaJadwalDashboardPage.dart';
// import 'UI/Mahasiswa/Jadwal/Detail/MahasiswaDetailJadwalPage.dart';

import 'UI/Mahasiswa/Riwayat/MahasiswaRiwayatDashboardPage.dart';
// import 'UI/Mahasiswa/Riwayat/Detail/MahasiswaDetailRiwayatPage.dart';

import 'UI/Mahasiswa/Akun/MahasiswaAkunDashboardPage.dart';
import 'UI/Mahasiswa/Akun/Informasi Akun/MahasiswaInformasiAkunPage.dart';
// import 'UI/Mahasiswa/Akun/Statistik/MahasiswaStatistikPage.dart';

import 'UI/Dosen/DosenDashboardPage.dart';

import 'UI/Dosen/Presensi/DosenPresensiDashboardPage.dart';
import 'UI/Dosen/Presensi/Detail/TampilPesertaKelas/DosenTampilPesertaKelasPage.dart';
// import 'UI/Dosen/Presensi/Notifikasi/DosenNotifikasiPresensiPage.dart';

import 'UI/Dosen/Jadwal/DosenJadwalDashboardPage.dart';
// import 'UI/Dosen/Jadwal/Detail/DosenDetailJadwalPage.dart';

import 'UI/Dosen/Riwayat/DosenRiwayatDashboardPage.dart';
// import 'UI/Dosen/Riwayat/Detail/DosenDetailRiwayatPage.dart';

import 'UI/Dosen/Akun/DosenAkunDashboardPage.dart';

import 'UI/Dosen/Akun/InformasiAkun/DosenInformasiAkunPage.dart';

// import 'UI/Dosen/Akun/Statistik/DosenStatistikPage.dart';

import 'UI/Tentang/TentangPage.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class _MyAppState extends State<MyApp> {
  DateTime timeBackPressed = DateTime.now();

  @override
  void initState() {
    super.initState();
    flutterBeacon.openBluetoothSettings;
    requestLocationPermission();
  }

  // Fungsi Lama
  // Future<bool> _requestPermission(PermissionGroup permission) async {
  //   final PermissionHandler _permissionHandler = PermissionHandler();
  //   var result = await _permissionHandler.requestPermissions([permission]);
  //   if (result[permission] == PermissionStatus.granted) {
  //     return true;
  //   }
  //   return false;
  // }

  Future<bool> _requestPermission(Permission permission) async {
    final status = await permission.request();

    if (status == PermissionStatus.granted) {
      return true;
    }

    return false;
  }

  Future<bool> requestLocationPermission({Function onPermissionDenied}) async {
    var granted = await _requestPermission(Permission.location);
    if (granted != true) {
      requestLocationPermission();
    }
    debugPrint('requestContactsPermission $granted');
    return granted;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final difference = DateTime.now().difference(timeBackPressed);
          final isExitWarning = difference >= Duration(seconds: 2);

          timeBackPressed = DateTime.now();

          if (isExitWarning) {
            final message = 'Tekan tombol kembali lagi untuk keluar';
            Fluttertoast.showToast(msg: message);
            return false;
          } else {
            Fluttertoast.cancel();

            return true;
          }
        },
        child: GetMaterialApp(
          title: 'Presensi BLE Beacon',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          // home: SplashPage(),
          initialRoute: '/',
          getPages: [
            // Splash Page
            GetPage(name: '/', page: () => SplashPage()),
            // BluetoothOff Page
            // GetPage(
            //   name: '/bluetooth',
            //   page: () => BluetoothOff(),
            // ),
            GetPage(
              name: '/pindaiMahasiswa',
              page: () => PindaiKelasMahasiswaPage(),
            ),
            GetPage(
              name: '/pindaiDosen',
              page: () => PindaiKelasDosenPage(),
            ),
            // Login Page
            GetPage(
              name: '/login',
              page: () => LoginPage(),
            ),
            GetPage(name: '/login/mahasiswa', page: () => LoginMahasiswa()),
            GetPage(name: '/login/dosen', page: () => LoginDosen()),
            // Mahasiswa Page
            GetPage(
              name: '/mahasiswa/dashboard',
              page: () => MahasiswaDashboardPage(),
            ),
            GetPage(
                name: '/mahasiswa/dashboard/presensi',
                page: () => MahasiswaPresensiDashboardPage()),
            // GetPage(
            //     name: '/mahasiswa/dashboard/presensi/detail',
            //     page: () => MahasiswaDetailPresensiPage()),
            // GetPage(
            //     name: '/mahasiswa/dashboard/presensi/detail/list',
            //     page: () => MahasiswaDetailListKelas()),
            GetPage(
                name: '/mahasiswa/dashboard/presensi/detail/tampilpeserta',
                page: () => MahasiswaTampilPesertaKelasPage()),
            GetPage(
                name: '/mahasiswa/dashboard/jadwal',
                page: () => MahasiswaJadwalDashboardPage()),
            // GetPage(
            //     name: '/mahasiswa/dashboard/jadwal/detail',
            //     page: () => MahasiswaDetailJadwalPage()),
            GetPage(
                name: '/mahasiswa/dashboard/riwayat',
                page: () => MahasiswaRiwayatDashboardPage()),
            // GetPage(
            //     name: '/mahasiswa/dashboard/riwayat/detail',
            //     page: () => MahasiswaDetailRiwayatPage()),

            GetPage(
                name: '/mahasiswa/dashboard/akun',
                page: () => MahasiswaAkunDashboardPage()),
            GetPage(
                name: '/mahasiswa/dashboard/akun/informasi',
                page: () => MahasiswaInformasiAkunPage()),
            // GetPage(
            //     name: '/statistik/mahasiswa',
            //     page: () => MahasiswaStatistikPage(),
            //     transition: Transition.fade),
            // Dosen Page
            GetPage(
              name: '/dosen/dashboard',
              page: () => DosenDashboardPage(),
            ),
            GetPage(
                name: '/dosen/dashboard/presensi',
                page: () => DosenPresensiDashboardPage()),
            // GetPage(
            //     name: '/dosen/dashboard/presensi/detail',
            //     page: () => DosenDetailPresensiPage()),
            // GetPage(
            //     name: '/dosen/dashboard/presensi/detail/list',
            //     page: () => DosenDetailListKelas()),
            GetPage(
                name: '/dosen/dashboard/presensi/detail/tampilpeserta',
                page: () => DosenTampilPesertaKelasPage()),

            GetPage(
                name: '/dosen/dashboard/presensi/detail/tampilkehadiranpeserta',
                page: () => DosenTampilKehadiranPesertaKelasPage()),

            GetPage(
                name:
                    '/dosen/dashboard/presensi/detail/tampilkehadiranpeserta/tes',
                page: () => DosenTampilKehadiranPesertaKelasPageTes()),

            GetPage(
                name: '/dosen/dashboard/presensi/detail/anulir',
                page: () => DosenAnulirPresensi()),

            GetPage(
                name: '/dosen/dashboard/riwayat/presensi/appbar',
                page: () => TampilPresensiAppBar()),

            GetPage(
                name: '/dosen/dashboard/jadwal/presensi/appbar',
                page: () => TampilPresensiJadwalAppBar()),
            // GetPage(
            //     name: '/dosen/dashboard/presensi/notifikasi',
            //     page: () => DosenNotifikasiPresensiPage()),
            GetPage(
                name: '/dosen/dashboard/jadwal',
                page: () => DosenJadwalDashboardPage()),

            GetPage(
                name: '/dosen/dashboard/jadwal/mahasiswa/manual',
                page: () => MahasiswaPresensiManualDetailPage()),
            // GetPage(
            //     name: '/dosen/dashboard/jadwal/detail',
            //     page: () => DosenDetailJadwalPage()),
            GetPage(
                name: '/dosen/dashboard/riwayat',
                page: () => DosenRiwayatDashboardPage()),
            // GetPage(
            //     name: '/dosen/dashboard/riwayat/detail',
            //     page: () => DosenDetailRiwayatPage()),
            GetPage(
                name: '/dosen/dashboard/akun',
                page: () => DosenAkunDashboardPage()),
            GetPage(
                name: '/dosen/dashboard/akun/informasi',
                page: () => DosenInformasiAkunPage()),

            // Admin Page
            GetPage(
                name: '/admin/menu/beacon', page: () => AdminMenuBeaconPage()),
            GetPage(
                name: '/admin/menu/beacon/pindai',
                page: () => AdminPindaiBeacon()),
            GetPage(
                name: '/admin/menu/beacon/tampil',
                page: () => AdminTampilListBeacon()),
            GetPage(
                name: '/admin/menu/beacon/tambah',
                page: () => AdminTambahBeacon()),
            GetPage(
                name: '/admin/menu/beacon/ubah', page: () => AdminUbahBeacon()),
            // GetPage(
            //     name: '/admin/menu/beacon/hapus',
            //     page: () => AdminHapusBeacon()),
            GetPage(
                name: '/admin/menu/beacon/detail/ubah',
                page: () => AdminDetailUbahBeacon()),
            // GetPage(
            //     name: '/admin/menu/beacon/detail/hapus',
            //     page: () => AdminDetailHapusBeacon()),
            GetPage(
                name: '/admin/menu/ruangan/menu',
                page: () => AdminMenuRuanganPage()),
            GetPage(
                name: '/admin/menu/ruangan/', page: () => AdminRuanganPage()),
            GetPage(
                name: '/admin/menu/ruangan/hapus',
                page: () => AdminHapusRuanganPage()),
            GetPage(
                name: '/admin/menu/ruangan/detail',
                page: () => AdminDetailRuanganPage()),
            GetPage(
                name: '/admin/menu/ruangan/tampil',
                page: () => AdminTampilRuanganPage()),
            GetPage(name: '/login/admin', page: () => LoginAdmin()),
            GetPage(name: '/admin/dashboard', page: () => AdminDashboardPage()),
            // GetPage(
            //     name: '/statistik/dosen',
            //     page: () => DosenStatistikPage(),
            //     transition: Transition.fade),
            // Tentang Page
            GetPage(
              name: '/tentang',
              page: () => TentangPage(),
            ),
          ],
        ));
  }
}
