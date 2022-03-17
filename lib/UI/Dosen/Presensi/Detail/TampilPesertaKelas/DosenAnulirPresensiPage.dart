import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:presensiblebeacon/API/APIService.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FBE/PresensiOUTMahasiswaToFBEModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FH/PresensiOUTMahasiswaToFHModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FISIP/PresensiOUTMahasiswaToFISIPModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FT/PresensiOUTMahasiswaToFTModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FTB/PresensiOUTMahasiswaToFTBModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FTI/PresensiOUTMahasiswaToFTIModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/KSI/Mahasiswa/PresensiOUTMahasiswaToKSIModel.dart';
import 'package:presensiblebeacon/UTILS/ProgressHUD.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sk_alert_dialog/sk_alert_dialog.dart';

class DosenAnulirPresensi extends StatefulWidget {
  DosenAnulirPresensi({Key key}) : super(key: key);

  @override
  State<DosenAnulirPresensi> createState() => _DosenAnulirPresensiState();
}

class _DosenAnulirPresensiState extends State<DosenAnulirPresensi> {
  bool isApiCallProcess = false;

  // List<bool> isSelected = List.generate(3, (_) => false);

  // List<bool> isSelected = [false, true, false];

  List<bool> isSelected;

  int idkelas = 0;
  int pertemuan = 0;

  String fakultas = "";

  String npm = "";

  String status = "";

  String idkelasString;

  String idkelasFakultas;

  String selectedAnulir = "";

  int selectedKolomAnulir;

  PresensiOUTMahasiswaToKSIRequestModel presensiOUTMahasiswaToKSIRequestModel;

  PresensiOUTMahasiswaToFBERequestModel presensiOUTMahasiswaToFBERequestModel;

  PresensiOUTMahasiswaToFHRequestModel presensiOUTMahasiswaToFHRequestModel;

  PresensiOUTMahasiswaToFISIPRequestModel
      presensiOUTMahasiswaToFISIPRequestModel;

  PresensiOUTMahasiswaToFTRequestModel presensiOUTMahasiswaToFTRequestModel;

  PresensiOUTMahasiswaToFTBRequestModel presensiOUTMahasiswaToFTBRequestModel;

  PresensiOUTMahasiswaToFTIRequestModel presensiOUTMahasiswaToFTIRequestModel;

  initState() {
    super.initState();
    getPresensiDosen();
    getDetailDosen();
    getIDKelasFakultas();
    asyncAwait();

    presensiOUTMahasiswaToKSIRequestModel =
        PresensiOUTMahasiswaToKSIRequestModel();

    presensiOUTMahasiswaToFBERequestModel =
        PresensiOUTMahasiswaToFBERequestModel();

    presensiOUTMahasiswaToFHRequestModel =
        PresensiOUTMahasiswaToFHRequestModel();

    presensiOUTMahasiswaToFISIPRequestModel =
        PresensiOUTMahasiswaToFISIPRequestModel();

    presensiOUTMahasiswaToFTRequestModel =
        PresensiOUTMahasiswaToFTRequestModel();

    presensiOUTMahasiswaToFTBRequestModel =
        PresensiOUTMahasiswaToFTBRequestModel();

    presensiOUTMahasiswaToFTIRequestModel =
        PresensiOUTMahasiswaToFTIRequestModel();
  }

  void asyncAwait() async {
    await getMahasiswaAnulir();
    await setToggleButton();
  }

  setToggleButton() {
    if (status == 'H') {
      setState(() {
        isSelected = [true, false, false];
        // isSelected = List.generate(3, (_) => false);
      });
    } else if (status == 'I') {
      setState(() {
        isSelected = [false, true, false];
        // isSelected = List.generate(3, (_) => false);
      });
    } else if (status == 'A') {
      setState(() {
        isSelected = [false, false, true];
        // isSelected = List.generate(3, (_) => false);
      });
    } else {
      isSelected = List.generate(3, (_) => false);
    }
  }

  Future<void> getPresensiDosen() async {
    SharedPreferences dataPresensiDosen = await SharedPreferences.getInstance();
    setState(() {
      idkelas = dataPresensiDosen.getInt("idkelas");
      pertemuan = dataPresensiDosen.getInt("pertemuan");
    });
  }

  Future<void> getMahasiswaAnulir() async {
    SharedPreferences dataMahasiswaAnulir =
        await SharedPreferences.getInstance();

    setState(() {
      npm = dataMahasiswaAnulir.getString("npm");
      status = dataMahasiswaAnulir.getString("status");
    });
  }

  Future<void> getDetailDosen() async {
    SharedPreferences loginDosen = await SharedPreferences.getInstance();

    setState(() {
      fakultas = loginDosen.getString('fakultas');
    });
  }

  getIDKelasFakultas() async {
    idkelasString = idkelas.toString();

    idkelasFakultas = idkelasString.substring(1);
  }

  Widget build(BuildContext context) {
    return ProgressHUD(
      child: buildAnulirPresensi(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0,
    );
  }

  Widget buildAnulirPresensi(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.blue[100],
        centerTitle: true,
        title: Text(
          'Anulir Presensi',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold),
        ),
        actions: [
          FutureBuilder(
            future: Connectivity().checkConnectivity(),
            builder: (BuildContext context,
                AsyncSnapshot<ConnectivityResult> snapshot) {
              if (snapshot.data == ConnectivityResult.wifi) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Icon(
                    Icons.wifi_rounded,
                    color: Colors.green,
                  ),
                );
              } else if (snapshot.data == ConnectivityResult.mobile) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Icon(
                    Icons.signal_cellular_4_bar_rounded,
                    color: Colors.green,
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Icon(
                    Icons.signal_cellular_off_rounded,
                    color: Colors.red,
                  ),
                );
              }
            },
          )
        ],
      ),
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          Container(
            child: Padding(
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
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'NPM : ${npm ?? "-"}',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Status : ${status ?? "-"}',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(4.0),
          //   child: Center(
          //     child: Text(
          //       'Ubah Presensi',
          //       style: TextStyle(
          //           fontSize: 20,
          //           fontFamily: 'OpenSans',
          //           fontWeight: FontWeight.bold,
          //           color: Colors.black),
          //     ),
          //   ),
          // ),
          Padding(
              padding: const EdgeInsets.all(4.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ToggleButtons(
                  // focusColor: Colors.blue[300],
                  // selectedColor: Colors.blue[300],
                  // renderBorder: false,
                  fillColor: Colors.blue[200],
                  borderRadius: BorderRadius.circular(25),
                  borderWidth: 2,
                  borderColor: Colors.grey[300],
                  selectedBorderColor: Colors.blue[500],
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Hadir (H)',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Izin (I)',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Alpa (A)',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < isSelected.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          isSelected[buttonIndex] = true;
                          if (buttonIndex == 0) {
                            status = 'H';
                          } else if (buttonIndex == 1) {
                            status = 'I';
                          } else if (buttonIndex == 2) {
                            status = 'A';
                          }
                          print(status);
                        } else {
                          isSelected[buttonIndex] = false;
                        }
                      }
                    });
                  },
                  isSelected: isSelected,
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              color: Colors.blue[200],
              shape: StadiumBorder(),
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.save,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Simpan",
                    style: const TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              onPressed: () {
                print(idkelas);
                print(npm);
                print(pertemuan);
                print(status);
                SKAlertDialog.show(
                  context: context,
                  type: SKAlertType.buttons,
                  title: '',
                  message: 'Apakah anda yakin ingin mengubah \n data ?',
                  okBtnText: 'Ya',
                  okBtnTxtColor: Colors.white,
                  okBtnColor: Colors.red,
                  cancelBtnText: 'Tidak',
                  cancelBtnTxtColor: Colors.white,
                  cancelBtnColor: Colors.grey,
                  onOkBtnTap: (value) async {
                    setState(() {
                      isApiCallProcess = true;
                      presensiOUTMahasiswaToKSIRequestModel.idkelas = idkelas;

                      presensiOUTMahasiswaToKSIRequestModel.npm = npm;

                      presensiOUTMahasiswaToKSIRequestModel.pertemuan =
                          pertemuan;
                      // presensiOUTMahasiswaToKSIRequestModel.tglout = '-';

                      presensiOUTMahasiswaToKSIRequestModel.status = status;

                      if (fakultas == 'Bisnis dan Ekonomika') {
                        presensiOUTMahasiswaToFBERequestModel.idkelas =
                            idkelasFakultas;

                        presensiOUTMahasiswaToFBERequestModel.npm = npm;

                        presensiOUTMahasiswaToFBERequestModel.pertemuan =
                            pertemuan;

                        // presensiOUTMahasiswaToFBERequestModel.tglout = jam +
                        //     ' ' +
                        //     tanggalnow;

                        presensiOUTMahasiswaToFBERequestModel.status = status;
                      } else if (fakultas == 'Hukum') {
                        presensiOUTMahasiswaToFHRequestModel.idkelas =
                            idkelasFakultas;

                        presensiOUTMahasiswaToFHRequestModel.npm = npm;

                        presensiOUTMahasiswaToFHRequestModel.pertemuan =
                            pertemuan;

                        // presensiOUTMahasiswaToFHRequestModel.tglout = jam +
                        //     ' ' +
                        //     tanggalnow;

                        presensiOUTMahasiswaToFHRequestModel.status = status;
                      } else if (fakultas == 'Teknobiologi') {
                        presensiOUTMahasiswaToFTBRequestModel.idkelas =
                            idkelasFakultas;

                        presensiOUTMahasiswaToFTBRequestModel.npm = npm;

                        presensiOUTMahasiswaToFTBRequestModel.pertemuan =
                            pertemuan;

                        // presensiOUTMahasiswaToFTBRequestModel.tglout = jam +
                        //     ' ' +
                        //     tanggalnow;

                        presensiOUTMahasiswaToFTBRequestModel.status = status;
                      } else if (fakultas == 'Ilmu Sosial dan Politik') {
                        presensiOUTMahasiswaToFISIPRequestModel.idkelas =
                            idkelasFakultas;

                        presensiOUTMahasiswaToFISIPRequestModel.npm = npm;

                        presensiOUTMahasiswaToFISIPRequestModel.pertemuan =
                            pertemuan;

                        // presensiOUTMahasiswaToFISIPRequestModel.tglout = jam +
                        //     ' ' +
                        //     tanggalnow;

                        presensiOUTMahasiswaToFISIPRequestModel.status = status;
                      } else if (fakultas == 'Teknik') {
                        presensiOUTMahasiswaToFTRequestModel.idkelas =
                            idkelasFakultas;

                        presensiOUTMahasiswaToFTRequestModel.npm = npm;

                        presensiOUTMahasiswaToFTRequestModel.pertemuan =
                            pertemuan;

                        // presensiOUTMahasiswaToFTRequestModel.tglout = jam +
                        //     ' ' +
                        //     tanggalnow;

                        presensiOUTMahasiswaToFTRequestModel.status = status;
                      } else if (fakultas == 'Teknologi Industri') {
                        presensiOUTMahasiswaToFTIRequestModel.idkelas =
                            idkelasFakultas;

                        presensiOUTMahasiswaToFTIRequestModel.npm = npm;

                        presensiOUTMahasiswaToFTIRequestModel.pertemuan =
                            pertemuan;

                        // presensiOUTMahasiswaToFTIRequestModel.tglout = jam +
                        //     ' ' +
                        //     tanggalnow;

                        presensiOUTMahasiswaToFTIRequestModel.status = status;
                      }
                    });
                    print(PresensiOUTMahasiswaToKSIRequestModel().toJson());

                    if (fakultas == 'Bisnis dan Ekonomika') {
                      print(PresensiOUTMahasiswaToFBERequestModel().toJson());
                    } else if (fakultas == 'Hukum') {
                      print(PresensiOUTMahasiswaToFHRequestModel().toJson());
                    } else if (fakultas == 'Teknobiologi') {
                      print(PresensiOUTMahasiswaToFTBRequestModel().toJson());
                    } else if (fakultas == 'Ilmu Sosial dan Politik') {
                      print(PresensiOUTMahasiswaToFISIPRequestModel().toJson());
                    } else if (fakultas == 'Teknik') {
                      print(PresensiOUTMahasiswaToFTRequestModel().toJson());
                    } else if (fakultas == 'Teknologi Industri') {
                      print(PresensiOUTMahasiswaToFTIRequestModel().toJson());
                    }

                    Future.delayed(Duration(seconds: 10), () async {
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

                    if (fakultas == 'Bisnis dan Ekonomika') {
                      await apiService.putAnulirMhsToFBE(
                          presensiOUTMahasiswaToFBERequestModel);
                    } else if (fakultas == 'Hukum') {
                      await apiService.putAnulirMhsToFH(
                          presensiOUTMahasiswaToFHRequestModel);
                    } else if (fakultas == 'Teknobiologi') {
                      await apiService.putAnulirMhsToFTB(
                          presensiOUTMahasiswaToFTBRequestModel);
                    } else if (fakultas == 'Ilmu Sosial dan Politik') {
                      await apiService.putAnulirMhsToFISIP(
                          presensiOUTMahasiswaToFISIPRequestModel);
                    } else if (fakultas == 'Teknik') {
                      await apiService.putAnulirMhsToFT(
                          presensiOUTMahasiswaToFTRequestModel);
                    } else if (fakultas == 'Teknologi Industri') {
                      await apiService.putAnulirMhsToFTI(
                          presensiOUTMahasiswaToFTIRequestModel);
                    }

                    await apiService
                        .putAnulirMhsToKSI(
                            presensiOUTMahasiswaToKSIRequestModel)
                        .then((value) async {
                      if (value != null) {
                        setState(() {
                          isApiCallProcess = false;
                        });
                      }
                      Get.back();

                      await Fluttertoast.showToast(
                          msg: 'Berhasil mengubah data',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 14.0);
                    });
                  },
                  onCancelBtnTap: (value) {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
