import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:presensiblebeacon/API/APIService.dart';
import 'package:presensiblebeacon/MODEL/Presensi/TampilKehadiranPesertaKelasModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DosenTampilKehadiranPesertaKelasPage extends StatefulWidget {
  @override
  _DosenTampilKehadiranPesertaKelasPageState createState() =>
      _DosenTampilKehadiranPesertaKelasPageState();
}

class _DosenTampilKehadiranPesertaKelasPageState
    extends State<DosenTampilKehadiranPesertaKelasPage> {
  int idkelas = 0;
  int pertemuan = 0;
  TampilKehadiranPesertaKelasRequestModel
      tampilKehadiranPesertaKelasRequestModel;
  TampilKehadiranPesertaKelasResponseModel
      tampilKehadiranPesertaKelasResponseModel;

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
          .postListKehadiranPesertaKelas(
              tampilKehadiranPesertaKelasRequestModel)
          .then((value) async {
        tampilKehadiranPesertaKelasResponseModel = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getDataIDKelas();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh_rounded),
            onPressed: () => getDataPesertaKelas()),
        backgroundColor: Color.fromRGBO(23, 75, 137, 1),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: Color.fromRGBO(23, 75, 137, 1),
          title: Text(
            'Tampil Kehadiran Kelas',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'WorkSansMedium',
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: tampilKehadiranPesertaKelasResponseModel.data == null
            ? Container(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
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
                                  borderRadius: BorderRadius.circular(25)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Belum ada yang hadir',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'WorkSansMedium',
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
                : ListView.builder(
                    itemCount:
                        tampilKehadiranPesertaKelasResponseModel.data?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 8, bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(25)),
                          child: Column(
                            children: [
                              new ListTile(
                                title: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Initicon(
                                          text:
                                              tampilKehadiranPesertaKelasResponseModel
                                                  .data[index].namamhs,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: new AutoSizeText(
                                                  tampilKehadiranPesertaKelasResponseModel
                                                      .data[index].namamhs,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'WorkSansMedium',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: new Text(
                                                tampilKehadiranPesertaKelasResponseModel
                                                    .data[index].npm,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'WorkSansMedium',
                                                ),
                                              ),
                                            ),
                                            tampilKehadiranPesertaKelasResponseModel
                                                        .data[index].status ==
                                                    'H'
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              'Status : ${tampilKehadiranPesertaKelasResponseModel.data[index].status ?? "-"}',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'WorkSansMedium',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              'Status : ${tampilKehadiranPesertaKelasResponseModel.data[index].status ?? "-"}',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'WorkSansMedium',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () async {},
                              ),
                              ExpansionTile(
                                title: Text(
                                  'Lihat lebih detail',
                                  style: TextStyle(
                                      fontFamily: 'WorkSansMedium',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Jam Masuk : ${tampilKehadiranPesertaKelasResponseModel.data[index].jammasuk ?? "-"}',
                                            style: TextStyle(
                                                fontFamily: 'WorkSansMedium',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Jam Keluar : ${tampilKehadiranPesertaKelasResponseModel.data[index].jamkeluar ?? "-"}',
                                            style: TextStyle(
                                                fontFamily: 'WorkSansMedium',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }));
  }
}
