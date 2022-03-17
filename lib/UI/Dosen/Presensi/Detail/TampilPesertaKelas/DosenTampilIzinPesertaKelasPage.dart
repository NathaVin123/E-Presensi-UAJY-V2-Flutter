import 'dart:async';

// import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:presensiblebeacon/API/APIService.dart';
import 'package:presensiblebeacon/MODEL/Presensi/TampilKehadiranPesertaKelasModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DosenTampilIzinPesertaKelasPageTes extends StatefulWidget {
  @override
  _DosenTampilIzinPesertaKelasPageTesState createState() =>
      _DosenTampilIzinPesertaKelasPageTesState();
}

class _DosenTampilIzinPesertaKelasPageTesState
    extends State<DosenTampilIzinPesertaKelasPageTes> {
  int idkelas = 0;
  int pertemuan = 0;
  TampilKehadiranPesertaKelasRequestModel
      tampilKehadiranPesertaKelasRequestModel;
  TampilKehadiranPesertaKelasResponseModel
      tampilKehadiranPesertaKelasResponseModel;

  List<Data> tampilKehadiranPesertaKelasListSearch = List<Data>();

  @override
  void initState() {
    super.initState();

    tampilKehadiranPesertaKelasRequestModel =
        TampilKehadiranPesertaKelasRequestModel();
    tampilKehadiranPesertaKelasResponseModel =
        TampilKehadiranPesertaKelasResponseModel();
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
      tampilKehadiranPesertaKelasRequestModel.idkelas = idkelas;
      tampilKehadiranPesertaKelasRequestModel.pertemuan = pertemuan;
      print(tampilKehadiranPesertaKelasRequestModel.toJson());

      APIService apiService = new APIService();

      apiService
          .postListIzinPesertaKelas(tampilKehadiranPesertaKelasRequestModel)
          .then((value) async {
        tampilKehadiranPesertaKelasResponseModel = value;

        tampilKehadiranPesertaKelasListSearch = value.data;
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
            'Mahasiswa Izin',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
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
                  child: TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.search),
                      iconColor: Colors.black,
                      hintText: 'Cari NPM Mahasiswa',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    style: const TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 16.0,
                        color: Colors.black),
                    onChanged: (text) {
                      text = text.toLowerCase();
                      setState(() {
                        tampilKehadiranPesertaKelasListSearch =
                            tampilKehadiranPesertaKelasResponseModel.data
                                .where((npm) {
                          var nonpm = npm.npm.toLowerCase();
                          return nonpm.contains(text);
                        }).toList();
                      });
                    },
                  ),
                ),
              ),
              tampilKehadiranPesertaKelasResponseModel.data == null
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
                  : tampilKehadiranPesertaKelasResponseModel.data.isEmpty
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
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Tidak ada izin',
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
                                        headingRowColor:
                                            MaterialStateProperty.all(
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
                                          // DataColumn(
                                          //     label: Text(
                                          //   'Status',
                                          //   style: TextStyle(
                                          //     color: Colors.black,
                                          //     fontFamily: 'OpenSans',
                                          //     fontWeight: FontWeight.bold,
                                          //   ),
                                          // )),
                                          // DataColumn(
                                          //     label: Text(
                                          //   'Jam Masuk',
                                          //   style: TextStyle(
                                          //     color: Colors.black,
                                          //     fontFamily: 'OpenSans',
                                          //     fontWeight: FontWeight.bold,
                                          //   ),
                                          // )),
                                          // DataColumn(
                                          //     label: Text(
                                          //   'Jam Keluar',
                                          //   style: TextStyle(
                                          //     color: Colors.black,
                                          //     fontFamily: 'OpenSans',
                                          //     fontWeight: FontWeight.bold,
                                          //   ),
                                          // )),
                                        ],
                                        rows: [
                                          for (var i = 0;
                                              i <
                                                  tampilKehadiranPesertaKelasListSearch
                                                      .length;
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
                                                      Icons.edit,
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      'Anulir',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'OpenSans',
                                                          fontSize: 14,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                                color: Colors.blue[200],
                                                shape: StadiumBorder(),
                                                onPressed: () async {
                                                  SharedPreferences
                                                      dataMahasiswaAnulir =
                                                      await SharedPreferences
                                                          .getInstance();

                                                  await dataMahasiswaAnulir
                                                      .setString(
                                                          'npm',
                                                          tampilKehadiranPesertaKelasListSearch[
                                                                  i]
                                                              .npm);
                                                  await dataMahasiswaAnulir
                                                      .setString(
                                                          'status',
                                                          tampilKehadiranPesertaKelasListSearch[
                                                                  i]
                                                              .status);

                                                  Get.toNamed(
                                                      '/dosen/dashboard/presensi/detail/anulir');
                                                },
                                              )),
                                              DataCell(Text(
                                                  tampilKehadiranPesertaKelasListSearch[
                                                              i]
                                                          .npm ??
                                                      '-')),
                                              DataCell(Text(
                                                  tampilKehadiranPesertaKelasListSearch[
                                                              i]
                                                          .namamhs ??
                                                      '-')),
                                              // DataCell(Text(
                                              //     tampilKehadiranPesertaKelasResponseModel
                                              //             .data[i].status ??
                                              //         '-')),
                                              // DataCell(Text(
                                              //     tampilKehadiranPesertaKelasResponseModel
                                              //             .data[i].jammasuk ??
                                              //         '-')),
                                              // DataCell(Text(
                                              //     tampilKehadiranPesertaKelasResponseModel
                                              //             .data[i].jamkeluar ??
                                              //         '-')),
                                            ]),
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
            ],
          ),
        ));
  }
}
