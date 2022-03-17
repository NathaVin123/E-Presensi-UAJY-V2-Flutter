import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:presensiblebeacon/MODEL/Beacon/ListBeaconModel.dart';
import 'package:presensiblebeacon/MODEL/Beacon/RuangBeaconModel.dart';
import 'package:presensiblebeacon/MODEL/Beacon/TambahBeaconModel.dart';
import 'package:presensiblebeacon/MODEL/Beacon/UbahBeaconModel.dart';
import 'package:presensiblebeacon/MODEL/Dosen/JadwalDosenModel.dart';
import 'package:presensiblebeacon/MODEL/Dosen/RiwayatDosenModel.dart';
import 'package:presensiblebeacon/MODEL/Login/LoginAdminModel.dart';
import 'package:presensiblebeacon/MODEL/Mahasiswa/JadwalMahasiswaModel.dart';
import 'package:presensiblebeacon/MODEL/Mahasiswa/RiwayatMahasiswaModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FBE/PresensiOutMahasiswaFBEModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FBE/PresensiOutMahasiswaTidakHadirToFBEModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FH/PresensiOutMahasiswaFHModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FH/PresensiOutMahasiswaTidakHadirToFHModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FISIP/PresensiOutMahasiswaFISIPModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FISIP/PresensiOutMahasiswaTidakHadirToFISIPModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FT/PresensiOutMahasiswaFTModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FT/PresensiOutMahasiswaTidakHadirToFTModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FTB/PresensiOutMahasiswaFTBModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FTB/PresensiOutMahasiswaTidakHadirToFTBModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FTI/PresensiOutMahasiswaFTIModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FTI/PresensiOutMahasiswaTidakHadirToFTIModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/KSI/Dosen/PresensiDosenModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/KSI/Dosen/PresensiOutMahasiswaModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/KSI/Dosen/PresensiOutMahasiswaTidakHadirModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/KSI/Mahasiswa/PresensiMahasiswaModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/ListKelasDosenModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/ListKelasMahasiswa.dart';
import 'package:presensiblebeacon/MODEL/Presensi/KSI/Dosen/PresensiINDosenBukaPresensiModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FBE/PresensiINMahasiswaToFBEModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FH/PresensiINMahasiswaToFHModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FISIP/PresensiINMahasiswaToFISIPModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FTB/PresensiINMahasiswaToFTBModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FTI/PresensiINMahasiswaToFTIModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FT/PresensiINMahasiswaToFTModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/KSI/Mahasiswa/PresensiINMahasiswaToKSIModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/KSI/Dosen/PresensiINOUTOUTPresensiDosen.dart';
import 'package:presensiblebeacon/MODEL/Presensi/KSI/Dosen/PresensiINOUTPresensiDosen.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FBE/PresensiOUTMahasiswaToFBEModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FH/PresensiOUTMahasiswaToFHModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FISIP/PresensiOUTMahasiswaToFISIPModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FTB/PresensiOUTMahasiswaToFTBModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FTI/PresensiOUTMahasiswaToFTIModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FT/PresensiOUTMahasiswaToFTModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/KSI/Mahasiswa/PresensiOUTMahasiswaToKSIModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/MahasiswaManualModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/TampilKehadiranPesertaKelasModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/TampilPesertaKelasModel.dart';
import 'package:presensiblebeacon/MODEL/Ruangan/LepasRuangBeaconModel.dart';
import 'package:presensiblebeacon/MODEL/Ruangan/ListDetailRuanganModel.dart';
import 'package:presensiblebeacon/MODEL/Ruangan/ListDetailRuanganNamaDeviceModel.dart';
import 'package:presensiblebeacon/MODEL/Ruangan/ListRuanganModel.dart';
import 'package:presensiblebeacon/MODEL/Ruangan/UbahRuangBeaconModel.dart';
import 'package:presensiblebeacon/MODEL/Login/LoginMahasiswaModel.dart';
import 'package:presensiblebeacon/MODEL/Login/LoginDosenModel.dart';

class APIService {
  // API Local - Sesuaikan dengan alamat IP (ipconfig)
  // String address = 'https://0.0.0.0:5000/api/';

  // API Server KSI UAJY
  String address = 'https://api-presensi.uajy.ac.id/api/';

  // Login Mahasiswa API
  Future<LoginMahasiswaResponseModel> loginMahasiswa(
      LoginMahasiswaRequestModel requestModel) async {
    String url = address + "auth/loginmhs";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return LoginMahasiswaResponseModel.fromJson(
          json.decode(response.body),
        );
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        Fluttertoast.showToast(
            msg: 'Bad Request',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
        return LoginMahasiswaResponseModel.fromJson(
          json.decode(response.body),
        );
      } else {
        print(response);
        Fluttertoast.showToast(
            msg: 'Gagal memuat data',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        Fluttertoast.showToast(
            msg: 'Tidak terhubung dengan jaringan',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        Fluttertoast.showToast(
            msg: 'Request Timeout',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        Fluttertoast.showToast(
            msg: 'Sistem sedang dalam masalah',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  // Login Dosen API
  Future<LoginDosenResponseModel> loginDosen(
      LoginDosenRequestModel requestModel) async {
    String url = address + "auth/logindsn";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return LoginDosenResponseModel.fromJson(
          json.decode(response.body),
        );
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        Fluttertoast.showToast(
            msg: 'Bad Request',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
        return LoginDosenResponseModel.fromJson(
          json.decode(response.body),
        );
      } else {
        print(response);
        Fluttertoast.showToast(
            msg: 'Gagal memuat data',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        Fluttertoast.showToast(
            msg: 'Tidak terhubung dengan jaringan',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        Fluttertoast.showToast(
            msg: 'Request Timeout',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        Fluttertoast.showToast(
            msg: 'Sistem sedang dalam masalah',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future<LoginAdminResponseModel> loginAdmin(
      LoginAdminRequestModel requestModel) async {
    String url = address + "auth/loginadm";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return LoginAdminResponseModel.fromJson(
          json.decode(response.body),
        );
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        Fluttertoast.showToast(
            msg: 'Bad Request',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
        return LoginAdminResponseModel.fromJson(
          json.decode(response.body),
        );
      } else {
        print(response);
        Fluttertoast.showToast(
            msg: 'Gagal memuat data',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        Fluttertoast.showToast(
            msg: 'Tidak terhubung dengan jaringan',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        Fluttertoast.showToast(
            msg: 'Request Timeout',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        Fluttertoast.showToast(
            msg: 'Sistem sedang dalam masalah',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  // Post Get Data Jadwal Mahasiswa
  Future<JadwalMahasiswaResponseModel> postJadwalMahasiswa(
      JadwalMahasiswaRequestModel requestModel) async {
    String url = address + "jadwalmhs/postgetall";
    print(url);
    http.Response response = await http.post(url, body: requestModel.toJson());
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return JadwalMahasiswaResponseModel.fromJson(
        json.decode(response.body),
      );
    } else if (response.statusCode == 400 || response.statusCode == 422) {
      print(response.body);
      return JadwalMahasiswaResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      print(response);
      // Fluttertoast.showToast(
      //     msg: 'Gagal memuat data',
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 14.0);
      throw Exception('Gagal memuat data');
    }
  }

  Future<JadwalDosenResponseModel> postJadwalDosen(
      JadwalDosenRequestModel requestModel) async {
    String url = address + "jadwalmhs/postgetalldosen";
    print(url);
    http.Response response = await http.post(url, body: requestModel.toJson());
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return JadwalDosenResponseModel.fromJson(
        json.decode(response.body),
      );
    } else if (response.statusCode == 400 || response.statusCode == 422) {
      print(response.body);
      return JadwalDosenResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      print(response);
      // Fluttertoast.showToast(
      //     msg: 'Gagal memuat data',
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 14.0);
      throw Exception('Gagal memuat data');
    }
  }

  // Post Get Data Riwayat Mahasiswa
  Future<RiwayatMahasiswaResponseModel> postRiwayatMahasiswa(
      RiwayatMahasiswaRequestModel requestModel) async {
    String url = address + "riwayatmhs/postgetall/";
    print(url);
    http.Response response = await http.post(url, body: requestModel.toJson());
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return RiwayatMahasiswaResponseModel.fromJson(
        json.decode(response.body),
      );
    } else if (response.statusCode == 400 || response.statusCode == 422) {
      print(response.body);
      return RiwayatMahasiswaResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      print(response);
      // Fluttertoast.showToast(
      //     msg: 'Gagal memuat data',
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 14.0);
      throw Exception('Gagal memuat data');
    }
  }

  Future<RiwayatDosenResponseModel> postRiwayatDosen(
      RiwayatDosenRequestModel requestModel) async {
    String url = address + "riwayatmhs/postgetalldosen";
    print(url);
    http.Response response = await http.post(url, body: requestModel.toJson());
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return RiwayatDosenResponseModel.fromJson(
        json.decode(response.body),
      );
    } else if (response.statusCode == 400 || response.statusCode == 422) {
      print(response.body);
      return RiwayatDosenResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      print(response);
      // Fluttertoast.showToast(
      //     msg: 'Gagal memuat data',
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 14.0);
      throw Exception('Gagal memuat data');
    }
  }

  // Get Jadwal Beacon
  Future<RuangBeaconResponseModel> getKelasBeacon() async {
    String url = address + "ruangbeacon";
    print(url);
    try {
      http.Response response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return RuangBeaconResponseModel.fromJson(
          json.decode(response.body),
        );
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        return RuangBeaconResponseModel.fromJson(
          json.decode(response.body),
        );
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future postTambahBeacon(TambahBeaconRequestModel requestModel) async {
    String url = address + "ruangbeacon/tambah";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        print(response.body);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future<ListBeaconResponseModel> getListBeacon() async {
    String url = address + "ruangbeacon/tampil";
    print(url);
    try {
      http.Response response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return ListBeaconResponseModel.fromJson(
          json.decode(response.body),
        );
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        return ListBeaconResponseModel.fromJson(
          json.decode(response.body),
        );
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putUbahBeacon(UbahBeaconRequestModel requestModel) async {
    String url = address + "ruangbeacon/ubah";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  // Future hapusBeacon(HapusBeaconRequestModel requestModel) async {
  //   String url = address + "ruangbeacon/softhapus";
  //   print(url);
  //   http.Response response = await http.put(url);
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     return HapusBeaconRequestModel.fromJson(
  //       json.decode(response.body),
  //     );
  //   } else if (response.statusCode == 400 || response.statusCode == 422) {
  //     print(response.body);
  //     return HapusBeaconRequestModel.fromJson(
  //       json.decode(response.body),
  //     );
  //   } else {
  //     print(response);
  //     // Fluttertoast.showToast(
  //     //     msg: 'Gagal memuat data',
  //     //     toastLength: Toast.LENGTH_SHORT,
  //     //     gravity: ToastGravity.BOTTOM,
  //     //     timeInSecForIosWeb: 1,
  //     //     backgroundColor: Colors.red,
  //     //     textColor: Colors.white,
  //     //     fontSize: 14.0);
  //     throw Exception('Gagal memuat data');
  //   }
  // }

  Future<ListDetailRuanganNamaDeviceResponseModel> postRuanganNamaDevice(
      ListDetailRuanganNamaDeviceRequestModel requestModel) async {
    String url = address + "ruangbeacon/namadevice";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return ListDetailRuanganNamaDeviceResponseModel.fromJson(
          json.decode(response.body),
        );
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        return ListDetailRuanganNamaDeviceResponseModel.fromJson(
          json.decode(response.body),
        );
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future<ListRuanganResponseModel> getListRuangan() async {
    String url = address + "ruangbeacon/tampilruangan";
    print(url);
    try {
      http.Response response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return ListRuanganResponseModel.fromJson(
          json.decode(response.body),
        );
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        return ListRuanganResponseModel.fromJson(
          json.decode(response.body),
        );
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future<ListDetailRuanganResponseModel> getListDetailRuangan() async {
    String url = address + "ruangbeacon/tampildetailruangan";
    print(url);
    try {
      http.Response response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);

        return ListDetailRuanganResponseModel.fromJson(
          json.decode(response.body),
        );
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        return ListDetailRuanganResponseModel.fromJson(
          json.decode(response.body),
        );
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putUbahRuangBeacon(UbahRuangBeaconRequestModel requestModel) async {
    String url = address + "ruangbeacon/ubahruangbeacon";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putLepasRuangBeacon(LepasRuangBeaconRequestModel requestModel) async {
    String url = address + "ruangbeacon/lepasruangbeacon";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future<ListKelasDosenResponseModel> postListKelasDosen(
      ListKelasDosenRequestModel requestModel) async {
    String url = address + "presensi/postgetlistkelas";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return ListKelasDosenResponseModel.fromJson(
          json.decode(response.body),
        );
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        return ListKelasDosenResponseModel.fromJson(
          json.decode(response.body),
        );
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  // Future<ListKelasDosenResponseModel> postListAllKelasDosen(
  //     ListKelasDosenRequestModel requestModel) async {
  //   String url = address + "presensi/postgetalllistkelas";
  //   print(url);
  //   try {
  //     http.Response response =
  //         await http.post(url, body: requestModel.toJson());
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       print(response.body);
  //       return ListKelasDosenResponseModel.fromJson(
  //         json.decode(response.body),
  //       );
  //     } else if (response.statusCode == 400 || response.statusCode == 422) {
  //       print(response.body);
  //       // Fluttertoast.showToast(
  //       //     msg: 'Bad Request',
  //       //     toastLength: Toast.LENGTH_SHORT,
  //       //     gravity: ToastGravity.TOP,
  //       //     timeInSecForIosWeb: 1,
  //       //     backgroundColor: Colors.red,
  //       //     textColor: Colors.white,
  //       //     fontSize: 12.0);
  //       return ListKelasDosenResponseModel.fromJson(
  //         json.decode(response.body),
  //       );
  //     } else {
  //       print(response);
  //       // Fluttertoast.showToast(
  //       //     msg: 'Gagal memuat data',
  //       //     toastLength: Toast.LENGTH_SHORT,
  //       //     gravity: ToastGravity.TOP,
  //       //     timeInSecForIosWeb: 1,
  //       //     backgroundColor: Colors.red,
  //       //     textColor: Colors.white,
  //       //     fontSize: 12.0);
  //       throw Exception('Gagal memuat data');
  //     }
  //   } catch (e) {
  //     if (e is SocketException) {
  //       // Fluttertoast.showToast(
  //       //     msg: 'Tidak terhubung dengan jaringan',
  //       //     toastLength: Toast.LENGTH_SHORT,
  //       //     gravity: ToastGravity.TOP,
  //       //     timeInSecForIosWeb: 1,
  //       //     backgroundColor: Colors.red,
  //       //     textColor: Colors.white,
  //       //     fontSize: 12.0);
  //       throw Exception(
  //           'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
  //     } else if (e is TimeoutException) {
  //       // Fluttertoast.showToast(
  //       //     msg: 'Request Timeout',
  //       //     toastLength: Toast.LENGTH_SHORT,
  //       //     gravity: ToastGravity.TOP,
  //       //     timeInSecForIosWeb: 1,
  //       //     backgroundColor: Colors.red,
  //       //     textColor: Colors.white,
  //       //     fontSize: 12.0);
  //       throw Exception('Request Timeout');
  //     } else {
  //       // Fluttertoast.showToast(
  //       //     msg: 'Sistem sedang dalam masalah',
  //       //     toastLength: Toast.LENGTH_SHORT,
  //       //     gravity: ToastGravity.TOP,
  //       //     timeInSecForIosWeb: 1,
  //       //     backgroundColor: Colors.red,
  //       //     textColor: Colors.white,
  //       //     fontSize: 12.0);
  //       throw Exception(
  //           'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
  //     }
  //   }
  // }

  Future<ListKelasMahasiswaResponseModel> postListKelasMahasiswa(
      ListKelasMahasiswaRequestModel requestModel) async {
    String url = address + "presensi/postgetlistkelasmhs";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return ListKelasMahasiswaResponseModel.fromJson(
          json.decode(response.body),
        );
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        return ListKelasMahasiswaResponseModel.fromJson(
          json.decode(response.body),
        );
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  // Future<ListKelasMahasiswaResponseModel> postListAllKelasMahasiswa(
  //     ListKelasMahasiswaRequestModel requestModel) async {
  //   String url = address + "presensi/postgetalllistkelasmhs";
  //   print(url);
  //   try {
  //     http.Response response =
  //         await http.post(url, body: requestModel.toJson());
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       print(response.body);
  //       return ListKelasMahasiswaResponseModel.fromJson(
  //         json.decode(response.body),
  //       );
  //     } else if (response.statusCode == 400 || response.statusCode == 422) {
  //       print(response.body);
  //       // Fluttertoast.showToast(
  //       //     msg: 'Bad Request',
  //       //     toastLength: Toast.LENGTH_SHORT,
  //       //     gravity: ToastGravity.TOP,
  //       //     timeInSecForIosWeb: 1,
  //       //     backgroundColor: Colors.red,
  //       //     textColor: Colors.white,
  //       //     fontSize: 12.0);
  //       return ListKelasMahasiswaResponseModel.fromJson(
  //         json.decode(response.body),
  //       );
  //     } else {
  //       print(response);
  //       // Fluttertoast.showToast(
  //       //     msg: 'Gagal memuat data',
  //       //     toastLength: Toast.LENGTH_SHORT,
  //       //     gravity: ToastGravity.TOP,
  //       //     timeInSecForIosWeb: 1,
  //       //     backgroundColor: Colors.red,
  //       //     textColor: Colors.white,
  //       //     fontSize: 12.0);
  //       throw Exception('Gagal memuat data');
  //     }
  //   } catch (e) {
  //     if (e is SocketException) {
  //       // Fluttertoast.showToast(
  //       //     msg: 'Tidak terhubung dengan jaringan',
  //       //     toastLength: Toast.LENGTH_SHORT,
  //       //     gravity: ToastGravity.TOP,
  //       //     timeInSecForIosWeb: 1,
  //       //     backgroundColor: Colors.red,
  //       //     textColor: Colors.white,
  //       //     fontSize: 12.0);
  //       throw Exception(
  //           'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
  //     } else if (e is TimeoutException) {
  //       // Fluttertoast.showToast(
  //       //     msg: 'Request Timeout',
  //       //     toastLength: Toast.LENGTH_SHORT,
  //       //     gravity: ToastGravity.TOP,
  //       //     timeInSecForIosWeb: 1,
  //       //     backgroundColor: Colors.red,
  //       //     textColor: Colors.white,
  //       //     fontSize: 12.0);
  //       throw Exception('Request Timeout');
  //     } else {
  //       // Fluttertoast.showToast(
  //       //     msg: 'Sistem sedang dalam masalah',
  //       //     toastLength: Toast.LENGTH_SHORT,
  //       //     gravity: ToastGravity.TOP,
  //       //     timeInSecForIosWeb: 1,
  //       //     backgroundColor: Colors.red,
  //       //     textColor: Colors.white,
  //       //     fontSize: 12.0);
  //       throw Exception(
  //           'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
  //     }
  //   }
  // }

  Future putBukaPresensiDosen(
      PresensiINDosenBukaPresensiRequestModel requestModel) async {
    String url = address + "presensi/bukapresensidosen";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putPresensiDosen(PresensiDosenRequestModel requestModel) async {
    String url = address + "presensi/putpresensidosen";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putPresensiINDosen(
      PresensiINOUTDosenBukaPresensiRequestModel requestModel) async {
    String url = address + "presensi/putinpresensidosen";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putPresensiOUTDosen(
      PresensiINOUTOUTDosenBukaPresensiRequestModel requestModel) async {
    String url = address + "presensi/putoutpresensidosen";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future<TampilPesertaKelasResponseModel> postListPesertaKelas(
      TampilPesertaKelasRequestModel requestModel) async {
    String url = address + "presensi/postgetlistpesertakelas";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return TampilPesertaKelasResponseModel.fromJson(
          json.decode(response.body),
        );
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        return TampilPesertaKelasResponseModel.fromJson(
          json.decode(response.body),
        );
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future<MahasiswaManualResponseModel> postListMahasiswaManual(
      MahasiswaManualRequestModel requestModel) async {
    String url = address + "presensi/postgetlistmahasiswamanual";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return MahasiswaManualResponseModel.fromJson(
          json.decode(response.body),
        );
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        return MahasiswaManualResponseModel.fromJson(
          json.decode(response.body),
        );
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future<TampilKehadiranPesertaKelasResponseModel>
      postListKehadiranPesertaKelas(
          TampilKehadiranPesertaKelasRequestModel requestModel) async {
    String url = address + "presensi/postgetlistkehadiranpesertakelas";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return TampilKehadiranPesertaKelasResponseModel.fromJson(
          json.decode(response.body),
        );
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        return TampilKehadiranPesertaKelasResponseModel.fromJson(
          json.decode(response.body),
        );
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future<TampilKehadiranPesertaKelasResponseModel>
      postListKetidakhadiranPesertaKelas(
          TampilKehadiranPesertaKelasRequestModel requestModel) async {
    String url = address + "presensi/postgetlistketidakhadairanpesertakelas";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return TampilKehadiranPesertaKelasResponseModel.fromJson(
          json.decode(response.body),
        );
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        return TampilKehadiranPesertaKelasResponseModel.fromJson(
          json.decode(response.body),
        );
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future<TampilKehadiranPesertaKelasResponseModel> postListIzinPesertaKelas(
      TampilKehadiranPesertaKelasRequestModel requestModel) async {
    String url = address + "presensi/postgetlistizinpesertakelas";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        return TampilKehadiranPesertaKelasResponseModel.fromJson(
          json.decode(response.body),
        );
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        return TampilKehadiranPesertaKelasResponseModel.fromJson(
          json.decode(response.body),
        );
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putOutMahasiswa(PresensiOUTMahasiswaRequestModel requestModel) async {
    String url = address + "presensi/putoutmahasiswa";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putOutMahasiswaToFBE(
      PresensiOUTMahasiswaFBERequestModel requestModel) async {
    String url = address + "presensi/putoutmahasiswatofbe";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putOutMahasiswaToFH(
      PresensiOUTMahasiswaFHRequestModel requestModel) async {
    String url = address + "presensi/putoutmahasiswatofh";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putOutMahasiswaToFISIP(
      PresensiOUTMahasiswaFISIPRequestModel requestModel) async {
    String url = address + "presensi/putoutmahasiswatofisip";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putOutMahasiswaToFT(
      PresensiOUTMahasiswaFTRequestModel requestModel) async {
    String url = address + "presensi/putoutmahasiswatoft";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putOutMahasiswaToFTB(
      PresensiOUTMahasiswaFTBRequestModel requestModel) async {
    String url = address + "presensi/putoutmahasiswatoftb";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putOutMahasiswaToFTI(
      PresensiOUTMahasiswaFTIRequestModel requestModel) async {
    String url = address + "presensi/putoutmahasiswatofti";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future postInsertPresensiMhsTidakHadir(
      PresensiOUTMahasiswaTidakHadirRequestModel requestModel) async {
    String url = address + "presensi/postoutmahasiswatidakhadir";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future postInsertPresensiMhsTidakHadirToFBE(
      PresensiOUTMahasiswaTidakHadirFBERequestModel requestModel) async {
    String url = address + "presensi/postoutmahasiswatidakhadirtofbe";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future postInsertPresensiMhsTidakHadirToFH(
      PresensiOUTMahasiswaTidakHadirFHRequestModel requestModel) async {
    String url = address + "presensi/postoutmahasiswatidakhadirtofh";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future postInsertPresensiMhsTidakHadirToFISIP(
      PresensiOUTMahasiswaTidakHadirFISIPRequestModel requestModel) async {
    String url = address + "presensi/postoutmahasiswatidakhadirtofisip";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future postInsertPresensiMhsTidakHadirToFT(
      PresensiOUTMahasiswaTidakHadirFTRequestModel requestModel) async {
    String url = address + "presensi/postoutmahasiswatidakhadirtoft";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future postInsertPresensiMhsTidakHadirToFTB(
      PresensiOUTMahasiswaTidakHadirFTBRequestModel requestModel) async {
    String url = address + "presensi/postoutmahasiswatidakhadirtoftb";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future postInsertPresensiMhsTidakHadirToFTI(
      PresensiOUTMahasiswaTidakHadirFTIRequestModel requestModel) async {
    String url = address + "presensi/postoutmahasiswatidakhadirtofti";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future postInsertPresensiMhs(
      PresensiMahasiswaRequestModel requestModel) async {
    String url = address + "presensi/postmhs";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future postInsertPresensiMhsFBE(
      PresensiMahasiswaFakultasRequestModel requestModel) async {
    String url = address + "presensi/postmhsfbe";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future postInsertPresensiMhsFT(
      PresensiMahasiswaFakultasRequestModel requestModel) async {
    String url = address + "presensi/postmhsft";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future postInsertPresensiMhsFTB(
      PresensiMahasiswaFakultasRequestModel requestModel) async {
    String url = address + "presensi/postmhsftb";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future postInsertPresensiMhsFISIP(
      PresensiMahasiswaFakultasRequestModel requestModel) async {
    String url = address + "presensi/postmhsfisip";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future postInsertPresensiMhsFH(
      PresensiMahasiswaFakultasRequestModel requestModel) async {
    String url = address + "presensi/postmhsfh";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future postInsertPresensiMhsFTI(
      PresensiMahasiswaFakultasRequestModel requestModel) async {
    String url = address + "presensi/postmhsfti";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future postInsertPresensiMhsToKSI(
      PresensiINMahasiswaToKSIRequestModel requestModel) async {
    String url = address + "presensi/postinmhstoksi";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putUpdatePresensiMhsToKSI(
      PresensiOUTMahasiswaToKSIRequestModel requestModel) async {
    String url = address + "presensi/putoutmhstoksi";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putAnulirMhsToKSI(
      PresensiOUTMahasiswaToKSIRequestModel requestModel) async {
    String url = address + "presensi/putanulirmhstoksi";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future postInsertPresensiMhsToFBE(
      PresensiINMahasiswaToFBERequestModel requestModel) async {
    String url = address + "presensi/postinmhstofbe";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putUpdatePresensiMhsToFBE(
      PresensiOUTMahasiswaToFBERequestModel requestModel) async {
    String url = address + "presensi/putoutmhstofbe";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putAnulirMhsToFBE(
      PresensiOUTMahasiswaToFBERequestModel requestModel) async {
    String url = address + "presensi/putanulirmhstofbe";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future postInsertPresensiMhsToFH(
      PresensiINMahasiswaToFHRequestModel requestModel) async {
    String url = address + "presensi/postinmhstofh";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putUpdatePresensiMhsToFH(
      PresensiOUTMahasiswaToFHRequestModel requestModel) async {
    String url = address + "presensi/putoutmhstofh";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putAnulirMhsToFH(
      PresensiOUTMahasiswaToFHRequestModel requestModel) async {
    String url = address + "presensi/putanulirmhstofh";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future postInsertPresensiMhsToFISIP(
      PresensiINMahasiswaToFISIPRequestModel requestModel) async {
    String url = address + "presensi/postinmhstofisip";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putUpdatePresensiMhsToFISIP(
      PresensiOUTMahasiswaToFISIPRequestModel requestModel) async {
    String url = address + "presensi/putoutmhstofisip";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putAnulirMhsToFISIP(
      PresensiOUTMahasiswaToFISIPRequestModel requestModel) async {
    String url = address + "presensi/putanulirmhstofisip";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future postInsertPresensiMhsToFT(
      PresensiINMahasiswaToFTRequestModel requestModel) async {
    String url = address + "presensi/postinmhstoft";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        print(response.body);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putUpdatePresensiMhsToFT(
      PresensiOUTMahasiswaToFTRequestModel requestModel) async {
    String url = address + "presensi/putoutmhstoft";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putAnulirMhsToFT(
      PresensiOUTMahasiswaToFTRequestModel requestModel) async {
    String url = address + "presensi/putanulirmhstoft";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future postInsertPresensiMhsToFTB(
      PresensiINMahasiswaToFTBRequestModel requestModel) async {
    String url = address + "presensi/postinmhstoftb";
    print(url);
    http.Response response = await http.post(url, body: requestModel.toJson());
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 422) {
      print(response.body);
    } else {
      print(response);
      // Fluttertoast.showToast(
      //     msg: 'Gagal memuat data',
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 14.0);
      throw Exception('Gagal memuat data');
    }
  }

  Future putUpdatePresensiMhsToFTB(
      PresensiOUTMahasiswaToFTBRequestModel requestModel) async {
    String url = address + "presensi/putoutmhstoftb";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putAnulirMhsToFTB(
      PresensiOUTMahasiswaToFTBRequestModel requestModel) async {
    String url = address + "presensi/putanulirmhstoftb";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future postInsertPresensiMhsToFTI(
      PresensiINMahasiswaToFTIRequestModel requestModel) async {
    String url = address + "presensi/postinmhstofti";
    print(url);
    try {
      http.Response response =
          await http.post(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putUpdatePresensiMhsToFTI(
      PresensiOUTMahasiswaToFTIRequestModel requestModel) async {
    String url = address + "presensi/putoutmhstofti";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }

  Future putAnulirMhsToFTI(
      PresensiOUTMahasiswaToFTIRequestModel requestModel) async {
    String url = address + "presensi/putanulirmhstofti";
    print(url);
    try {
      http.Response response = await http.put(url, body: requestModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        print(response.body);
        // Fluttertoast.showToast(
        //     msg: 'Bad Request',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      } else {
        print(response);
        // Fluttertoast.showToast(
        //     msg: 'Gagal memuat data',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      if (e is SocketException) {
        // Fluttertoast.showToast(
        //     msg: 'Tidak terhubung dengan jaringan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Tidak terhubung dengan jaringan / Server sedang down,\n Silahkan coba lagi');
      } else if (e is TimeoutException) {
        // Fluttertoast.showToast(
        //     msg: 'Request Timeout',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception('Request Timeout');
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Sistem sedang dalam masalah',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.TOP,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 12.0);
        throw Exception(
            'Sistem sedang dalam masalah,\nSilahkan mulai ulang aplikasi');
      }
    }
  }
}
