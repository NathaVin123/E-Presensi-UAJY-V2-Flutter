import 'dart:async';

// import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:get/get.dart';
import 'package:presensiblebeacon/API/APIService.dart';
import 'package:presensiblebeacon/MODEL/Presensi/KSI/Dosen/PresensiDosenModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/MahasiswaManualModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/TampilPesertaKelasModel.dart';
import 'package:presensiblebeacon/UTILS/ProgressHUD.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sk_alert_dialog/sk_alert_dialog.dart';

class DosenPresensiManualPage extends StatefulWidget {
  @override
  _DosenPresensiManualPageState createState() =>
      _DosenPresensiManualPageState();
}

class _DosenPresensiManualPageState extends State<DosenPresensiManualPage> {
  int idkelas = 0;
  int pertemuan = 0;

  String namadosen = '';
  String npp = '';
  String namamk = '';
  String kelas = '';
  String sks = '';
  String sesi = '';
  String cekjammasuk = '';

  var _materiFieldController = TextEditingController();

  var _keteranganFieldController = TextEditingController();

  var _materiFieldFocus = FocusNode();

  var _keteranganFieldFocus = FocusNode();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isApiCallProcess = false;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  TampilPesertaKelasRequestModel tampilPesertaKelasRequestModel;
  TampilPesertaKelasResponseModel tampilPesertaKelasResponseModel;

  PresensiDosenRequestModel presensiDosenRequestModel;

  @override
  void initState() {
    super.initState();

    tampilPesertaKelasRequestModel = TampilPesertaKelasRequestModel();
    tampilPesertaKelasResponseModel = TampilPesertaKelasResponseModel();

    presensiDosenRequestModel = PresensiDosenRequestModel();
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
      namadosen = datapresensiDosen.getString('dosen');
      npp = datapresensiDosen.getString('npp');
      namamk = datapresensiDosen.getString('namamk');
      kelas = datapresensiDosen.getString('kelas');
      cekjammasuk = datapresensiDosen.getString('cekjammasuk');
      // sks = datapresensiDosen.getString('sks');
      // sesi = datapresensiDosen.getString('sesi');
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
    return ProgressHUD(
      child: buildDosenPresensiManual(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0,
    );
  }

  Widget buildDosenPresensiManual(BuildContext context) {
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
          'Presensi Dosen',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
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
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Initicon(
                                text: namadosen ?? '-',
                                backgroundColor: Colors.grey[300],
                                size: 80,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Scrollbar(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(namadosen ?? '-',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'OpenSans',
                                                fontSize: 18)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                npp ?? '-',
                                style: TextStyle(
                                    fontFamily: 'OpenSans', fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Scrollbar(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    '${namamk ?? '-'} ${kelas ?? '-'}',
                                    style: TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Pertemuan ${pertemuan ?? '-'}',
                                    style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // cekjammasuk.isEmpty || cekjammasuk == '-'
                            //     ? Row(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.spaceEvenly,
                            //         children: [
                            //           Padding(
                            //             padding: const EdgeInsets.all(8.0),
                            //             child: Text(
                            //               'Belum Presensi',
                            //               style: TextStyle(
                            //                 fontFamily: 'OpenSans',
                            //                 fontSize: 16,
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       )
                            //     : Row(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.spaceEvenly,
                            //         children: [
                            //           Padding(
                            //             padding: const EdgeInsets.all(8.0),
                            //             child: Text(
                            //               'Sudah Presensi',
                            //               style: TextStyle(
                            //                 fontFamily: 'OpenSans',
                            //                 fontSize: 16,
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       )
                          ],
                        ),
                      ),
                    ),
                    cekjammasuk.isEmpty || cekjammasuk == '-'
                        ? Form(
                            key: globalFormKey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Text(
                                          'Keterangan',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Center(
                                              child: TextFormField(
                                            controller:
                                                _keteranganFieldController,
                                            focusNode: _keteranganFieldFocus,
                                            onFieldSubmitted: (term) {
                                              _fieldFocusChange(
                                                  context,
                                                  _keteranganFieldFocus,
                                                  _materiFieldFocus);
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            style: const TextStyle(
                                                fontFamily: 'OpenSans',
                                                fontSize: 16.0,
                                                color: Colors.black),
                                            keyboardType: TextInputType.text,
                                            onSaved: (input) =>
                                                presensiDosenRequestModel
                                                    .keterangan = input,
                                          )),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Text(
                                          'Materi',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Center(
                                              child: TextFormField(
                                            controller: _materiFieldController,
                                            focusNode: _materiFieldFocus,
                                            onFieldSubmitted: (value) {
                                              _materiFieldFocus.unfocus();
                                            },
                                            textInputAction:
                                                TextInputAction.done,
                                            style: const TextStyle(
                                                fontFamily: 'OpenSans',
                                                fontSize: 16.0,
                                                color: Colors.black),
                                            keyboardType: TextInputType.text,
                                            onSaved: (input) =>
                                                presensiDosenRequestModel
                                                    .materi = input,
                                          )),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: new Text(
                                          'Opsional',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 0,
                          ),
                    cekjammasuk.isEmpty || cekjammasuk == '-'
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(
                                padding: EdgeInsets.all(8),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 26),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.arrow_upward_rounded,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        'Presensi',
                                        style: const TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                color: Colors.blue[200],
                                shape: StadiumBorder(),
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  if (validateAndSave()) {
                                    setState(() {
                                      isApiCallProcess = true;
                                      presensiDosenRequestModel.idkelas =
                                          idkelas;

                                      presensiDosenRequestModel.pertemuan =
                                          pertemuan;
                                    });

                                    print(presensiDosenRequestModel.toJson());

                                    Future.delayed(Duration(seconds: 10),
                                        () async {
                                      setState(() {
                                        isApiCallProcess = false;
                                      });

                                      Fluttertoast.showToast(
                                          msg: 'Silahkan coba kembali',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 14.0);
                                    });

                                    APIService apiService = new APIService();

                                    await apiService
                                        .putPresensiDosen(
                                            presensiDosenRequestModel)
                                        .then((value) async {
                                      if (value != null) {
                                        setState(() {
                                          isApiCallProcess = false;
                                        });
                                      }

                                      Get.back();

                                      await Fluttertoast.showToast(
                                          msg: 'Berhasil Presensi',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 14.0);
                                    });
                                  }
                                }),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(
                                padding: EdgeInsets.all(8),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 26),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      // Icon(
                                      //   Icons.arrow_upward_rounded,
                                      //   color: Colors.black,
                                      // ),
                                      // SizedBox(
                                      //   width: 20,
                                      // ),
                                      Text(
                                        'Sudah Presensi',
                                        style: const TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                color: Colors.grey[200],
                                shape: StadiumBorder(),
                                onPressed: () {}),
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
