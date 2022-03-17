import 'dart:async';

// import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:get/get.dart';
import 'package:presensiblebeacon/API/APIService.dart';
import 'package:presensiblebeacon/MODEL/Presensi/TampilPesertaKelasModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MahasiswaPresensiManualPage extends StatefulWidget {
  @override
  _MahasiswaPresensiManualPageState createState() =>
      _MahasiswaPresensiManualPageState();
}

class _MahasiswaPresensiManualPageState
    extends State<MahasiswaPresensiManualPage> {
  int idkelas = 0;
  int pertemuan = 0;
  List<bool> isSelected = [true, false];

  TampilPesertaKelasRequestModel tampilPesertaKelasRequestModel;
  TampilPesertaKelasResponseModel tampilPesertaKelasResponseModel;

  @override
  void initState() {
    super.initState();

    tampilPesertaKelasRequestModel = TampilPesertaKelasRequestModel();
    tampilPesertaKelasResponseModel = TampilPesertaKelasResponseModel();
    // Timer.periodic(Duration(seconds: 1), (Timer t) {
    //   getDataIDKelas();
    //   // getDataPesertaKelas();
    //   Future.delayed(Duration(seconds: 5), () {
    //     t.cancel();
    //   });
    // });

    Timer.periodic(Duration(seconds: 2), (Timer t) {
      // getDataIDKelas();
      getDataPesertaKelas();
      Future.delayed(Duration(seconds: 5), () {
        t.cancel();
      });
    });
  }

  getDataIDKelas() async {
    SharedPreferences datapresensiDosen = await SharedPreferences.getInstance();

    setState(() {
      idkelas = datapresensiDosen.getInt('idkelas');
      pertemuan = datapresensiDosen.getInt('pertemuan');
    });
  }

  getDataPesertaKelas() async {
    setState(() {
      tampilPesertaKelasRequestModel.idkelas = idkelas;
      print(tampilPesertaKelasRequestModel.toJson());

      APIService apiService = new APIService();

      apiService
          .postListPesertaKelas(tampilPesertaKelasRequestModel)
          .then((value) async {
        tampilPesertaKelasResponseModel = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getDataIDKelas();
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.blue[200],
            label: Text(
              'Segarkan',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                  color: Colors.black),
            ),
            icon: Icon(
              Icons.refresh_rounded,
              color: Colors.black,
            ),
            onPressed: () => getDataPesertaKelas()),
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          foregroundColor: Colors.black,
          elevation: 0,
          backgroundColor: Colors.blue[100],
          title: Text(
            'Presensi Mahasiswa',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: tampilPesertaKelasResponseModel.data == null
            ? Container(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                      child: Column(
                    children: [
                      CircularProgressIndicator(
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Mohon Tunggu',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
                ),
              )
            : tampilPesertaKelasResponseModel.data.isEmpty
                ? Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Tidak ada data kehadiran',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Scrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Scrollbar(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                  onSelectAll: (b) {},
                                  headingRowColor: MaterialStateProperty.all(
                                      Colors.blue[200]),
                                  columns: [
                                    DataColumn(
                                        label: Text(
                                      'No',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Aksi',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'NPM',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                    DataColumn(
                                      label: Text(
                                        'Nama Mahasiswa',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: [
                                    for (var i = 0;
                                        i <
                                            tampilPesertaKelasResponseModel
                                                .data.length;
                                        i++)
                                      DataRow(cells: [
                                        DataCell(Text('${i + 1}')),
                                        DataCell(MaterialButton(
                                          padding: EdgeInsets.all(8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.arrow_upward_rounded,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                'Presensi',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'OpenSans',
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          color: Colors.blue[200],
                                          shape: StadiumBorder(),
                                          onPressed: () async {
                                            SharedPreferences
                                                dataMahasiswaManual =
                                                await SharedPreferences
                                                    .getInstance();

                                            await dataMahasiswaManual.setString(
                                                'npm',
                                                tampilPesertaKelasResponseModel
                                                    .data[i].npm);

                                            await dataMahasiswaManual.setString(
                                                'namamhs',
                                                tampilPesertaKelasResponseModel
                                                    .data[i].namamhs);

                                            Get.toNamed(
                                                '/dosen/dashboard/jadwal/mahasiswa/manual');
                                          },
                                        )),
                                        DataCell(Text(
                                            tampilPesertaKelasResponseModel
                                                    .data[i].npm ??
                                                '-')),
                                        DataCell(Text(
                                            tampilPesertaKelasResponseModel
                                                    .data[i].namamhs ??
                                                '-')),
                                      ]),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
  }
}
