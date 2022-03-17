import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:presensiblebeacon/API/APIService.dart';
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
import 'package:presensiblebeacon/MODEL/Presensi/KSI/Dosen/PresensiINDosenBukaPresensiModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/KSI/Dosen/PresensiINOUTOUTPresensiDosen.dart';
import 'package:presensiblebeacon/MODEL/Presensi/KSI/Dosen/PresensiINOUTPresensiDosen.dart';
import 'package:presensiblebeacon/MODEL/Presensi/KSI/Dosen/PresensiOutMahasiswaModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/KSI/Dosen/PresensiOutMahasiswaTidakHadirModel.dart';
import 'package:presensiblebeacon/UTILS/ProgressHUD.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sk_alert_dialog/sk_alert_dialog.dart';

class PindaiKelasDosenPage extends StatefulWidget {
  @override
  _PindaiKelasDosenPageState createState() => _PindaiKelasDosenPageState();
}

class _PindaiKelasDosenPageState extends State<PindaiKelasDosenPage>
    with WidgetsBindingObserver {
  bool showFab = true;
  ScrollController _scrollController;

  final StreamController<BluetoothState> streamController = StreamController();

  StreamSubscription<BluetoothState> _streamBluetooth;
  StreamSubscription<RangingResult> _streamRanging;

  final _regionBeacons = <Region, List<Beacon>>{};
  final _beacons = <Beacon>[];

  bool authorizationStatusOk = false;
  bool locationServiceEnabled = false;
  bool bluetoothEnabled = false;

  String uuid = "";
  double jarakmin = 0;
  int major = 0;
  int minor = 0;

  String namadsn = "";
  String npp = "";
  String fakultas = "";

  int idkelas = 0;
  String ruang = "";
  String namamk = "";
  String kelas = "";
  int sks = 0;
  int pertemuan = 0;
  String hari = "";
  String sesi = "";
  int kapasitas = 0;
  String jam = "";
  String jammasuk = "";
  String jamkeluar = "";
  String tanggalnow = "";
  String tanggalmasuk = "";
  String tanggalkeluar = "";
  int bukapresensi = 0;

  String idkelasString;
  String idkelasFakultas;

  var _materiFieldController = TextEditingController();

  var _keteranganFieldController = TextEditingController();

  var _materiFieldFocus = FocusNode();

  var _keteranganFieldFocus = FocusNode();

  bool isApiCallProcess = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  PresensiINDosenBukaPresensiRequestModel
      presensiINDosenBukaPresensiRequestModel;

  PresensiINOUTDosenBukaPresensiRequestModel
      presensiINOUTDosenBukaPresensiRequestModel;

  PresensiINOUTOUTDosenBukaPresensiRequestModel
      presensiINOUTOUTDosenBukaPresensiRequestModel;

  PresensiOUTMahasiswaRequestModel presensiOUTMahasiswaRequestModel;

  PresensiOUTMahasiswaFBERequestModel presensiOUTMahasiswaFBERequestModel;

  PresensiOUTMahasiswaFHRequestModel presensiOUTMahasiswaFHRequestModel;

  PresensiOUTMahasiswaFISIPRequestModel presensiOUTMahasiswaFISIPRequestModel;

  PresensiOUTMahasiswaFTRequestModel presensiOUTMahasiswaFTRequestModel;

  PresensiOUTMahasiswaFTBRequestModel presensiOUTMahasiswaFTBRequestModel;

  PresensiOUTMahasiswaFTIRequestModel presensiOUTMahasiswaFTIRequestModel;

  PresensiOUTMahasiswaTidakHadirRequestModel
      presensiOUTMahasiswaTidakHadirRequestModel;
  PresensiOUTMahasiswaTidakHadirFBERequestModel
      presensiOUTMahasiswaTidakHadirFBERequestModel;
  PresensiOUTMahasiswaTidakHadirFHRequestModel
      presensiOUTMahasiswaTidakHadirFHRequestModel;
  PresensiOUTMahasiswaTidakHadirFISIPRequestModel
      presensiOUTMahasiswaTidakHadirFISIPRequestModel;
  PresensiOUTMahasiswaTidakHadirFTRequestModel
      presensiOUTMahasiswaTidakHadirFTRequestModel;
  PresensiOUTMahasiswaTidakHadirFTBRequestModel
      presensiOUTMahasiswaTidakHadirFTBRequestModel;
  PresensiOUTMahasiswaTidakHadirFTIRequestModel
      presensiOUTMahasiswaTidakHadirFTIRequestModel;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    listeningState();

    presensiINDosenBukaPresensiRequestModel =
        PresensiINDosenBukaPresensiRequestModel();

    presensiINOUTDosenBukaPresensiRequestModel =
        PresensiINOUTDosenBukaPresensiRequestModel();

    presensiINOUTOUTDosenBukaPresensiRequestModel =
        PresensiINOUTOUTDosenBukaPresensiRequestModel();

    presensiOUTMahasiswaRequestModel = PresensiOUTMahasiswaRequestModel();

    presensiOUTMahasiswaFBERequestModel = PresensiOUTMahasiswaFBERequestModel();

    presensiOUTMahasiswaFHRequestModel = PresensiOUTMahasiswaFHRequestModel();

    presensiOUTMahasiswaFISIPRequestModel =
        PresensiOUTMahasiswaFISIPRequestModel();

    presensiOUTMahasiswaFTRequestModel = PresensiOUTMahasiswaFTRequestModel();

    presensiOUTMahasiswaFTBRequestModel = PresensiOUTMahasiswaFTBRequestModel();

    presensiOUTMahasiswaFTIRequestModel = PresensiOUTMahasiswaFTIRequestModel();

    presensiOUTMahasiswaTidakHadirRequestModel =
        PresensiOUTMahasiswaTidakHadirRequestModel();

    presensiOUTMahasiswaTidakHadirFBERequestModel =
        PresensiOUTMahasiswaTidakHadirFBERequestModel();

    presensiOUTMahasiswaTidakHadirFHRequestModel =
        PresensiOUTMahasiswaTidakHadirFHRequestModel();

    presensiOUTMahasiswaTidakHadirFISIPRequestModel =
        PresensiOUTMahasiswaTidakHadirFISIPRequestModel();

    presensiOUTMahasiswaTidakHadirFTRequestModel =
        PresensiOUTMahasiswaTidakHadirFTRequestModel();

    presensiOUTMahasiswaTidakHadirFTBRequestModel =
        PresensiOUTMahasiswaTidakHadirFTBRequestModel();

    presensiOUTMahasiswaTidakHadirFTIRequestModel =
        PresensiOUTMahasiswaTidakHadirFTIRequestModel();

    // Timer.periodic(Duration(seconds: 1), (Timer t) {
    //   getDetailKelas();
    //   // getDetailDosen();
    //   Future.delayed(Duration(seconds: 5), () {
    //     t.cancel();
    //   });
    // });

    // Timer.periodic(Duration(seconds: 1), (Timer t) {
    //   // getDetailKelas();
    //   getDetailDosen();
    //   Future.delayed(Duration(seconds: 5), () {
    //     t.cancel();
    //   });
    // });

    // Timer.periodic(Duration(seconds: 1), (Timer t) {
    //   getIDKelasFakultas();

    //   Future.delayed(Duration(seconds: 5), () {
    //     t.cancel();
    //   });
    // });
  }

  getDetailDosen() async {
    SharedPreferences loginDosen = await SharedPreferences.getInstance();

    setState(() {
      npp = loginDosen.getString('npp');
      namadsn = loginDosen.getString('namadsn');
      fakultas = loginDosen.getString('fakultas');
    });
  }

  getIDKelasFakultas() async {
    idkelasString = idkelas.toString();

    idkelasFakultas = idkelasString.substring(1);
  }

  getDetailKelas() async {
    SharedPreferences dataPresensiDosen = await SharedPreferences.getInstance();

    setState(() {
      idkelas = dataPresensiDosen.getInt('idkelas');
      ruang = dataPresensiDosen.getString('ruang');
      namamk = dataPresensiDosen.getString('namamk');
      kelas = dataPresensiDosen.getString('kelas');
      sks = dataPresensiDosen.getInt('sks');
      pertemuan = dataPresensiDosen.getInt('pertemuan');
      hari = dataPresensiDosen.getString('hari1');
      sesi = dataPresensiDosen.getString('sesi1');
      kapasitas = dataPresensiDosen.getInt('kapasitas');
      jam = dataPresensiDosen.getString('jam');
      jammasuk = dataPresensiDosen.getString('jammasuk');
      jamkeluar = dataPresensiDosen.getString('jamkeluar');
      tanggalnow = dataPresensiDosen.getString('tanggalnow');
      tanggalmasuk = dataPresensiDosen.getString('tglmasuk');
      tanggalkeluar = dataPresensiDosen.getString('tglkeluar');
      bukapresensi = dataPresensiDosen.getInt('bukapresensi');
    });
  }

  getProximityUUID() async {
    SharedPreferences dataPresensiDosen = await SharedPreferences.getInstance();

    setState(() {
      uuid = dataPresensiDosen.getString('uuid');
      jarakmin = dataPresensiDosen.getDouble('jarakmin') ?? 0.0;
      major = dataPresensiDosen.getInt('major');
      minor = dataPresensiDosen.getInt('minor');
    });
  }

  listeningState() async {
    if (Platform.isAndroid) {
      print('Listening to bluetooth state');
      _streamBluetooth = flutterBeacon
          .bluetoothStateChanged()
          .listen((BluetoothState state) async {
        print('BluetoothState = $state');
        streamController.add(state);
        if (BluetoothState.stateOn == state) {
          initScanBeacon();
        }
        if (BluetoothState.stateOff == state) {
          await pauseScanBeacon();
          await checkAllRequirements();
        }
      });
    } else if (Platform.isIOS) {
      print('Listening to bluetooth state');
      _streamBluetooth = flutterBeacon
          .bluetoothStateChanged()
          .listen((BluetoothState state) async {
        print('BluetoothState = $state');
        streamController.add(state);

        if (BluetoothState.stateOn == state) {
          initScanBeacon();
        }
        if (BluetoothState.stateOff == state) {
          await pauseScanBeacon();
        }
      });
    }
  }

  initScanBeacon() async {
    await flutterBeacon.initializeScanning;
    await checkAllRequirements();
    if (!authorizationStatusOk ||
        !locationServiceEnabled ||
        !bluetoothEnabled) {
      print('RETURNED, authorizationStatusOk=$authorizationStatusOk, '
          'locationServiceEnabled=$locationServiceEnabled, '
          'bluetoothEnabled=$bluetoothEnabled');
      return;
    }

    if (_streamRanging != null) {
      if (_streamRanging.isPaused) {
        _streamRanging.resume();
        return;
      }
    }

    if (Platform.isIOS) {
      _streamRanging = flutterBeacon.ranging(<Region>[
        new Region(
          identifier: '',
          proximityUUID: uuid,
          major: major,
          minor: minor,
        )
      ]).listen((RangingResult result) {
        print(result);
        if (result != null && mounted) {
          setState(() {
            _regionBeacons[result.region] = result.beacons;
            _beacons.clear();
            _regionBeacons.values.forEach((list) {
              _beacons.addAll(list);
            });
            _beacons.sort(_compareParameters);
          });
        }
      });
    } else if (Platform.isAndroid) {
      _streamRanging = flutterBeacon.ranging(<Region>[
        new Region(
          identifier: '',
          proximityUUID: uuid,
          major: major,
          minor: minor,
        )
      ]).listen((RangingResult result) {
        print(result);
        if (result != null && mounted) {
          setState(() {
            _regionBeacons[result.region] = result.beacons;
            _beacons.clear();
            _regionBeacons.values.forEach((list) {
              _beacons.addAll(list);
            });
            _beacons.sort(_compareParameters);
          });
        }
      });
    }
  }

  checkAllRequirements() async {
    final bluetoothState = await flutterBeacon.bluetoothState;
    final bluetoothEnabled = bluetoothState == BluetoothState.stateOn;
    final authorizationStatus = await flutterBeacon.authorizationStatus;
    final authorizationStatusOk =
        authorizationStatus == AuthorizationStatus.allowed ||
            authorizationStatus == AuthorizationStatus.always;
    final locationServiceEnabled =
        await flutterBeacon.checkLocationServicesIfEnabled;

    setState(() {
      this.authorizationStatusOk = authorizationStatusOk;
      this.locationServiceEnabled = locationServiceEnabled;
      this.bluetoothEnabled = bluetoothEnabled;
    });
  }

  pauseScanBeacon() async {
    _streamRanging?.pause();
    if (_beacons.isNotEmpty) {
      setState(() {
        _beacons.clear();
      });
    }
  }

  int _compareParameters(Beacon a, Beacon b) {
    int compare = a.proximityUUID.compareTo(b.proximityUUID);

    if (compare == 0) {
      compare = a.major.compareTo(b.major);
    }

    if (compare == 0) {
      compare = a.minor.compareTo(b.minor);
    }

    return compare;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (Platform.isAndroid) {
      print('AppLifecycleState = $state');
      if (state == AppLifecycleState.resumed) {
        if (_streamBluetooth != null && _streamBluetooth.isPaused) {
          _streamBluetooth.resume();
        }
        await checkAllRequirements();
        if (authorizationStatusOk &&
            locationServiceEnabled &&
            bluetoothEnabled) {
          await initScanBeacon();
        } else {
          await pauseScanBeacon();
          await checkAllRequirements();
        }
      } else if (state == AppLifecycleState.paused) {
        _streamBluetooth?.pause();
      }
    } else if (Platform.isIOS) {
      print('AppLifecycleState = $state');
      if (state == AppLifecycleState.resumed) {
        if (_streamBluetooth != null && _streamBluetooth.isPaused) {
          _streamBluetooth.resume();
        }
      } else if (state == AppLifecycleState.paused) {
        _streamBluetooth?.pause();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    streamController?.close();
    _streamRanging?.cancel();
    _streamBluetooth?.cancel();
    flutterBeacon.close;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: buildDetailPresensiDosen(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0,
    );
  }

  // @override
  Widget buildDetailPresensiDosen(BuildContext context) {
    getDetailKelas();
    getProximityUUID();
    getDetailDosen();
    getIDKelasFakultas();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
        floatingActionButton: showFab
            ? FloatingActionButton(
                onPressed: () => {
                  _scrollController
                      .jumpTo(_scrollController.position.maxScrollExtent)
                },
                child: Icon(Icons.arrow_downward_rounded),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: AppBar(
          centerTitle: false,
          // title: Text(
          //   'Detail',
          //   style: TextStyle(
          //       color: Colors.black,
          //       fontFamily: 'OpenSans',
          //       fontWeight: FontWeight.bold),
          // ),
          actions: <Widget>[
            if (!authorizationStatusOk)
              IconButton(
                  icon: Icon(Icons.portable_wifi_off),
                  color: Colors.red,
                  onPressed: () async {
                    await flutterBeacon.requestAuthorization;
                  }),
            if (!locationServiceEnabled)
              IconButton(
                  icon: Icon(Icons.location_off),
                  color: Colors.red,
                  onPressed: () async {
                    if (Platform.isAndroid) {
                      await flutterBeacon.openLocationSettings;
                    } else if (Platform.isIOS) {
                      // await _jumpToSetting();
                    }
                  }),
            StreamBuilder<BluetoothState>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final state = snapshot.data;

                  if (state == BluetoothState.stateOn) {
                    return Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Bluetooth Hidup',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.bluetooth_connected),
                          onPressed: () {},
                          color: Colors.blue,
                        ),
                      ],
                    );
                  }

                  if (state == BluetoothState.stateOff) {
                    return Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Bluetooth Mati',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.bluetooth),
                          onPressed: () async {
                            if (Platform.isAndroid) {
                              try {
                                await flutterBeacon.openBluetoothSettings;
                              } on PlatformException catch (e) {
                                print(e);
                              }
                            } else if (Platform.isIOS) {
                              try {
                                // await _jumpToSetting();
                              } on PlatformException catch (e) {
                                print(e);
                              }
                            }
                          },
                          color: Colors.red,
                        ),
                      ],
                    );
                  }

                  return Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Bluetooth Tidak Aktif',
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.bluetooth_disabled_rounded),
                        onPressed: () {},
                        color: Colors.grey,
                      ),
                    ],
                  );
                }

                return SizedBox.shrink();
              },
              stream: streamController.stream,
              initialData: BluetoothState.stateUnknown,
            ),
          ],
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.grey[50],
          elevation: 0,
        ),
        body: Container(
            color: Colors.grey[50],
            child: _beacons == null || _beacons.isEmpty
                ? Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MaterialButton(
                                  color: Colors.blue[300],
                                  shape: StadiumBorder(),
                                  padding: EdgeInsets.only(
                                      left: 50, right: 50, top: 25, bottom: 25),
                                  onPressed: () =>
                                      {Get.offAllNamed('/dosen/dashboard')},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.arrow_back_rounded,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        'Kembali',
                                        style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Column(
                                      children: <Widget>[
                                        uuid != "-"
                                            ? SpinKitRipple(
                                                color: Colors.black,
                                                size: 100,
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.warning_rounded,
                                                  color: Colors.red,
                                                  size: 100,
                                                ),
                                              ),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        uuid != '-'
                                            ? Text(
                                                'Mohon Tunggu...',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'OpenSans',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              )
                                            : Text(
                                                'Tidak ada perangkat beacon di ruangan',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'OpenSans',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        uuid != '-'
                                            ? Text(
                                                'Aplikasi sedang melakukan pemindaian',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'OpenSans',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Silahkan menghubungi admin',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'OpenSans',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        uuid != '-'
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Pastikan anda dekat dengan ruangan',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'OpenSans',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : NotificationListener<UserScrollNotification>(
                    onNotification: (notification) {
                      setState(() {
                        if (notification.direction == ScrollDirection.reverse) {
                          showFab = true;
                        } else if (notification.direction ==
                            ScrollDirection.forward) {
                          showFab = true;
                        }
                      });
                      return true;
                    },
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                            children: ListTile.divideTiles(
                                context: context,
                                tiles: _beacons.map((beacon) {
                                  if (beacon.accuracy < jarakmin) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: new Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: MaterialButton(
                                              color: Colors.blue[200],
                                              shape: StadiumBorder(),
                                              padding: EdgeInsets.only(
                                                  left: 50,
                                                  right: 50,
                                                  top: 25,
                                                  bottom: 25),
                                              onPressed: () => {
                                                Get.offAllNamed(
                                                    '/dosen/dashboard')
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.arrow_back_rounded,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    'Kembali',
                                                    style: TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
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
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: Initicon(
                                                      text: namadsn ?? '-',
                                                      backgroundColor:
                                                          Colors.grey[300],
                                                      size: 80,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: Scrollbar(
                                                            child:
                                                                SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              child: Text(
                                                                  namadsn ??
                                                                      '-',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          'OpenSans',
                                                                      fontSize:
                                                                          18)),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      npp ?? '-',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'OpenSans',
                                                          fontSize: 16),
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
                                                        offset:
                                                            Offset(0.0, 0.0),
                                                        blurRadius: 0.75,
                                                        spreadRadius: 0.25)
                                                  ],
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Scrollbar(
                                                      child:
                                                          SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Text(
                                                          '${namamk ?? '-'} ${kelas ?? '-'}',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'OpenSans',
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'Pertemuan ${pertemuan ?? '-'}',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'OpenSans',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Container(
                                          //   decoration: BoxDecoration(
                                          //       color: Colors.grey[200],
                                          //       borderRadius:
                                          //           BorderRadius.circular(25)),
                                          //   child: new Padding(
                                          //       padding: EdgeInsets.all(10),
                                          //       child: Column(
                                          //         children: <Widget>[
                                          //           Container(
                                          //             decoration: BoxDecoration(
                                          //                 color: Colors.blue,
                                          //                 borderRadius:
                                          //                     BorderRadius
                                          //                         .circular(
                                          //                             25)),
                                          //             child: Padding(
                                          //               padding:
                                          //                   const EdgeInsets
                                          //                       .all(8.0),
                                          //               child: Row(
                                          //                 mainAxisAlignment:
                                          //                     MainAxisAlignment
                                          //                         .center,
                                          //                 children: [
                                          //                   Padding(
                                          //                     padding:
                                          //                         const EdgeInsets
                                          //                             .all(8.0),
                                          //                     child: Icon(
                                          //                         Icons.book,
                                          //                         color: Colors
                                          //                             .white),
                                          //                   ),
                                          //                   new Text(
                                          //                     'Detail Kelas',
                                          //                     style: TextStyle(
                                          //                         fontFamily:
                                          //                             'OpenSans',
                                          //                         fontWeight:
                                          //                             FontWeight
                                          //                                 .bold,
                                          //                         fontSize: 20,
                                          //                         color: Colors
                                          //                             .white),
                                          //                   ),
                                          //                 ],
                                          //               ),
                                          //             ),
                                          //           ),
                                          //           Padding(
                                          //             padding:
                                          //                 const EdgeInsets.all(
                                          //                     8.0),
                                          //             child: new Center(
                                          //               child: new Text(
                                          //                 '${namamk ?? "-"} '
                                          //                 '${kelas ?? "-"}',
                                          //                 style: TextStyle(
                                          //                     fontFamily:
                                          //                         'OpenSans',
                                          //                     // fontWeight:
                                          //                     //     FontWeight.bold,
                                          //                     fontSize: 20,
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .bold),
                                          //               ),
                                          //             ),
                                          //           ),
                                          //           Scrollbar(
                                          //             child: Container(
                                          //               child:
                                          //                   SingleChildScrollView(
                                          //                 scrollDirection:
                                          //                     Axis.horizontal,
                                          //                 child: Row(
                                          //                   mainAxisAlignment:
                                          //                       MainAxisAlignment
                                          //                           .spaceBetween,
                                          //                   children: [
                                          //                     Padding(
                                          //                       padding: const EdgeInsets
                                          //                               .symmetric(
                                          //                           horizontal:
                                          //                               20),
                                          //                       child:
                                          //                           Container(
                                          //                         child:
                                          //                             Padding(
                                          //                           padding:
                                          //                               const EdgeInsets.all(
                                          //                                   8.0),
                                          //                           child:
                                          //                               Column(
                                          //                             children: [
                                          //                               Padding(
                                          //                                 padding:
                                          //                                     const EdgeInsets.all(8.0),
                                          //                                 child:
                                          //                                     Icon(Icons.meeting_room_rounded),
                                          //                               ),
                                          //                               new Container(
                                          //                                 child:
                                          //                                     new Text(
                                          //                                   'Pertemuan ${pertemuan ?? "-"}',
                                          //                                   style: TextStyle(
                                          //                                       fontFamily: 'OpenSans',
                                          //                                       fontWeight: FontWeight.bold,
                                          //                                       fontSize: 18),
                                          //                                 ),
                                          //                               ),
                                          //                             ],
                                          //                           ),
                                          //                         ),
                                          //                       ),
                                          //                     ),
                                          //                     Padding(
                                          //                       padding: const EdgeInsets
                                          //                               .symmetric(
                                          //                           horizontal:
                                          //                               20),
                                          //                       child:
                                          //                           Container(
                                          //                         child:
                                          //                             Padding(
                                          //                           padding:
                                          //                               const EdgeInsets.all(
                                          //                                   8.0),
                                          //                           child:
                                          //                               Column(
                                          //                             children: [
                                          //                               Padding(
                                          //                                 padding:
                                          //                                     const EdgeInsets.all(8.0),
                                          //                                 child:
                                          //                                     Icon(Icons.credit_card_rounded),
                                          //                               ),
                                          //                               new Text(
                                          //                                 '${sks ?? "-"} SKS',
                                          //                                 style: TextStyle(
                                          //                                     fontFamily: 'OpenSans',
                                          //                                     fontWeight: FontWeight.bold,
                                          //                                     fontSize: 18),
                                          //                               ),
                                          //                             ],
                                          //                           ),
                                          //                         ),
                                          //                       ),
                                          //                     ),
                                          //                   ],
                                          //                 ),
                                          //               ),
                                          //             ),
                                          //           ),
                                          //           ExpansionTile(
                                          //             title: Text(
                                          //               'Lihat lebih detail',
                                          //               style: TextStyle(
                                          //                   fontFamily:
                                          //                       'OpenSans',
                                          //                   fontWeight:
                                          //                       FontWeight.bold,
                                          //                   fontSize: 14),
                                          //             ),
                                          //             children: [
                                          //               Scrollbar(
                                          //                 child: Container(
                                          //                   child:
                                          //                       SingleChildScrollView(
                                          //                     scrollDirection:
                                          //                         Axis.horizontal,
                                          //                     child: Row(
                                          //                       mainAxisAlignment:
                                          //                           MainAxisAlignment
                                          //                               .spaceBetween,
                                          //                       children: [
                                          //                         Padding(
                                          //                           padding: const EdgeInsets
                                          //                                   .symmetric(
                                          //                               horizontal:
                                          //                                   20),
                                          //                           child:
                                          //                               Container(
                                          //                             child:
                                          //                                 Padding(
                                          //                               padding:
                                          //                                   const EdgeInsets.all(8.0),
                                          //                               child:
                                          //                                   Column(
                                          //                                 children: [
                                          //                                   Column(
                                          //                                     children: [
                                          //                                       Padding(
                                          //                                         padding: const EdgeInsets.all(8.0),
                                          //                                         child: Icon(Icons.door_sliding_rounded),
                                          //                                       ),
                                          //                                       Column(
                                          //                                         children: [
                                          //                                           new Text(
                                          //                                             'Ruangan',
                                          //                                             style: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold, fontSize: 20),
                                          //                                           ),
                                          //                                         ],
                                          //                                       ),
                                          //                                     ],
                                          //                                   ),
                                          //                                   Padding(
                                          //                                     padding: const EdgeInsets.all(8.0),
                                          //                                     child: new Center(
                                          //                                       child: new Text(
                                          //                                         '${ruang ?? "-"}',
                                          //                                         style: TextStyle(
                                          //                                             fontFamily: 'OpenSans',
                                          //                                             // fontWeight:
                                          //                                             //     FontWeight.bold,
                                          //                                             fontSize: 16),
                                          //                                       ),
                                          //                                     ),
                                          //                                   ),
                                          //                                 ],
                                          //                               ),
                                          //                             ),
                                          //                           ),
                                          //                         ),
                                          //                         Column(
                                          //                           children: [
                                          //                             Padding(
                                          //                               padding:
                                          //                                   const EdgeInsets.symmetric(horizontal: 20),
                                          //                               child:
                                          //                                   Container(
                                          //                                 child:
                                          //                                     Padding(
                                          //                                   padding:
                                          //                                       const EdgeInsets.all(8.0),
                                          //                                   child:
                                          //                                       Column(
                                          //                                     children: [
                                          //                                       Column(
                                          //                                         children: [
                                          //                                           Padding(
                                          //                                             padding: const EdgeInsets.all(8.0),
                                          //                                             child: Icon(Icons.people_rounded),
                                          //                                           ),
                                          //                                           new Text(
                                          //                                             'Kapasitas',
                                          //                                             style: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold, fontSize: 20),
                                          //                                           ),
                                          //                                         ],
                                          //                                       ),
                                          //                                       Padding(
                                          //                                         padding: const EdgeInsets.all(8.0),
                                          //                                         child: new Center(
                                          //                                           child: new Text(
                                          //                                             '${kapasitas ?? "-"} Orang',
                                          //                                             style: TextStyle(
                                          //                                                 fontFamily: 'OpenSans',
                                          //                                                 // fontWeight:
                                          //                                                 //     FontWeight.bold,
                                          //                                                 fontSize: 16),
                                          //                                           ),
                                          //                                         ),
                                          //                                       ),
                                          //                                     ],
                                          //                                   ),
                                          //                                 ),
                                          //                               ),
                                          //                             ),
                                          //                           ],
                                          //                         ),
                                          //                       ],
                                          //                     ),
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //               Padding(
                                          //                 padding:
                                          //                     const EdgeInsets
                                          //                         .all(8.0),
                                          //                 child: Divider(
                                          //                   height: 1,
                                          //                   thickness: 2,
                                          //                   color: Colors.black,
                                          //                 ),
                                          //               ),
                                          //               Scrollbar(
                                          //                 child: Container(
                                          //                   child:
                                          //                       SingleChildScrollView(
                                          //                     scrollDirection:
                                          //                         Axis.horizontal,
                                          //                     child: Row(
                                          //                       mainAxisAlignment:
                                          //                           MainAxisAlignment
                                          //                               .spaceBetween,
                                          //                       children: [
                                          //                         Column(
                                          //                           children: [
                                          //                             Padding(
                                          //                               padding:
                                          //                                   const EdgeInsets.all(8.0),
                                          //                               child:
                                          //                                   new Center(
                                          //                                 child:
                                          //                                     Column(
                                          //                                   children: [
                                          //                                     Padding(
                                          //                                       padding: const EdgeInsets.all(8.0),
                                          //                                       child: Icon(Icons.date_range_rounded),
                                          //                                     ),
                                          //                                     new Text(
                                          //                                       'Tanggal',
                                          //                                       style: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold, fontSize: 20),
                                          //                                     ),
                                          //                                   ],
                                          //                                 ),
                                          //                               ),
                                          //                             ),
                                          //                             Padding(
                                          //                               padding:
                                          //                                   const EdgeInsets.all(8.0),
                                          //                               child:
                                          //                                   new Center(
                                          //                                 child:
                                          //                                     new Text(
                                          //                                   '${hari ?? "-"}, ${tanggalnow ?? "-"}',
                                          //                                   style: TextStyle(
                                          //                                       fontFamily: 'OpenSans',
                                          //                                       // fontWeight:
                                          //                                       //     FontWeight.bold,
                                          //                                       fontSize: 14),
                                          //                                 ),
                                          //                               ),
                                          //                             ),
                                          //                           ],
                                          //                         ),
                                          //                         Column(
                                          //                           children: [
                                          //                             Padding(
                                          //                               padding:
                                          //                                   const EdgeInsets.all(8.0),
                                          //                               child:
                                          //                                   new Center(
                                          //                                 child:
                                          //                                     Column(
                                          //                                   children: [
                                          //                                     Padding(
                                          //                                       padding: const EdgeInsets.all(8.0),
                                          //                                       child: Icon(Icons.timer),
                                          //                                     ),
                                          //                                     new Text(
                                          //                                       'Jam',
                                          //                                       style: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold, fontSize: 20),
                                          //                                     ),
                                          //                                   ],
                                          //                                 ),
                                          //                               ),
                                          //                             ),
                                          //                             Padding(
                                          //                               padding:
                                          //                                   const EdgeInsets.all(8.0),
                                          //                               child:
                                          //                                   new Center(
                                          //                                 child:
                                          //                                     new Text(
                                          //                                   '${jammasuk ?? "-"} - ${jamkeluar ?? "-"}',
                                          //                                   style: TextStyle(
                                          //                                       fontFamily: 'OpenSans',
                                          //                                       // fontWeight:
                                          //                                       //     FontWeight.bold,
                                          //                                       fontSize: 14),
                                          //                                 ),
                                          //                               ),
                                          //                             ),
                                          //                           ],
                                          //                         ),
                                          //                       ],
                                          //                     ),
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //             ],
                                          //           ),
                                          //         ],
                                          //       )),
                                          // ),
                                          // Column(
                                          //   children: <Widget>[
                                          //     SizedBox(
                                          //       height: 8,
                                          //     ),
                                          //     Container(
                                          //       decoration: BoxDecoration(
                                          //           color: Colors.grey[200],
                                          //           borderRadius:
                                          //               BorderRadius.circular(
                                          //                   25)),
                                          //       child: Column(
                                          //         children: <Widget>[
                                          //           Padding(
                                          //               padding:
                                          //                   const EdgeInsets
                                          //                       .all(8.0),
                                          //               child: bukapresensi == 0
                                          //                   ? Container(
                                          //                       decoration: BoxDecoration(
                                          //                           color: Colors
                                          //                               .green,
                                          //                           borderRadius:
                                          //                               BorderRadius.circular(
                                          //                                   25)),
                                          //                       child: Padding(
                                          //                         padding:
                                          //                             const EdgeInsets
                                          //                                     .all(
                                          //                                 8.0),
                                          //                         child: Row(
                                          //                           mainAxisAlignment:
                                          //                               MainAxisAlignment
                                          //                                   .center,
                                          //                           children: [
                                          //                             Padding(
                                          //                               padding:
                                          //                                   const EdgeInsets.all(8.0),
                                          //                               child:
                                          //                                   Icon(
                                          //                                 Icons
                                          //                                     .person,
                                          //                                 color:
                                          //                                     Colors.white,
                                          //                               ),
                                          //                             ),
                                          //                             new Text(
                                          //                               'Data Presensi Masuk',
                                          //                               style: TextStyle(
                                          //                                   fontFamily:
                                          //                                       'OpenSans',
                                          //                                   fontWeight: FontWeight
                                          //                                       .bold,
                                          //                                   fontSize:
                                          //                                       20,
                                          //                                   color:
                                          //                                       Colors.white),
                                          //                             ),
                                          //                           ],
                                          //                         ),
                                          //                       ),
                                          //                     )
                                          //                   : Container(
                                          //                       decoration: BoxDecoration(
                                          //                           color: Colors
                                          //                               .red,
                                          //                           borderRadius:
                                          //                               BorderRadius.circular(
                                          //                                   25)),
                                          //                       child: Padding(
                                          //                         padding:
                                          //                             const EdgeInsets
                                          //                                     .all(
                                          //                                 8.0),
                                          //                         child: Row(
                                          //                           mainAxisAlignment:
                                          //                               MainAxisAlignment
                                          //                                   .center,
                                          //                           children: [
                                          //                             Padding(
                                          //                               padding:
                                          //                                   const EdgeInsets.all(8.0),
                                          //                               child:
                                          //                                   Icon(
                                          //                                 Icons
                                          //                                     .person,
                                          //                                 color:
                                          //                                     Colors.white,
                                          //                               ),
                                          //                             ),
                                          //                             new Text(
                                          //                               'Data Presensi Keluar',
                                          //                               style: TextStyle(
                                          //                                   fontFamily:
                                          //                                       'OpenSans',
                                          //                                   fontWeight: FontWeight
                                          //                                       .bold,
                                          //                                   fontSize:
                                          //                                       20,
                                          //                                   color:
                                          //                                       Colors.white),
                                          //                             ),
                                          //                           ],
                                          //                         ),
                                          //                       ),
                                          //                     )),
                                          //           Padding(
                                          //             padding:
                                          //                 const EdgeInsets.all(
                                          //                     8.0),
                                          //             child: new Center(
                                          //               child: new Text(
                                          //                 'Nama Dosen',
                                          //                 style: TextStyle(
                                          //                     fontFamily:
                                          //                         'OpenSans',
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .bold,
                                          //                     fontSize: 20),
                                          //               ),
                                          //             ),
                                          //           ),
                                          //           Padding(
                                          //             padding: const EdgeInsets
                                          //                     .symmetric(
                                          //                 horizontal: 8),
                                          //             child: Scrollbar(
                                          //               child: Container(
                                          //                 child:
                                          //                     SingleChildScrollView(
                                          //                   scrollDirection:
                                          //                       Axis.horizontal,
                                          //                   child: Padding(
                                          //                     padding:
                                          //                         const EdgeInsets
                                          //                             .all(8.0),
                                          //                     child: new Center(
                                          //                       child: new Text(
                                          //                         namadsn,
                                          //                         style: TextStyle(
                                          //                             fontFamily:
                                          //                                 'OpenSans',
                                          //                             fontSize:
                                          //                                 16),
                                          //                       ),
                                          //                     ),
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //             ),
                                          //           ),
                                          //           ExpansionTile(
                                          //             title: Text(
                                          //               'Lihat lebih detail',
                                          //               style: TextStyle(
                                          //                   fontFamily:
                                          //                       'OpenSans',
                                          //                   fontWeight:
                                          //                       FontWeight.bold,
                                          //                   fontSize: 14),
                                          //             ),
                                          //             children: [
                                          //               Padding(
                                          //                 padding:
                                          //                     const EdgeInsets
                                          //                         .all(8.0),
                                          //                 child: new Center(
                                          //                   child: new Text(
                                          //                     'NPP',
                                          //                     style: TextStyle(
                                          //                         fontFamily:
                                          //                             'OpenSans',
                                          //                         fontWeight:
                                          //                             FontWeight
                                          //                                 .bold,
                                          //                         fontSize: 20),
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //               Padding(
                                          //                 padding:
                                          //                     const EdgeInsets
                                          //                         .all(8.0),
                                          //                 child: new Center(
                                          //                   child: new Text(
                                          //                     '${npp ?? "-"}',
                                          //                     style: TextStyle(
                                          //                         fontFamily:
                                          //                             'OpenSans',
                                          //                         // fontWeight:
                                          //                         //     FontWeight.bold,
                                          //                         fontSize: 16),
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //               Padding(
                                          //                 padding:
                                          //                     const EdgeInsets
                                          //                         .all(8.0),
                                          //                 child: Divider(
                                          //                   height: 1,
                                          //                   thickness: 2,
                                          //                   color: Colors.black,
                                          //                 ),
                                          //               ),
                                          //               bukapresensi == 0
                                          //                   ? Padding(
                                          //                       padding:
                                          //                           const EdgeInsets
                                          //                                   .all(
                                          //                               8.0),
                                          //                       child:
                                          //                           new Center(
                                          //                         child:
                                          //                             new Text(
                                          //                           'Jam Masuk',
                                          //                           style: TextStyle(
                                          //                               fontFamily:
                                          //                                   'OpenSans',
                                          //                               fontWeight:
                                          //                                   FontWeight
                                          //                                       .bold,
                                          //                               fontSize:
                                          //                                   20),
                                          //                         ),
                                          //                       ),
                                          //                     )
                                          //                   : Padding(
                                          //                       padding:
                                          //                           const EdgeInsets
                                          //                                   .all(
                                          //                               8.0),
                                          //                       child:
                                          //                           new Center(
                                          //                         child:
                                          //                             new Text(
                                          //                           'Jam Keluar',
                                          //                           style: TextStyle(
                                          //                               fontFamily:
                                          //                                   'OpenSans',
                                          //                               fontWeight:
                                          //                                   FontWeight
                                          //                                       .bold,
                                          //                               fontSize:
                                          //                                   20),
                                          //                         ),
                                          //                       )),
                                          //               Padding(
                                          //                 padding:
                                          //                     const EdgeInsets
                                          //                         .all(8.0),
                                          //                 child: new Center(
                                          //                   child: new Text(
                                          //                     '${jam ?? "-"}',
                                          //                     style: TextStyle(
                                          //                         fontFamily:
                                          //                             'OpenSans',
                                          //                         fontSize: 16),
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //             ],
                                          //           ),
                                          //           // Padding(
                                          //           //   padding:
                                          //           //       const EdgeInsets.all(
                                          //           //           8.0),
                                          //           //   child: Divider(
                                          //           //     height: 1,
                                          //           //     thickness: 2,
                                          //           //     color: Colors.black,
                                          //           //   ),
                                          //           // ),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          bukapresensi == 1
                                              ? Column(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors
                                                                    .grey[500],
                                                                offset: Offset(
                                                                    0.0, 0.0),
                                                                blurRadius:
                                                                    0.75,
                                                                spreadRadius:
                                                                    0.25)
                                                          ],
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Form(
                                                          key: globalFormKey,
                                                          child: Column(
                                                            children: <Widget>[
                                                              // Container(
                                                              //   decoration: BoxDecoration(
                                                              //       color: Colors
                                                              //               .blue[
                                                              //           300],
                                                              //       borderRadius:
                                                              //           BorderRadius.circular(
                                                              //               25)),
                                                              //   child: Padding(
                                                              //     padding:
                                                              //         const EdgeInsets
                                                              //                 .all(
                                                              //             8.0),
                                                              //     child: Row(
                                                              //       mainAxisAlignment:
                                                              //           MainAxisAlignment
                                                              //               .center,
                                                              //       children: [
                                                              //         Padding(
                                                              //           padding:
                                                              //               const EdgeInsets.all(8.0),
                                                              //           child:
                                                              //               Icon(
                                                              //             Icons
                                                              //                 .note_rounded,
                                                              //             color:
                                                              //                 Colors.black,
                                                              //           ),
                                                              //         ),
                                                              //         new Text(
                                                              //           'Catatan Pertemuan',
                                                              //           style: TextStyle(
                                                              //               fontFamily:
                                                              //                   'OpenSans',
                                                              //               fontWeight: FontWeight
                                                              //                   .bold,
                                                              //               fontSize:
                                                              //                   20,
                                                              //               color:
                                                              //                   Colors.black),
                                                              //         ),
                                                              //       ],
                                                              //     ),
                                                              //   ),
                                                              // ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Center(
                                                                  child: Text(
                                                                    'Keterangan',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontFamily:
                                                                            'OpenSans',
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Center(
                                                                    child:
                                                                        TextFormField(
                                                                  controller:
                                                                      _keteranganFieldController,
                                                                  focusNode:
                                                                      _keteranganFieldFocus,
                                                                  onFieldSubmitted:
                                                                      (term) {
                                                                    _fieldFocusChange(
                                                                        context,
                                                                        _keteranganFieldFocus,
                                                                        _materiFieldFocus);
                                                                  },
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'OpenSans',
                                                                      fontSize:
                                                                          16.0,
                                                                      color: Colors
                                                                          .black),
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  decoration:
                                                                      new InputDecoration(
                                                                          hintText:
                                                                              ''),
                                                                  // validator: (input) => input.length < 1
                                                                  //     ? "Materi tidak boleh kosong"
                                                                  //     : null,
                                                                  onSaved: (input) =>
                                                                      presensiINOUTOUTDosenBukaPresensiRequestModel
                                                                              .keterangan =
                                                                          input,
                                                                )),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Center(
                                                                  child: Text(
                                                                    'Materi',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontFamily:
                                                                            'OpenSans',
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Center(
                                                                    child:
                                                                        TextFormField(
                                                                  controller:
                                                                      _materiFieldController,
                                                                  focusNode:
                                                                      _materiFieldFocus,
                                                                  onFieldSubmitted:
                                                                      (value) {
                                                                    _materiFieldFocus
                                                                        .unfocus();
                                                                  },
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .done,
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'OpenSans',
                                                                      fontSize:
                                                                          16.0,
                                                                      color: Colors
                                                                          .black),
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  decoration:
                                                                      new InputDecoration(
                                                                          hintText:
                                                                              ''),
                                                                  // validator: (input) => input.length < 1
                                                                  //     ? "Materi tidak boleh kosong"
                                                                  //     : null,
                                                                  onSaved: (input) =>
                                                                      presensiINOUTOUTDosenBukaPresensiRequestModel
                                                                              .materi =
                                                                          input,
                                                                )),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(8),
                                                                  child:
                                                                      new Text(
                                                                    'Opsional',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontFamily:
                                                                          'OpenSans',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .blue,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : SizedBox(
                                                  height: 0,
                                                ),
                                          new Align(
                                            child: new Padding(
                                              padding: EdgeInsets.all(10),
                                              child: new Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    // bukapresensi == 0
                                                    //     ? Padding(
                                                    //         padding:
                                                    //             const EdgeInsets
                                                    //                 .all(8.0),
                                                    //         child:
                                                    //             MaterialButton(
                                                    //           color: Colors
                                                    //               .yellow[700],
                                                    //           shape:
                                                    //               StadiumBorder(),
                                                    //           padding: EdgeInsets
                                                    //               .only(
                                                    //                   left: 50,
                                                    //                   right: 50,
                                                    //                   top: 25,
                                                    //                   bottom:
                                                    //                       25),
                                                    //           onPressed: () => {
                                                    //             Get.toNamed(
                                                    //                 '/dosen/dashboard/presensi/detail/tampilpeserta')
                                                    //           },
                                                    //           child: Scrollbar(
                                                    //             child:
                                                    //                 Container(
                                                    //               child:
                                                    //                   SingleChildScrollView(
                                                    //                 scrollDirection:
                                                    //                     Axis.horizontal,
                                                    //                 child: Row(
                                                    //                   mainAxisAlignment:
                                                    //                       MainAxisAlignment
                                                    //                           .center,
                                                    //                   children: <
                                                    //                       Widget>[
                                                    //                     Icon(
                                                    //                       Icons
                                                    //                           .people_alt_rounded,
                                                    //                       color:
                                                    //                           Colors.white,
                                                    //                     ),
                                                    //                     SizedBox(
                                                    //                       width:
                                                    //                           20,
                                                    //                     ),
                                                    //                     Text(
                                                    //                       'Tampil Peserta Kelas',
                                                    //                       style: TextStyle(
                                                    //                           fontFamily: 'OpenSans',
                                                    //                           fontWeight: FontWeight.bold,
                                                    //                           color: Colors.white,
                                                    //                           fontSize: 18),
                                                    //                     ),
                                                    //                   ],
                                                    //                 ),
                                                    //               ),
                                                    //             ),
                                                    //           ),
                                                    //         ),
                                                    //       )
                                                    //     : Column(
                                                    //         children: <Widget>[
                                                    //           Padding(
                                                    //             padding:
                                                    //                 const EdgeInsets
                                                    //                         .all(
                                                    //                     8.0),
                                                    //             child:
                                                    //                 MaterialButton(
                                                    //               color: Colors
                                                    //                   .blue,
                                                    //               shape:
                                                    //                   StadiumBorder(),
                                                    //               padding: EdgeInsets.only(
                                                    //                   left: 50,
                                                    //                   right: 50,
                                                    //                   top: 25,
                                                    //                   bottom:
                                                    //                       25),
                                                    //               onPressed:
                                                    //                   () => {
                                                    //                 Get.toNamed(
                                                    //                     '/dosen/dashboard/presensi/detail/tampilkehadiranpeserta')
                                                    //               },
                                                    //               child:
                                                    //                   Scrollbar(
                                                    //                 child:
                                                    //                     Container(
                                                    //                   child:
                                                    //                       SingleChildScrollView(
                                                    //                     scrollDirection:
                                                    //                         Axis.horizontal,
                                                    //                     child:
                                                    //                         Row(
                                                    //                       mainAxisAlignment:
                                                    //                           MainAxisAlignment.center,
                                                    //                       children: <
                                                    //                           Widget>[
                                                    //                         Icon(
                                                    //                           Icons.people_alt_rounded,
                                                    //                           color: Colors.white,
                                                    //                         ),
                                                    //                         SizedBox(
                                                    //                           width: 20,
                                                    //                         ),
                                                    //                         Text(
                                                    //                           'Tampil Kehadiran Kelas',
                                                    //                           style: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                                                    //                         ),
                                                    //                       ],
                                                    //                     ),
                                                    //                   ),
                                                    //                 ),
                                                    //               ),
                                                    //             ),
                                                    //           ),
                                                    //           Padding(
                                                    //             padding:
                                                    //                 const EdgeInsets
                                                    //                         .all(
                                                    //                     8.0),
                                                    //             child:
                                                    //                 MaterialButton(
                                                    //               color: Colors
                                                    //                       .yellow[
                                                    //                   700],
                                                    //               shape:
                                                    //                   StadiumBorder(),
                                                    //               padding: EdgeInsets.only(
                                                    //                   left: 50,
                                                    //                   right: 50,
                                                    //                   top: 25,
                                                    //                   bottom:
                                                    //                       25),
                                                    //               onPressed:
                                                    //                   () => {
                                                    //                 Get.toNamed(
                                                    //                     '/dosen/dashboard/presensi/detail/tampilpeserta')
                                                    //               },
                                                    //               child:
                                                    //                   Scrollbar(
                                                    //                 child:
                                                    //                     Container(
                                                    //                   child:
                                                    //                       SingleChildScrollView(
                                                    //                     scrollDirection:
                                                    //                         Axis.horizontal,
                                                    //                     child:
                                                    //                         Row(
                                                    //                       mainAxisAlignment:
                                                    //                           MainAxisAlignment.center,
                                                    //                       children: <
                                                    //                           Widget>[
                                                    //                         Icon(
                                                    //                           Icons.people_alt_rounded,
                                                    //                           color: Colors.white,
                                                    //                         ),
                                                    //                         SizedBox(
                                                    //                           width: 20,
                                                    //                         ),
                                                    //                         Text(
                                                    //                           'Tampil Peserta Kelas',
                                                    //                           style: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                                                    //                         ),
                                                    //                       ],
                                                    //                     ),
                                                    //                   ),
                                                    //                 ),
                                                    //               ),
                                                    //             ),
                                                    //           ),
                                                    //         ],
                                                    //       ),
                                                    bukapresensi == 0
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                MaterialButton(
                                                              color: Colors
                                                                  .blue[300],
                                                              shape:
                                                                  StadiumBorder(),
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 50,
                                                                      right: 50,
                                                                      top: 25,
                                                                      bottom:
                                                                          25),
                                                              onPressed: () {
                                                                SKAlertDialog
                                                                    .show(
                                                                  context:
                                                                      context,
                                                                  type: SKAlertType
                                                                      .buttons,
                                                                  title:
                                                                      'Presensi Masuk &\nBuka Kelas ?',
                                                                  message:
                                                                      'Apakah anda yakin ingin\npresensi masuk dan buka\nkelas ini ?',
                                                                  okBtnText:
                                                                      'Ya',
                                                                  okBtnTxtColor:
                                                                      Colors
                                                                          .white,
                                                                  okBtnColor:
                                                                      Colors
                                                                          .green,
                                                                  cancelBtnText:
                                                                      'Tidak',
                                                                  cancelBtnTxtColor:
                                                                      Colors
                                                                          .white,
                                                                  cancelBtnColor:
                                                                      Colors
                                                                          .grey,
                                                                  onOkBtnTap:
                                                                      (value) async {
                                                                    print(
                                                                        idkelas);

                                                                    print(
                                                                        bukapresensi);

                                                                    print(
                                                                        pertemuan);

                                                                    // print(jam +
                                                                    //     ' ' +
                                                                    //     tanggalnow);

                                                                    setState(
                                                                        () {
                                                                      isApiCallProcess =
                                                                          true;
                                                                      presensiINOUTDosenBukaPresensiRequestModel
                                                                              .idkelas =
                                                                          idkelas;

                                                                      presensiINOUTDosenBukaPresensiRequestModel
                                                                              .pertemuan =
                                                                          pertemuan;

                                                                      // presensiINOUTDosenBukaPresensiRequestModel
                                                                      //         .jammasuk =
                                                                      //     jam +
                                                                      //         ' ' +
                                                                      //         tanggalnow;

                                                                      presensiINDosenBukaPresensiRequestModel
                                                                              .idkelas =
                                                                          idkelas;

                                                                      presensiINDosenBukaPresensiRequestModel
                                                                          .bukapresensi = 1;

                                                                      presensiINDosenBukaPresensiRequestModel
                                                                              .pertemuan =
                                                                          pertemuan;
                                                                    });

                                                                    print(presensiINOUTDosenBukaPresensiRequestModel
                                                                        .toJson());

                                                                    print(presensiINDosenBukaPresensiRequestModel
                                                                        .toJson());

                                                                    Future.delayed(
                                                                        Duration(
                                                                            seconds:
                                                                                10),
                                                                        () async {
                                                                      setState(
                                                                          () {
                                                                        isApiCallProcess =
                                                                            false;
                                                                      });

                                                                      Fluttertoast.showToast(
                                                                          msg:
                                                                              'Silahkan coba kembali',
                                                                          toastLength: Toast
                                                                              .LENGTH_SHORT,
                                                                          gravity: ToastGravity
                                                                              .BOTTOM,
                                                                          timeInSecForIosWeb:
                                                                              1,
                                                                          backgroundColor: Colors
                                                                              .red,
                                                                          textColor: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              14.0);
                                                                    });

                                                                    APIService
                                                                        apiService =
                                                                        new APIService();

                                                                    await apiService
                                                                        .putPresensiINDosen(
                                                                            presensiINOUTDosenBukaPresensiRequestModel)
                                                                        .then(
                                                                            (value) async {
                                                                      if (value !=
                                                                          null) {
                                                                        setState(
                                                                            () {
                                                                          isApiCallProcess =
                                                                              false;
                                                                        });
                                                                      }
                                                                    });

                                                                    await apiService
                                                                        .putBukaPresensiDosen(
                                                                            presensiINDosenBukaPresensiRequestModel)
                                                                        .then(
                                                                            (value) async {
                                                                      if (value !=
                                                                          null) {
                                                                        setState(
                                                                            () {
                                                                          isApiCallProcess =
                                                                              false;
                                                                        });
                                                                      }

                                                                      Get.offAllNamed(
                                                                          '/dosen/dashboard');

                                                                      await Fluttertoast.showToast(
                                                                          msg:
                                                                              'Berhasil presensi masuk dan membuka kelas',
                                                                          toastLength: Toast
                                                                              .LENGTH_SHORT,
                                                                          gravity: ToastGravity
                                                                              .BOTTOM,
                                                                          timeInSecForIosWeb:
                                                                              1,
                                                                          backgroundColor: Colors
                                                                              .green,
                                                                          textColor: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              14.0);
                                                                    });
                                                                  },
                                                                  onCancelBtnTap:
                                                                      (value) {},
                                                                );
                                                              },
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  Icon(
                                                                    Icons
                                                                        .arrow_upward_rounded,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Text(
                                                                    'Presensi Masuk',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'OpenSans',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        : SizedBox(
                                                            height: 0,
                                                          ),
                                                    bukapresensi == 0
                                                        ? SizedBox(
                                                            height: 0,
                                                          )
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                MaterialButton(
                                                              color: Colors
                                                                  .blue[300],
                                                              shape:
                                                                  StadiumBorder(),
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 50,
                                                                      right: 50,
                                                                      top: 25,
                                                                      bottom:
                                                                          25),
                                                              onPressed: () {
                                                                SKAlertDialog
                                                                    .show(
                                                                  context:
                                                                      context,
                                                                  type: SKAlertType
                                                                      .buttons,
                                                                  title:
                                                                      'Presensi Keluar &\nTutup Kelas ?',
                                                                  message:
                                                                      'Apakah anda yakin ingin\npresensi keluar dan\nmenutup kelas ?',
                                                                  okBtnText:
                                                                      'Ya',
                                                                  okBtnTxtColor:
                                                                      Colors
                                                                          .white,
                                                                  okBtnColor:
                                                                      Colors
                                                                          .red,
                                                                  cancelBtnText:
                                                                      'Tidak',
                                                                  cancelBtnTxtColor:
                                                                      Colors
                                                                          .white,
                                                                  cancelBtnColor:
                                                                      Colors
                                                                          .grey,
                                                                  onOkBtnTap:
                                                                      (value) async {
                                                                    FocusScope.of(
                                                                            context)
                                                                        .unfocus();
                                                                    // SharedPreferences
                                                                    //     dataPresensiMahasiswa =
                                                                    //     await SharedPreferences
                                                                    //         .getInstance();

                                                                    // await dataPresensiMahasiswa
                                                                    //     .setInt(
                                                                    //         'statuspresensi',
                                                                    //         0);

                                                                    print(
                                                                        idkelas);

                                                                    print(
                                                                        pertemuan);

                                                                    print(
                                                                        bukapresensi);

                                                                    if (validateAndSave()) {
                                                                      setState(
                                                                          () {
                                                                        isApiCallProcess =
                                                                            true;

                                                                        presensiINOUTOUTDosenBukaPresensiRequestModel.idkelas =
                                                                            idkelas;

                                                                        presensiINOUTOUTDosenBukaPresensiRequestModel.pertemuan =
                                                                            pertemuan;

                                                                        presensiOUTMahasiswaRequestModel.idkelas =
                                                                            idkelas;

                                                                        presensiOUTMahasiswaRequestModel.pertemuan =
                                                                            pertemuan;

                                                                        presensiOUTMahasiswaTidakHadirRequestModel.idkelas =
                                                                            idkelas;

                                                                        presensiOUTMahasiswaTidakHadirRequestModel.pertemuan =
                                                                            pertemuan;

                                                                        presensiINOUTOUTDosenBukaPresensiRequestModel.idkelas =
                                                                            idkelas;

                                                                        presensiINOUTOUTDosenBukaPresensiRequestModel.pertemuan =
                                                                            pertemuan;

                                                                        // presensiINOUTOUTDosenBukaPresensiRequestModel.jamkeluar = jam +
                                                                        //     ' ' +
                                                                        //     tanggalnow;

                                                                        presensiINDosenBukaPresensiRequestModel.idkelas =
                                                                            idkelas;

                                                                        presensiINDosenBukaPresensiRequestModel
                                                                            .bukapresensi = 3;

                                                                        presensiINDosenBukaPresensiRequestModel.pertemuan =
                                                                            pertemuan;

                                                                        print(
                                                                            idkelasFakultas);

                                                                        if (fakultas ==
                                                                            'Bisnis dan Ekonomika') {
                                                                          presensiOUTMahasiswaFBERequestModel.idkelas =
                                                                              idkelasFakultas;

                                                                          presensiOUTMahasiswaFBERequestModel.pertemuan =
                                                                              pertemuan;

                                                                          presensiOUTMahasiswaTidakHadirFBERequestModel.idkelas =
                                                                              idkelas;

                                                                          presensiOUTMahasiswaTidakHadirFBERequestModel.idkelasfakultas =
                                                                              idkelasFakultas;

                                                                          presensiOUTMahasiswaTidakHadirFBERequestModel.pertemuan =
                                                                              pertemuan;
                                                                        } else if (fakultas ==
                                                                            'Hukum') {
                                                                          presensiOUTMahasiswaFHRequestModel.idkelas =
                                                                              idkelasFakultas;

                                                                          presensiOUTMahasiswaFHRequestModel.pertemuan =
                                                                              pertemuan;

                                                                          presensiOUTMahasiswaTidakHadirFHRequestModel.idkelas =
                                                                              idkelas;

                                                                          presensiOUTMahasiswaTidakHadirFHRequestModel.idkelasfakultas =
                                                                              idkelasFakultas;

                                                                          presensiOUTMahasiswaTidakHadirFHRequestModel.pertemuan =
                                                                              pertemuan;
                                                                        } else if (fakultas ==
                                                                            'Teknobiologi') {
                                                                          presensiOUTMahasiswaFTBRequestModel.idkelas =
                                                                              idkelasFakultas;

                                                                          presensiOUTMahasiswaFTBRequestModel.pertemuan =
                                                                              pertemuan;

                                                                          presensiOUTMahasiswaTidakHadirFTBRequestModel.idkelas =
                                                                              idkelas;

                                                                          presensiOUTMahasiswaTidakHadirFTBRequestModel.idkelasfakultas =
                                                                              idkelasFakultas;

                                                                          presensiOUTMahasiswaTidakHadirFTBRequestModel.pertemuan =
                                                                              pertemuan;
                                                                        } else if (fakultas ==
                                                                            'Ilmu Sosial dan Politik') {
                                                                          presensiOUTMahasiswaFISIPRequestModel.idkelas =
                                                                              idkelasFakultas;

                                                                          presensiOUTMahasiswaFISIPRequestModel.pertemuan =
                                                                              pertemuan;

                                                                          presensiOUTMahasiswaTidakHadirFISIPRequestModel.idkelas =
                                                                              idkelas;

                                                                          presensiOUTMahasiswaTidakHadirFISIPRequestModel.idkelasfakultas =
                                                                              idkelasFakultas;

                                                                          presensiOUTMahasiswaTidakHadirFISIPRequestModel.pertemuan =
                                                                              pertemuan;
                                                                        } else if (fakultas ==
                                                                            'Teknik') {
                                                                          presensiOUTMahasiswaFTRequestModel.idkelas =
                                                                              idkelasFakultas;

                                                                          presensiOUTMahasiswaFTRequestModel.pertemuan =
                                                                              pertemuan;

                                                                          presensiOUTMahasiswaTidakHadirFTRequestModel.idkelas =
                                                                              idkelas;

                                                                          presensiOUTMahasiswaTidakHadirFTRequestModel.idkelasfakultas =
                                                                              idkelasFakultas;

                                                                          presensiOUTMahasiswaTidakHadirFTRequestModel.pertemuan =
                                                                              pertemuan;
                                                                        } else if (fakultas ==
                                                                            'Teknologi Industri') {
                                                                          presensiOUTMahasiswaFTIRequestModel.idkelas =
                                                                              idkelasFakultas;

                                                                          presensiOUTMahasiswaFTIRequestModel.pertemuan =
                                                                              pertemuan;

                                                                          presensiOUTMahasiswaTidakHadirFTIRequestModel.idkelas =
                                                                              idkelas;

                                                                          presensiOUTMahasiswaTidakHadirFTIRequestModel.idkelasfakultas =
                                                                              idkelasFakultas;

                                                                          presensiOUTMahasiswaTidakHadirFTIRequestModel.pertemuan =
                                                                              pertemuan;
                                                                        }
                                                                      });

                                                                      print(presensiINOUTOUTDosenBukaPresensiRequestModel
                                                                          .toJson());

                                                                      print(presensiINDosenBukaPresensiRequestModel
                                                                          .toJson());

                                                                      // print(PresensiOUTMahasiswaRequestModel()
                                                                      //     .toJson());

                                                                      // print(PresensiOUTMahasiswaTidakHadirRequestModel()
                                                                      //     .toJson());

                                                                      if (fakultas ==
                                                                          'Bisnis dan Ekonomika') {
                                                                        print(PresensiOUTMahasiswaFBERequestModel()
                                                                            .toJson());

                                                                        print(PresensiOUTMahasiswaTidakHadirFBERequestModel()
                                                                            .toJson());
                                                                      } else if (fakultas ==
                                                                          'Hukum') {
                                                                        print(PresensiOUTMahasiswaFHRequestModel()
                                                                            .toJson());

                                                                        print(PresensiOUTMahasiswaTidakHadirFHRequestModel()
                                                                            .toJson());
                                                                      } else if (fakultas ==
                                                                          'Teknobiologi') {
                                                                        print(PresensiOUTMahasiswaFTBRequestModel()
                                                                            .toJson());

                                                                        print(PresensiOUTMahasiswaTidakHadirFTBRequestModel()
                                                                            .toJson());
                                                                      } else if (fakultas ==
                                                                          'Ilmu Sosial dan Politik') {
                                                                        print(PresensiOUTMahasiswaFISIPRequestModel()
                                                                            .toJson());

                                                                        print(PresensiOUTMahasiswaTidakHadirFISIPRequestModel()
                                                                            .toJson());
                                                                      } else if (fakultas ==
                                                                          'Teknik') {
                                                                        print(PresensiOUTMahasiswaFTRequestModel()
                                                                            .toJson());

                                                                        print(PresensiOUTMahasiswaTidakHadirFTRequestModel()
                                                                            .toJson());
                                                                      } else if (fakultas ==
                                                                          'Teknologi Industri') {
                                                                        print(PresensiOUTMahasiswaFTIRequestModel()
                                                                            .toJson());

                                                                        print(PresensiOUTMahasiswaTidakHadirFTIRequestModel()
                                                                            .toJson());
                                                                      }

                                                                      Future.delayed(
                                                                          Duration(
                                                                              seconds: 20),
                                                                          () async {
                                                                        setState(
                                                                            () {
                                                                          isApiCallProcess =
                                                                              false;
                                                                        });

                                                                        Fluttertoast.showToast(
                                                                            msg:
                                                                                'Silahkan coba kembali',
                                                                            toastLength: Toast
                                                                                .LENGTH_SHORT,
                                                                            gravity: ToastGravity
                                                                                .BOTTOM,
                                                                            timeInSecForIosWeb:
                                                                                1,
                                                                            backgroundColor:
                                                                                Colors.red,
                                                                            textColor: Colors.white,
                                                                            fontSize: 14.0);
                                                                      });

                                                                      APIService
                                                                          apiService =
                                                                          new APIService();

                                                                      if (fakultas ==
                                                                          'Bisnis dan Ekonomika') {
                                                                        await apiService
                                                                            .putOutMahasiswaToFBE(presensiOUTMahasiswaFBERequestModel);

                                                                        await apiService
                                                                            .postInsertPresensiMhsTidakHadirToFBE(presensiOUTMahasiswaTidakHadirFBERequestModel);
                                                                      } else if (fakultas ==
                                                                          'Hukum') {
                                                                        await apiService
                                                                            .putOutMahasiswaToFH(presensiOUTMahasiswaFHRequestModel);

                                                                        await apiService
                                                                            .postInsertPresensiMhsTidakHadirToFH(presensiOUTMahasiswaTidakHadirFHRequestModel);
                                                                      } else if (fakultas ==
                                                                          'Teknobiologi') {
                                                                        await apiService
                                                                            .putOutMahasiswaToFTB(presensiOUTMahasiswaFTBRequestModel);

                                                                        await apiService
                                                                            .postInsertPresensiMhsTidakHadirToFTB(presensiOUTMahasiswaTidakHadirFTBRequestModel);
                                                                      } else if (fakultas ==
                                                                          'Ilmu Sosial dan Politik') {
                                                                        await apiService
                                                                            .putOutMahasiswaToFISIP(presensiOUTMahasiswaFISIPRequestModel);

                                                                        await apiService
                                                                            .postInsertPresensiMhsTidakHadirToFISIP(presensiOUTMahasiswaTidakHadirFISIPRequestModel);
                                                                      } else if (fakultas ==
                                                                          'Teknik') {
                                                                        await apiService
                                                                            .putOutMahasiswaToFT(presensiOUTMahasiswaFTRequestModel);

                                                                        await apiService
                                                                            .postInsertPresensiMhsTidakHadirToFT(presensiOUTMahasiswaTidakHadirFTRequestModel);
                                                                      } else if (fakultas ==
                                                                          'Teknologi Industri') {
                                                                        await apiService
                                                                            .putOutMahasiswaToFTI(presensiOUTMahasiswaFTIRequestModel);

                                                                        await apiService
                                                                            .postInsertPresensiMhsTidakHadirToFTI(presensiOUTMahasiswaTidakHadirFTIRequestModel);
                                                                      }

                                                                      await apiService
                                                                          .postInsertPresensiMhsTidakHadir(
                                                                              presensiOUTMahasiswaTidakHadirRequestModel);

                                                                      await apiService
                                                                          .putOutMahasiswa(
                                                                              presensiOUTMahasiswaRequestModel)
                                                                          .then(
                                                                              (value) async {
                                                                        if (value !=
                                                                            null) {
                                                                          setState(
                                                                              () {
                                                                            isApiCallProcess =
                                                                                false;
                                                                          });
                                                                        }
                                                                      });

                                                                      await apiService
                                                                          .putPresensiOUTDosen(
                                                                              presensiINOUTOUTDosenBukaPresensiRequestModel)
                                                                          .then(
                                                                              (value) async {
                                                                        if (value !=
                                                                            null) {
                                                                          setState(
                                                                              () {
                                                                            isApiCallProcess =
                                                                                false;
                                                                          });
                                                                        }
                                                                      });

                                                                      await apiService
                                                                          .putBukaPresensiDosen(
                                                                              presensiINDosenBukaPresensiRequestModel)
                                                                          .then(
                                                                              (value) async {
                                                                        if (value !=
                                                                            null) {
                                                                          setState(
                                                                              () {
                                                                            isApiCallProcess =
                                                                                false;
                                                                          });
                                                                        }

                                                                        Get.offAllNamed(
                                                                            '/dosen/dashboard');

                                                                        await Fluttertoast.showToast(
                                                                            msg:
                                                                                'Berhasil presensi keluar dan mengakhiri kelas',
                                                                            toastLength: Toast
                                                                                .LENGTH_SHORT,
                                                                            gravity: ToastGravity
                                                                                .BOTTOM,
                                                                            timeInSecForIosWeb:
                                                                                1,
                                                                            backgroundColor:
                                                                                Colors.green,
                                                                            textColor: Colors.white,
                                                                            fontSize: 14.0);
                                                                      });
                                                                    }
                                                                  },
                                                                  onCancelBtnTap:
                                                                      (value) {},
                                                                );
                                                              },
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  Icon(
                                                                    Icons
                                                                        .arrow_downward_rounded,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Text(
                                                                    'Presensi Keluar',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'OpenSans',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                  ]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: MaterialButton(
                                              color: Colors.blue[200],
                                              shape: StadiumBorder(),
                                              padding: EdgeInsets.only(
                                                  left: 50,
                                                  right: 50,
                                                  top: 25,
                                                  bottom: 25),
                                              onPressed: () => {
                                                Get.offAllNamed(
                                                    '/dosen/dashboard')
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.arrow_back_rounded,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    'Kembali',
                                                    style: TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
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
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SpinKitDoubleBounce(
                                                      color: Colors.red,
                                                      size: 100,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Anda berada di luar jarak minimal kelas',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'OpenSans',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'Jarak Anda : ${beacon.accuracy} m',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'OpenSans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'Jarak Minimal : ${jarakmin.toStringAsFixed(2)} m',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'OpenSans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 500,
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                })).toList()),
                      ),
                    ),
                  )));
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
