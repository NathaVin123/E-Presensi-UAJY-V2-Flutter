import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MahasiswaInformasiAkunPage extends StatefulWidget {
  MahasiswaInformasiAkunPage({Key key}) : super(key: key);

  @override
  _MahasiswaInformasiAkunPageState createState() =>
      _MahasiswaInformasiAkunPageState();
}

class _MahasiswaInformasiAkunPageState
    extends State<MahasiswaInformasiAkunPage> {
  String npm = "";
  String namamhs = "";
  // String alamat = "";
  String fakultas = "";
  String prodi = "";
  // String pembimbingakademik = "";

  @override
  void initState() {
    super.initState();
  }

  getDataMahasiswa() async {
    SharedPreferences loginMahasiswa = await SharedPreferences.getInstance();
    setState(() {
      npm = loginMahasiswa.getString('npm');
      namamhs = loginMahasiswa.getString('namamhs');
      // alamat = loginMahasiswa.getString('alamat');
      fakultas = loginMahasiswa.getString('fakultas');
      prodi = loginMahasiswa.getString('prodi');
      // pembimbingakademik = loginMahasiswa.getString('pembimbingakademik');
    });
  }

  @override
  Widget build(BuildContext context) {
    getDataMahasiswa();
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.grey[50],
        centerTitle: true,
        title: Text(
          'Informasi Akun',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.grey[500],
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.75,
                  spreadRadius: 0.25)
            ], color: Colors.white, borderRadius: BorderRadius.circular(25)),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14, top: 14),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(22),
                        child: Initicon(
                          text: namamhs,
                          backgroundColor: Colors.grey[400],
                          size: 80,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                            child: Column(
                          children: <Widget>[
                            Text('Nama Mahasiswa',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans',
                                    fontSize: 22)),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Scrollbar(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(namamhs,
                                      style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontSize: 18)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'NPP',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans',
                                  fontSize: 22),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              npm,
                              style: TextStyle(
                                  fontFamily: 'OpenSans', fontSize: 18),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Program Studi',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans',
                                  fontSize: 22),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              prodi,
                              style: TextStyle(
                                  fontFamily: 'OpenSans', fontSize: 18),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Fakultas',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans',
                                  fontSize: 22),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              fakultas,
                              style: TextStyle(
                                  fontFamily: 'OpenSans', fontSize: 18),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
