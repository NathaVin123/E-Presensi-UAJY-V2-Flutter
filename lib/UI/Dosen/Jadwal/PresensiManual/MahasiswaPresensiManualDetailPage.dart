import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:presensiblebeacon/API/APIService.dart';
import 'package:presensiblebeacon/MODEL/Presensi/KSI/Mahasiswa/PresensiMahasiswaModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/MahasiswaManualModel.dart';
import 'package:presensiblebeacon/UTILS/ProgressHUD.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MahasiswaPresensiManualDetailPage extends StatefulWidget {
  MahasiswaPresensiManualDetailPage({Key key}) : super(key: key);

  @override
  State<MahasiswaPresensiManualDetailPage> createState() =>
      _MahasiswaPresensiManualDetailPageState();
}

class _MahasiswaPresensiManualDetailPageState
    extends State<MahasiswaPresensiManualDetailPage> {
  int idkelas = 0;
  int pertemuan = 0;
  String namamk = '';
  String kelas = '';
  String fakultas = '';

  String npm = '';
  String namamhs = '';

  String status = '';

  MahasiswaManualRequestModel mahasiswaManualRequestModel;
  MahasiswaManualResponseModel mahasiswaManualResponseModel;

  bool isApiCallProcess = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  PresensiMahasiswaRequestModel presensiMahasiswaRequestModel;

  PresensiMahasiswaFakultasRequestModel presensiMahasiswaFakultasRequestModel;

  String idkelasString;
  String idkelasFakultas;
  @override
  void initState() {
    super.initState();

    mahasiswaManualRequestModel = MahasiswaManualRequestModel();
    mahasiswaManualResponseModel = MahasiswaManualResponseModel();

    presensiMahasiswaRequestModel = PresensiMahasiswaRequestModel();

    presensiMahasiswaFakultasRequestModel =
        PresensiMahasiswaFakultasRequestModel();

    Timer.periodic(Duration(seconds: 2), (Timer t) {
      // getDataIDKelas();
      getNPMManualStatus();
      Future.delayed(Duration(seconds: 5), () {
        t.cancel();
      });
    });
  }

  getDataDosen() async {
    SharedPreferences loginDosen = await SharedPreferences.getInstance();
    setState(() {
      fakultas = loginDosen.getString('fakultas');
    });
  }

  getDataIDKelas() async {
    SharedPreferences datapresensiDosen = await SharedPreferences.getInstance();

    setState(() {
      idkelas = datapresensiDosen.getInt('idkelas');
      pertemuan = datapresensiDosen.getInt('pertemuan');
      namamk = datapresensiDosen.getString('namamk');
      kelas = datapresensiDosen.getString('kelas');
    });
  }

  getNPMManualStatus() async {
    setState(() {
      mahasiswaManualRequestModel.idkelas = idkelas;
      mahasiswaManualRequestModel.pertemuan = pertemuan;
      mahasiswaManualRequestModel.npm = npm;
      print(mahasiswaManualRequestModel.toJson());

      APIService apiService = new APIService();

      apiService
          .postListMahasiswaManual(mahasiswaManualRequestModel)
          .then((value) async {
        mahasiswaManualResponseModel = value;
      });
    });
  }

  getNPMManual() async {
    SharedPreferences dataMahasiswaManual =
        await SharedPreferences.getInstance();

    setState(() {
      npm = dataMahasiswaManual.getString('npm');
      namamhs = dataMahasiswaManual.getString('namamhs');
    });
  }

  getIDKelasFakultas() async {
    idkelasString = idkelas.toString();

    idkelasFakultas = idkelasString.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: buildPresensiManualMahasiswa(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0,
    );
  }

  Widget buildPresensiManualMahasiswa(BuildContext context) {
    getDataDosen();
    getDataIDKelas();
    getNPMManual();
    getIDKelasFakultas();
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
          onPressed: () => getDataIDKelas()),
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
      body: Container(
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
                              text: namamhs ?? '-',
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
                                      child: Text(namamhs ?? '-',
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
                              npm ?? '-',
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
                            child: Text(
                              '${namamk ?? '-'} ${kelas ?? '-'}',
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
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
                  mahasiswaManualResponseModel.data == null
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Mohon Tunggu..',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        )
                      : mahasiswaManualResponseModel.data.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MaterialButton(
                                  padding: EdgeInsets.all(8),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 26),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    setState(() {
                                      isApiCallProcess = true;
                                      presensiMahasiswaRequestModel.idkelas =
                                          idkelas;
                                      presensiMahasiswaRequestModel.npm = npm;
                                      presensiMahasiswaRequestModel.pertemuan =
                                          pertemuan;

                                      if (fakultas == 'Bisnis dan Ekonomika') {
                                        presensiMahasiswaFakultasRequestModel
                                            .idkelas = idkelasFakultas;
                                        presensiMahasiswaFakultasRequestModel
                                            .npm = npm;
                                        presensiMahasiswaFakultasRequestModel
                                            .pertemuan = pertemuan;
                                      } else if (fakultas == 'Hukum') {
                                        presensiMahasiswaFakultasRequestModel
                                            .idkelas = idkelasFakultas;
                                        presensiMahasiswaFakultasRequestModel
                                            .npm = npm;
                                        presensiMahasiswaFakultasRequestModel
                                            .pertemuan = pertemuan;
                                      } else if (fakultas == 'Teknobiologi') {
                                        presensiMahasiswaFakultasRequestModel
                                            .idkelas = idkelasFakultas;
                                        presensiMahasiswaFakultasRequestModel
                                            .npm = npm;
                                        presensiMahasiswaFakultasRequestModel
                                            .pertemuan = pertemuan;
                                      } else if (fakultas ==
                                          'Ilmu Sosial dan Politik') {
                                        presensiMahasiswaFakultasRequestModel
                                            .idkelas = idkelasFakultas;
                                        presensiMahasiswaFakultasRequestModel
                                            .npm = npm;
                                        presensiMahasiswaFakultasRequestModel
                                            .pertemuan = pertemuan;
                                      } else if (fakultas == 'Teknik') {
                                        presensiMahasiswaFakultasRequestModel
                                            .idkelas = idkelasFakultas;
                                        presensiMahasiswaFakultasRequestModel
                                            .npm = npm;
                                        presensiMahasiswaFakultasRequestModel
                                            .pertemuan = pertemuan;
                                      } else if (fakultas ==
                                          'Teknologi Industri') {
                                        presensiMahasiswaFakultasRequestModel
                                            .idkelas = idkelasFakultas;
                                        presensiMahasiswaFakultasRequestModel
                                            .npm = npm;
                                        presensiMahasiswaFakultasRequestModel
                                            .pertemuan = pertemuan;
                                      }
                                    });

                                    print(
                                        presensiMahasiswaRequestModel.toJson());

                                    print(presensiMahasiswaFakultasRequestModel
                                        .toJson());

                                    APIService apiService = new APIService();
                                    if (fakultas == 'Bisnis dan Ekonomika') {
                                      await apiService.postInsertPresensiMhsFBE(
                                          presensiMahasiswaFakultasRequestModel);
                                    } else if (fakultas == 'Hukum') {
                                      await apiService.postInsertPresensiMhsFH(
                                          presensiMahasiswaFakultasRequestModel);
                                    } else if (fakultas == 'Teknobiologi') {
                                      await apiService.postInsertPresensiMhsFTB(
                                          presensiMahasiswaFakultasRequestModel);
                                    } else if (fakultas ==
                                        'Ilmu Sosial dan Politik') {
                                      await apiService.postInsertPresensiMhsFISIP(
                                          presensiMahasiswaFakultasRequestModel);
                                    } else if (fakultas == 'Teknik') {
                                      await apiService.postInsertPresensiMhsFT(
                                          presensiMahasiswaFakultasRequestModel);
                                    } else if (fakultas ==
                                        'Teknologi Industri') {
                                      await apiService.postInsertPresensiMhsFTI(
                                          presensiMahasiswaFakultasRequestModel);
                                    }

                                    Future.delayed(Duration(seconds: 20), () {
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

                                    await apiService
                                        .postInsertPresensiMhs(
                                            presensiMahasiswaRequestModel)
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
    );
  }
}
