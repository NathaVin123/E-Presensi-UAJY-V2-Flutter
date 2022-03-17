import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:presensiblebeacon/API/APIService.dart';
import 'package:presensiblebeacon/MODEL/Presensi/TampilPesertaKelasModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DosenTampilPesertaKelasPage extends StatefulWidget {
  @override
  _DosenTampilPesertaKelasPageState createState() =>
      _DosenTampilPesertaKelasPageState();
}

class _DosenTampilPesertaKelasPageState
    extends State<DosenTampilPesertaKelasPage> {
  int idkelas = 0;
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

    Timer.periodic(Duration(seconds: 1), (Timer t) {
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
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh_rounded),
            onPressed: () => getDataPesertaKelas()),
        backgroundColor: Color.fromRGBO(23, 75, 137, 1),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: Color.fromRGBO(23, 75, 137, 1),
          title: Text(
            'Tampil Peserta Kelas',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'WorkSansMedium',
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: tampilPesertaKelasResponseModel.data == null
            ? Container(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
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
                                  'Tidak ada peserta di kelas ini',
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
                    itemCount: tampilPesertaKelasResponseModel.data?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 8, bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(25)),
                          child: new ListTile(
                            title: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Initicon(
                                      text: tampilPesertaKelasResponseModel
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: new AutoSizeText(
                                              tampilPesertaKelasResponseModel
                                                  .data[index].namamhs,
                                              style: TextStyle(
                                                  fontFamily: 'WorkSansMedium',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: new Text(
                                            tampilPesertaKelasResponseModel
                                                .data[index].npm,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'WorkSansMedium',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () async {},
                          ),
                        ),
                      );
                    }));
  }
}
