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
import 'package:presensiblebeacon/MODEL/Presensi/FBE/PresensiINMahasiswaToFBEModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FH/PresensiINMahasiswaToFHModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FISIP/PresensiINMahasiswaToFISIPModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FTB/PresensiINMahasiswaToFTBModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FTI/PresensiINMahasiswaToFTIModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FT/PresensiINMahasiswaToFTModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/KSI/Mahasiswa/PresensiINMahasiswaToKSIModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FBE/PresensiOUTMahasiswaToFBEModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FH/PresensiOUTMahasiswaToFHModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FISIP/PresensiOUTMahasiswaToFISIPModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FTB/PresensiOUTMahasiswaToFTBModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FTI/PresensiOUTMahasiswaToFTIModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/FT/PresensiOUTMahasiswaToFTModel.dart';
import 'package:presensiblebeacon/MODEL/Presensi/KSI/Mahasiswa/PresensiOUTMahasiswaToKSIModel.dart';
import 'package:presensiblebeacon/UTILS/ProgressHUD.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sk_alert_dialog/sk_alert_dialog.dart';

class PindaiKelasMahasiswaPage extends StatefulWidget {
  @override
  _PindaiKelasMahasiswaPageState createState() =>
      _PindaiKelasMahasiswaPageState();
}

class _PindaiKelasMahasiswaPageState extends State<PindaiKelasMahasiswaPage>
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

  String namamhs = "";
  String npm = "";
  String fakultas = "";

  int idkelas = 0;
  String ruang = "";
  String namamk = "";
  String dosen = "";
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
  String tglmasuk = "";
  String tglkeluar = "";
  int bukapresensi = 0;
  String tglin = "";
  String tglout = "";

  String idkelasString;
  String idkelasFakultas;

  // int statusPresensi = 0;

  bool isApiCallProcess = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  PresensiINMahasiswaToKSIRequestModel presensiINMahasiswaToKSIRequestModel;

  PresensiOUTMahasiswaToKSIRequestModel presensiOUTMahasiswaToKSIRequestModel;

  PresensiINMahasiswaToFBERequestModel presensiINMahasiswaToFBERequestModel;

  PresensiOUTMahasiswaToFBERequestModel presensiOUTMahasiswaToFBERequestModel;

  PresensiINMahasiswaToFHRequestModel presensiINMahasiswaToFHRequestModel;

  PresensiOUTMahasiswaToFHRequestModel presensiOUTMahasiswaToFHRequestModel;

  PresensiINMahasiswaToFISIPRequestModel presensiINMahasiswaToFISIPRequestModel;

  PresensiOUTMahasiswaToFISIPRequestModel
      presensiOUTMahasiswaToFISIPRequestModel;

  PresensiINMahasiswaToFTRequestModel presensiINMahasiswaToFTRequestModel;

  PresensiOUTMahasiswaToFTRequestModel presensiOUTMahasiswaToFTRequestModel;

  PresensiINMahasiswaToFTBRequestModel presensiINMahasiswaToFTBRequestModel;

  PresensiOUTMahasiswaToFTBRequestModel presensiOUTMahasiswaToFTBRequestModel;

  PresensiINMahasiswaToFTIRequestModel presensiINMahasiswaToFTIRequestModel;

  PresensiOUTMahasiswaToFTIRequestModel presensiOUTMahasiswaToFTIRequestModel;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    // getProximityUUID();

    listeningState();

    presensiINMahasiswaToKSIRequestModel =
        PresensiINMahasiswaToKSIRequestModel();

    presensiOUTMahasiswaToKSIRequestModel =
        PresensiOUTMahasiswaToKSIRequestModel();

    presensiINMahasiswaToFBERequestModel =
        PresensiINMahasiswaToFBERequestModel();

    presensiOUTMahasiswaToFBERequestModel =
        PresensiOUTMahasiswaToFBERequestModel();

    presensiINMahasiswaToFHRequestModel = PresensiINMahasiswaToFHRequestModel();

    presensiOUTMahasiswaToFHRequestModel =
        PresensiOUTMahasiswaToFHRequestModel();

    presensiINMahasiswaToFISIPRequestModel =
        PresensiINMahasiswaToFISIPRequestModel();

    presensiOUTMahasiswaToFISIPRequestModel =
        PresensiOUTMahasiswaToFISIPRequestModel();

    presensiINMahasiswaToFTRequestModel = PresensiINMahasiswaToFTRequestModel();

    presensiOUTMahasiswaToFTRequestModel =
        PresensiOUTMahasiswaToFTRequestModel();

    presensiINMahasiswaToFTBRequestModel =
        PresensiINMahasiswaToFTBRequestModel();

    presensiOUTMahasiswaToFTBRequestModel =
        PresensiOUTMahasiswaToFTBRequestModel();

    presensiINMahasiswaToFTIRequestModel =
        PresensiINMahasiswaToFTIRequestModel();

    presensiOUTMahasiswaToFTIRequestModel =
        PresensiOUTMahasiswaToFTIRequestModel();

    // Timer.periodic(Duration(seconds: 1), (Timer t) {
    //   getDetailKelas();
    //   // getDetailMahasiswa();

    //   Future.delayed(Duration(seconds: 5), () {
    //     t.cancel();
    //   });
    // });

    // Timer.periodic(Duration(seconds: 1), (Timer t) {
    //   // getDetailKelas();
    //   getDetailMahasiswa();

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

  getDetailMahasiswa() async {
    SharedPreferences loginMahasiswa = await SharedPreferences.getInstance();

    setState(() {
      namamhs = loginMahasiswa.getString('namamhs');
      npm = loginMahasiswa.getString('npm');
      fakultas = loginMahasiswa.getString('fakultas');
    });
  }

  getDetailKelas() async {
    SharedPreferences dataPresensiMahasiswa =
        await SharedPreferences.getInstance();

    setState(() {
      idkelas = dataPresensiMahasiswa.getInt('idkelas');
      ruang = dataPresensiMahasiswa.getString('ruang');
      namamk = dataPresensiMahasiswa.getString('namamk');
      dosen = dataPresensiMahasiswa.getString('namadosen1');
      kelas = dataPresensiMahasiswa.getString('kelas');
      sks = dataPresensiMahasiswa.getInt('sks');
      pertemuan = dataPresensiMahasiswa.getInt('pertemuan');
      hari = dataPresensiMahasiswa.getString('hari1');
      sesi = dataPresensiMahasiswa.getString('sesi1');
      kapasitas = dataPresensiMahasiswa.getInt('kapasitas');
      jam = dataPresensiMahasiswa.getString('jam');
      jammasuk = dataPresensiMahasiswa.getString('jammasuk');
      jamkeluar = dataPresensiMahasiswa.getString('jamkeluar');
      tanggalnow = dataPresensiMahasiswa.getString('tanggal');
      tglmasuk = dataPresensiMahasiswa.getString('tglmasuk');
      tglkeluar = dataPresensiMahasiswa.getString('tglkeluar');
      bukapresensi = dataPresensiMahasiswa.getInt('bukapresensi');
      // statusPresensi = dataPresensiMahasiswa.getInt('statuspresensi');
      tglin = dataPresensiMahasiswa.getString('tglin');
      tglout = dataPresensiMahasiswa.getString('tglout');
    });
  }

  getIDKelasFakultas() async {
    idkelasString = idkelas.toString();

    idkelasFakultas = idkelasString.substring(1);
  }

  getProximityUUID() async {
    SharedPreferences dataPresensiMahasiswa =
        await SharedPreferences.getInstance();

    setState(() {
      uuid = dataPresensiMahasiswa.getString('uuid');
      jarakmin = dataPresensiMahasiswa.getDouble('jarakmin') ?? 0.0;
      major = dataPresensiMahasiswa.getInt('major');
      minor = dataPresensiMahasiswa.getInt('minor');
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
      child: buildDetailPresensiMahasiswa(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0,
    );
  }

  Widget buildDetailPresensiMahasiswa(BuildContext context) {
    getDetailKelas();
    getProximityUUID();
    getDetailMahasiswa();
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
          //   'Detail Presensi',
          //   style: TextStyle(
          //       color: Colors.white,
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
                                  color: Colors.blue,
                                  shape: StadiumBorder(),
                                  padding: EdgeInsets.only(
                                      left: 50, right: 50, top: 25, bottom: 25),
                                  onPressed: () =>
                                      {Get.offAllNamed('/mahasiswa/dashboard')},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.arrow_back_rounded,
                                          color: Colors.white),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        'Kembali',
                                        style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
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
                                                  color: Colors.white),
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
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Silahkan menghubungi admin',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: 'OpenSans',
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
                                                  'Pastikan anda dekat dengan beacon ruangan',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'OpenSans',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue[500]),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                      '/mahasiswa/dashboard')
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(
                                                        Icons
                                                            .arrow_back_rounded,
                                                        color: Colors.black),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text(
                                                      'Kembali',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'OpenSans',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // Container(
                                            //   decoration: BoxDecoration(
                                            //       color: Colors.grey[200],
                                            //       borderRadius:
                                            //           BorderRadius.circular(
                                            //               25)),
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
                                            //                                 .all(
                                            //                             8.0),
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
                                            //                         fontSize:
                                            //                             20,
                                            //                         color: Colors
                                            //                             .white),
                                            //                   ),
                                            //                 ],
                                            //               ),
                                            //             ),
                                            //           ),
                                            //           Padding(
                                            //             padding:
                                            //                 const EdgeInsets
                                            //                     .all(8.0),
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
                                            //           Padding(
                                            //             padding:
                                            //                 const EdgeInsets
                                            //                     .all(8.0),
                                            //             child: Scrollbar(
                                            //               child:
                                            //                   SingleChildScrollView(
                                            //                 scrollDirection:
                                            //                     Axis.horizontal,
                                            //                 child: Row(
                                            //                   children: <
                                            //                       Widget>[
                                            //                     Padding(
                                            //                       padding:
                                            //                           const EdgeInsets
                                            //                                   .all(
                                            //                               8.0),
                                            //                       child: Icon(Icons
                                            //                           .person),
                                            //                     ),
                                            //                     new Text(
                                            //                       '${dosen ?? "-"}',
                                            //                       style: TextStyle(
                                            //                           fontFamily: 'OpenSans',
                                            //                           // fontWeight:
                                            //                           //     FontWeight.bold,
                                            //                           fontSize: 16,
                                            //                           fontWeight: FontWeight.bold),
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
                                            //                       FontWeight
                                            //                           .bold,
                                            //                   fontSize: 14),
                                            //             ),
                                            //             children: [
                                            //               Row(
                                            //                 mainAxisAlignment:
                                            //                     MainAxisAlignment
                                            //                         .spaceAround,
                                            //                 children: [
                                            //                   Padding(
                                            //                     padding:
                                            //                         const EdgeInsets
                                            //                                 .all(
                                            //                             8.0),
                                            //                     child: Column(
                                            //                       children: [
                                            //                         Padding(
                                            //                           padding:
                                            //                               const EdgeInsets.all(
                                            //                                   8.0),
                                            //                           child: Icon(
                                            //                               Icons
                                            //                                   .meeting_room_rounded),
                                            //                         ),
                                            //                         new Container(
                                            //                           child:
                                            //                               new Text(
                                            //                             'Pertemuan ${pertemuan ?? "-"}',
                                            //                             style: TextStyle(
                                            //                                 fontFamily:
                                            //                                     'OpenSans',
                                            //                                 fontWeight:
                                            //                                     FontWeight.bold,
                                            //                                 fontSize: 18),
                                            //                           ),
                                            //                         ),
                                            //                       ],
                                            //                     ),
                                            //                   ),
                                            //                   Row(
                                            //                     children: [
                                            //                       Padding(
                                            //                         padding:
                                            //                             const EdgeInsets.all(
                                            //                                 8.0),
                                            //                         child:
                                            //                             new Center(
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
                                            //                     ],
                                            //                   ),
                                            //                 ],
                                            //               ),
                                            //               Padding(
                                            //                 padding:
                                            //                     const EdgeInsets
                                            //                         .all(8.0),
                                            //                 child: Divider(
                                            //                   height: 1,
                                            //                   thickness: 2,
                                            //                   color:
                                            //                       Colors.black,
                                            //                 ),
                                            //               ),
                                            //               Padding(
                                            //                 padding:
                                            //                     const EdgeInsets
                                            //                         .all(8.0),
                                            //                 child: Column(
                                            //                   children: [
                                            //                     Column(
                                            //                       children: [
                                            //                         Padding(
                                            //                           padding:
                                            //                               const EdgeInsets.all(
                                            //                                   8.0),
                                            //                           child: Icon(
                                            //                               Icons
                                            //                                   .door_sliding_rounded),
                                            //                         ),
                                            //                         Column(
                                            //                           children: [
                                            //                             new Text(
                                            //                               'Ruangan',
                                            //                               style: TextStyle(
                                            //                                   fontFamily: 'OpenSans',
                                            //                                   fontWeight: FontWeight.bold,
                                            //                                   fontSize: 20),
                                            //                             ),
                                            //                           ],
                                            //                         ),
                                            //                       ],
                                            //                     ),
                                            //                     Padding(
                                            //                       padding:
                                            //                           const EdgeInsets
                                            //                                   .all(
                                            //                               8.0),
                                            //                       child:
                                            //                           new Center(
                                            //                         child:
                                            //                             new Text(
                                            //                           '${ruang ?? "-"}',
                                            //                           style: TextStyle(
                                            //                               fontFamily: 'OpenSans',
                                            //                               // fontWeight:
                                            //                               //     FontWeight.bold,
                                            //                               fontSize: 16),
                                            //                         ),
                                            //                       ),
                                            //                     ),
                                            //                   ],
                                            //                 ),
                                            //               ),
                                            //               Padding(
                                            //                 padding:
                                            //                     const EdgeInsets
                                            //                         .all(8.0),
                                            //                 child: Divider(
                                            //                   height: 1,
                                            //                   thickness: 2,
                                            //                   color:
                                            //                       Colors.black,
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
                                            //                               .spaceAround,
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
                                            //           tglin == '-'
                                            //               ? Padding(
                                            //                   padding:
                                            //                       const EdgeInsets
                                            //                           .all(8.0),
                                            //                   child: Column(
                                            //                     children: [
                                            //                       Container(
                                            //                         decoration: BoxDecoration(
                                            //                             color: Colors
                                            //                                 .green,
                                            //                             borderRadius:
                                            //                                 BorderRadius.circular(25)),
                                            //                         child:
                                            //                             Padding(
                                            //                           padding:
                                            //                               const EdgeInsets.all(
                                            //                                   8.0),
                                            //                           child:
                                            //                               Row(
                                            //                             mainAxisAlignment:
                                            //                                 MainAxisAlignment.center,
                                            //                             children: [
                                            //                               Padding(
                                            //                                 padding:
                                            //                                     const EdgeInsets.all(8.0),
                                            //                                 child:
                                            //                                     Icon(
                                            //                                   Icons.person,
                                            //                                   color: Colors.white,
                                            //                                 ),
                                            //                               ),
                                            //                               new Text(
                                            //                                 'Data Presensi Masuk',
                                            //                                 style: TextStyle(
                                            //                                     fontFamily: 'OpenSans',
                                            //                                     fontWeight: FontWeight.bold,
                                            //                                     fontSize: 20,
                                            //                                     color: Colors.white),
                                            //                               ),
                                            //                             ],
                                            //                           ),
                                            //                         ),
                                            //                       ),
                                            //                     ],
                                            //                   ),
                                            //                 )
                                            //               : Padding(
                                            //                   padding:
                                            //                       const EdgeInsets
                                            //                           .all(8.0),
                                            //                   child: Column(
                                            //                     children: [
                                            //                       Container(
                                            //                         decoration: BoxDecoration(
                                            //                             color: Colors
                                            //                                 .red,
                                            //                             borderRadius:
                                            //                                 BorderRadius.circular(25)),
                                            //                         child:
                                            //                             Padding(
                                            //                           padding:
                                            //                               const EdgeInsets.all(
                                            //                                   8.0),
                                            //                           child:
                                            //                               Row(
                                            //                             mainAxisAlignment:
                                            //                                 MainAxisAlignment.center,
                                            //                             children: [
                                            //                               Padding(
                                            //                                 padding:
                                            //                                     const EdgeInsets.all(8.0),
                                            //                                 child:
                                            //                                     Icon(
                                            //                                   Icons.person,
                                            //                                   color: Colors.white,
                                            //                                 ),
                                            //                               ),
                                            //                               new Text(
                                            //                                 'Data Presensi Keluar',
                                            //                                 style: TextStyle(
                                            //                                     fontFamily: 'OpenSans',
                                            //                                     fontWeight: FontWeight.bold,
                                            //                                     fontSize: 20,
                                            //                                     color: Colors.white),
                                            //                               ),
                                            //                             ],
                                            //                           ),
                                            //                         ),
                                            //                       ),
                                            //                       // Padding(
                                            //                       //   padding:
                                            //                       //       const EdgeInsets.all(
                                            //                       //           8.0),
                                            //                       //   child:
                                            //                       //       new Center(
                                            //                       //     child:
                                            //                       //         new Text(
                                            //                       //       'Tanggal Keluar',
                                            //                       //       style: TextStyle(
                                            //                       //           fontFamily:
                                            //                       //               'OpenSans',
                                            //                       //           fontWeight:
                                            //                       //               FontWeight.bold,
                                            //                       //           fontSize: 20),
                                            //                       //     ),
                                            //                       //   ),
                                            //                       // ),
                                            //                     ],
                                            //                   ),
                                            //                 ),
                                            //           Padding(
                                            //             padding:
                                            //                 const EdgeInsets
                                            //                     .all(8.0),
                                            //             child: new Center(
                                            //               child: new Text(
                                            //                 'Nama Mahasiswa',
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
                                            //             padding:
                                            //                 const EdgeInsets
                                            //                         .symmetric(
                                            //                     horizontal:
                                            //                         8.0),
                                            //             child: Scrollbar(
                                            //               child:
                                            //                   SingleChildScrollView(
                                            //                 scrollDirection:
                                            //                     Axis.horizontal,
                                            //                 child: Padding(
                                            //                   padding:
                                            //                       const EdgeInsets
                                            //                           .all(8.0),
                                            //                   child: new Center(
                                            //                     child: new Text(
                                            //                       '${namamhs ?? "-"}',
                                            //                       style: TextStyle(
                                            //                           fontFamily: 'OpenSans',
                                            //                           // fontWeight:
                                            //                           //     FontWeight.bold,
                                            //                           fontSize: 16),
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
                                            //                       FontWeight
                                            //                           .bold,
                                            //                   fontSize: 14),
                                            //             ),
                                            //             children: [
                                            //               Padding(
                                            //                 padding:
                                            //                     const EdgeInsets
                                            //                         .all(8.0),
                                            //                 child: new Center(
                                            //                   child: new Text(
                                            //                     'NPM',
                                            //                     style: TextStyle(
                                            //                         fontFamily:
                                            //                             'OpenSans',
                                            //                         fontWeight:
                                            //                             FontWeight
                                            //                                 .bold,
                                            //                         fontSize:
                                            //                             20),
                                            //                   ),
                                            //                 ),
                                            //               ),
                                            //               Padding(
                                            //                 padding:
                                            //                     const EdgeInsets
                                            //                         .all(8.0),
                                            //                 child: new Center(
                                            //                   child: new Text(
                                            //                     '${npm ?? "-"}',
                                            //                     style: TextStyle(
                                            //                         fontFamily: 'OpenSans',
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
                                            //                   color:
                                            //                       Colors.black,
                                            //                 ),
                                            //               ),
                                            //               tglin == '-'
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
                                            //                               fontWeight: FontWeight
                                            //                                   .bold,
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
                                            //                               fontWeight: FontWeight
                                            //                                   .bold,
                                            //                               fontSize:
                                            //                                   20),
                                            //                         ),
                                            //                       ),
                                            //                     ),
                                            //               Padding(
                                            //                 padding:
                                            //                     const EdgeInsets
                                            //                         .all(8.0),
                                            //                 child: new Center(
                                            //                   child: new Text(
                                            //                     '${jam ?? "-"}',
                                            //                     style: TextStyle(
                                            //                         fontFamily: 'OpenSans',
                                            //                         // fontWeight:
                                            //                         //     FontWeight.bold,
                                            //                         fontSize: 16),
                                            //                   ),
                                            //                 ),
                                            //               )
                                            //             ],
                                            //           ),
                                            //         ],
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),

                                            new Align(
                                              child: new Padding(
                                                padding: EdgeInsets.all(10),
                                                child: new Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      // Padding(
                                                      //   padding:
                                                      //       const EdgeInsets
                                                      //           .all(8.0),
                                                      //   child: MaterialButton(
                                                      //     color: Colors
                                                      //         .yellow[700],
                                                      //     shape:
                                                      //         StadiumBorder(),
                                                      //     padding:
                                                      //         EdgeInsets.only(
                                                      //             left: 50,
                                                      //             right: 50,
                                                      //             top: 25,
                                                      //             bottom: 25),
                                                      //     onPressed: () => {
                                                      //       Get.toNamed(
                                                      //           '/mahasiswa/dashboard/presensi/detail/tampilpeserta')
                                                      //     },
                                                      //     child: Scrollbar(
                                                      //       child: Container(
                                                      //         child:
                                                      //             SingleChildScrollView(
                                                      //           scrollDirection:
                                                      //               Axis.horizontal,
                                                      //           child: Row(
                                                      //             mainAxisAlignment:
                                                      //                 MainAxisAlignment
                                                      //                     .center,
                                                      //             children: <
                                                      //                 Widget>[
                                                      //               Icon(
                                                      //                 Icons
                                                      //                     .people_alt_rounded,
                                                      //                 color: Colors
                                                      //                     .white,
                                                      //               ),
                                                      //               SizedBox(
                                                      //                 width: 20,
                                                      //               ),
                                                      //               Text(
                                                      //                 'Tampil Peserta Kelas',
                                                      //                 style: TextStyle(
                                                      //                     fontFamily:
                                                      //                         'OpenSans',
                                                      //                     fontWeight: FontWeight
                                                      //                         .bold,
                                                      //                     color: Colors
                                                      //                         .white,
                                                      //                     fontSize:
                                                      //                         18),
                                                      //               ),
                                                      //             ],
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                          .grey[
                                                                      500],
                                                                  offset:
                                                                      Offset(
                                                                          0.0,
                                                                          0.0),
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
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                child: Initicon(
                                                                  text:
                                                                      namamhs ??
                                                                          '-',
                                                                  backgroundColor:
                                                                      Colors.grey[
                                                                          300],
                                                                  size: 80,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              8.0),
                                                                      child:
                                                                          Scrollbar(
                                                                        child:
                                                                            SingleChildScrollView(
                                                                          scrollDirection:
                                                                              Axis.horizontal,
                                                                          child: Text(
                                                                              namamhs ?? '-',
                                                                              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'OpenSans', fontSize: 18)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(
                                                                  npm ?? '-',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'OpenSans',
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors
                                                                            .grey[
                                                                        500],
                                                                    offset: Offset(
                                                                        0.0,
                                                                        0.0),
                                                                    blurRadius:
                                                                        0.75,
                                                                    spreadRadius:
                                                                        0.25)
                                                              ],
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25)),
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    Scrollbar(
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child: Text(
                                                                      '${namamk ?? '-'} ${kelas ?? '-'}',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'OpenSans',
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      'Pertemuan ${pertemuan ?? '-'}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'OpenSans',
                                                                        fontSize:
                                                                            16,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      tglin == '-'
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
                                                                        left:
                                                                            50,
                                                                        right:
                                                                            50,
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
                                                                        'Presensi Masuk ?',
                                                                    message:
                                                                        'Apakah anda yakin ingin\npresensi masuk di kelas ini ?',
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
                                                                      // SharedPreferences
                                                                      //     dataPresensiMahasiswa =
                                                                      //     await SharedPreferences
                                                                      //         .getInstance();

                                                                      // await dataPresensiMahasiswa
                                                                      //     .setInt(
                                                                      //         'statuspresensi',
                                                                      //         1);

                                                                      setState(
                                                                          () {
                                                                        isApiCallProcess =
                                                                            true;

                                                                        presensiINMahasiswaToKSIRequestModel.idkelas =
                                                                            idkelas;

                                                                        presensiINMahasiswaToKSIRequestModel.npm =
                                                                            npm;

                                                                        presensiINMahasiswaToKSIRequestModel.pertemuan =
                                                                            pertemuan;

                                                                        // presensiINMahasiswaToKSIRequestModel.tglin = jam +
                                                                        //     ' ' +
                                                                        //     tanggalnow;

                                                                        if (fakultas ==
                                                                            'Bisnis dan Ekonomika') {
                                                                          presensiINMahasiswaToFBERequestModel.idkelas =
                                                                              idkelasFakultas;

                                                                          presensiINMahasiswaToFBERequestModel.npm =
                                                                              npm;

                                                                          presensiINMahasiswaToFBERequestModel.pertemuan =
                                                                              pertemuan;

                                                                          // presensiINMahasiswaToFBERequestModel.tglin = jam +
                                                                          //     ' ' +
                                                                          //     tanggalnow;
                                                                        } else if (fakultas ==
                                                                            'Hukum') {
                                                                          presensiINMahasiswaToFHRequestModel.idkelas =
                                                                              idkelasFakultas;

                                                                          presensiINMahasiswaToFHRequestModel.npm =
                                                                              npm;

                                                                          presensiINMahasiswaToFHRequestModel.pertemuan =
                                                                              pertemuan;

                                                                          // presensiINMahasiswaToFHRequestModel.tglin = jam +
                                                                          //     ' ' +
                                                                          //     tanggalnow;
                                                                        } else if (fakultas ==
                                                                            'Teknobiologi') {
                                                                          presensiINMahasiswaToFTBRequestModel.idkelas =
                                                                              idkelasFakultas;

                                                                          presensiINMahasiswaToFTBRequestModel.npm =
                                                                              npm;

                                                                          presensiINMahasiswaToFTBRequestModel.pertemuan =
                                                                              pertemuan;

                                                                          // presensiINMahasiswaToFTBRequestModel.tglin = jam +
                                                                          //     ' ' +
                                                                          //     tanggalnow;
                                                                        } else if (fakultas ==
                                                                            'Ilmu Sosial dan Politik') {
                                                                          presensiINMahasiswaToFISIPRequestModel.idkelas =
                                                                              idkelasFakultas;

                                                                          presensiINMahasiswaToFISIPRequestModel.npm =
                                                                              npm;

                                                                          presensiINMahasiswaToFISIPRequestModel.pertemuan =
                                                                              pertemuan;

                                                                          // presensiINMahasiswaToFISIPRequestModel.tglin = jam +
                                                                          //     ' ' +
                                                                          //     tanggalnow;
                                                                        } else if (fakultas ==
                                                                            'Teknik') {
                                                                          presensiINMahasiswaToFTRequestModel.idkelas =
                                                                              idkelasFakultas;

                                                                          presensiINMahasiswaToFTRequestModel.npm =
                                                                              npm;

                                                                          presensiINMahasiswaToFTRequestModel.pertemuan =
                                                                              pertemuan;

                                                                          // presensiINMahasiswaToFTRequestModel.tglin = jam +
                                                                          //     ' ' +
                                                                          //     tanggalnow;
                                                                        } else if (fakultas ==
                                                                            'Teknologi Industri') {
                                                                          presensiINMahasiswaToFTIRequestModel.idkelas =
                                                                              idkelasFakultas;

                                                                          presensiINMahasiswaToFTIRequestModel.npm =
                                                                              npm;

                                                                          presensiINMahasiswaToFTIRequestModel.pertemuan =
                                                                              pertemuan;

                                                                          // presensiINMahasiswaToFTIRequestModel.tglin = jam +
                                                                          //     ' ' +
                                                                          //     tanggalnow;
                                                                        }
                                                                      });

                                                                      // setState(
                                                                      //     () {
                                                                      //   isApiCallProcess =
                                                                      //       false;
                                                                      // });

                                                                      print(PresensiINMahasiswaToKSIRequestModel()
                                                                          .toJson());

                                                                      if (fakultas ==
                                                                          'Bisnis dan Ekonomika') {
                                                                        print(PresensiINMahasiswaToFBERequestModel()
                                                                            .toJson());
                                                                      } else if (fakultas ==
                                                                          'Hukum') {
                                                                        print(PresensiINMahasiswaToFHRequestModel()
                                                                            .toJson());
                                                                      } else if (fakultas ==
                                                                          'Teknobiologi') {
                                                                        print(PresensiINMahasiswaToFTBRequestModel()
                                                                            .toJson());
                                                                      } else if (fakultas ==
                                                                          'Ilmu Sosial dan Politik') {
                                                                        print(PresensiINMahasiswaToFISIPRequestModel()
                                                                            .toJson());
                                                                      } else if (fakultas ==
                                                                          'Teknik') {
                                                                        print(PresensiINMahasiswaToFTRequestModel()
                                                                            .toJson());
                                                                      } else if (fakultas ==
                                                                          'Teknologi Industri') {
                                                                        print(PresensiINMahasiswaToFTIRequestModel()
                                                                            .toJson());
                                                                      }

                                                                      Future.delayed(
                                                                          Duration(
                                                                              seconds: 10),
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
                                                                            .postInsertPresensiMhsToFBE(presensiINMahasiswaToFBERequestModel);
                                                                      } else if (fakultas ==
                                                                          'Hukum') {
                                                                        await apiService
                                                                            .postInsertPresensiMhsToFH(presensiINMahasiswaToFHRequestModel);
                                                                      } else if (fakultas ==
                                                                          'Teknobiologi') {
                                                                        await apiService
                                                                            .postInsertPresensiMhsToFH(presensiINMahasiswaToFHRequestModel);
                                                                      } else if (fakultas ==
                                                                          'Ilmu Sosial dan Politik') {
                                                                        await apiService
                                                                            .postInsertPresensiMhsToFISIP(presensiINMahasiswaToFISIPRequestModel);
                                                                      } else if (fakultas ==
                                                                          'Teknik') {
                                                                        await apiService
                                                                            .postInsertPresensiMhsToFT(presensiINMahasiswaToFTRequestModel);
                                                                      } else if (fakultas ==
                                                                          'Teknologi Industri') {
                                                                        await apiService
                                                                            .postInsertPresensiMhsToFTI(presensiINMahasiswaToFTIRequestModel);
                                                                      }

                                                                      await apiService
                                                                          .postInsertPresensiMhsToKSI(
                                                                              presensiINMahasiswaToKSIRequestModel)
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
                                                                            '/mahasiswa/dashboard');

                                                                        await Fluttertoast.showToast(
                                                                            msg:
                                                                                'Berhasil presensi masuk',
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
                                                                          fontWeight: FontWeight
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
                                                          : MaterialButton(
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
                                                                      'Presensi Keluar ?',
                                                                  message:
                                                                      'Apakah anda yakin ingin\npresensi keluar dari kelas ini ?',
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
                                                                    // SharedPreferences
                                                                    //     dataPresensiMahasiswa =
                                                                    //     await SharedPreferences
                                                                    //         .getInstance();

                                                                    // await dataPresensiMahasiswa
                                                                    //     .setInt(
                                                                    //         'statuspresensi',
                                                                    //         0);

                                                                    // await dataPresensiMahasiswa
                                                                    //     .setInt(
                                                                    //         'statuspresensi',
                                                                    //         3);

                                                                    setState(
                                                                        () {
                                                                      isApiCallProcess =
                                                                          true;

                                                                      presensiOUTMahasiswaToKSIRequestModel
                                                                              .idkelas =
                                                                          idkelas;

                                                                      presensiOUTMahasiswaToKSIRequestModel
                                                                              .npm =
                                                                          npm;

                                                                      presensiOUTMahasiswaToKSIRequestModel
                                                                              .pertemuan =
                                                                          pertemuan;

                                                                      // presensiOUTMahasiswaToKSIRequestModel
                                                                      //         .tglout =
                                                                      //     jam +
                                                                      //         ' ' +
                                                                      //         tanggalnow;

                                                                      presensiOUTMahasiswaToKSIRequestModel
                                                                              .status =
                                                                          'H';
                                                                      if (fakultas ==
                                                                          'Bisnis dan Ekonomika') {
                                                                        presensiOUTMahasiswaToFBERequestModel.idkelas =
                                                                            idkelasFakultas;

                                                                        presensiOUTMahasiswaToFBERequestModel.npm =
                                                                            npm;

                                                                        presensiOUTMahasiswaToFBERequestModel.pertemuan =
                                                                            pertemuan;

                                                                        // presensiOUTMahasiswaToFBERequestModel.tglout = jam +
                                                                        //     ' ' +
                                                                        //     tanggalnow;

                                                                        presensiOUTMahasiswaToFBERequestModel.status =
                                                                            'H';
                                                                      } else if (fakultas ==
                                                                          'Hukum') {
                                                                        presensiOUTMahasiswaToFHRequestModel.idkelas =
                                                                            idkelasFakultas;

                                                                        presensiOUTMahasiswaToFHRequestModel.npm =
                                                                            npm;

                                                                        presensiOUTMahasiswaToFHRequestModel.pertemuan =
                                                                            pertemuan;

                                                                        // presensiOUTMahasiswaToFHRequestModel.tglout = jam +
                                                                        //     ' ' +
                                                                        //     tanggalnow;

                                                                        presensiOUTMahasiswaToFHRequestModel.status =
                                                                            'H';
                                                                      } else if (fakultas ==
                                                                          'Teknobiologi') {
                                                                        presensiOUTMahasiswaToFTBRequestModel.idkelas =
                                                                            idkelasFakultas;

                                                                        presensiOUTMahasiswaToFTBRequestModel.npm =
                                                                            npm;

                                                                        presensiOUTMahasiswaToFTBRequestModel.pertemuan =
                                                                            pertemuan;

                                                                        // presensiOUTMahasiswaToFTBRequestModel.tglout = jam +
                                                                        //     ' ' +
                                                                        //     tanggalnow;

                                                                        presensiOUTMahasiswaToFTBRequestModel.status =
                                                                            'H';
                                                                      } else if (fakultas ==
                                                                          'Ilmu Sosial dan Politik') {
                                                                        presensiOUTMahasiswaToFISIPRequestModel.idkelas =
                                                                            idkelasFakultas;

                                                                        presensiOUTMahasiswaToFISIPRequestModel.npm =
                                                                            npm;

                                                                        presensiOUTMahasiswaToFISIPRequestModel.pertemuan =
                                                                            pertemuan;

                                                                        // presensiOUTMahasiswaToFISIPRequestModel.tglout = jam +
                                                                        //     ' ' +
                                                                        //     tanggalnow;

                                                                        presensiOUTMahasiswaToFISIPRequestModel.status =
                                                                            'H';
                                                                      } else if (fakultas ==
                                                                          'Teknik') {
                                                                        presensiOUTMahasiswaToFTRequestModel.idkelas =
                                                                            idkelasFakultas;

                                                                        presensiOUTMahasiswaToFTRequestModel.npm =
                                                                            npm;

                                                                        presensiOUTMahasiswaToFTRequestModel.pertemuan =
                                                                            pertemuan;

                                                                        // presensiOUTMahasiswaToFTRequestModel.tglout = jam +
                                                                        //     ' ' +
                                                                        //     tanggalnow;

                                                                        presensiOUTMahasiswaToFTRequestModel.status =
                                                                            'H';
                                                                      } else if (fakultas ==
                                                                          'Teknologi Industri') {
                                                                        presensiOUTMahasiswaToFTIRequestModel.idkelas =
                                                                            idkelasFakultas;

                                                                        presensiOUTMahasiswaToFTIRequestModel.npm =
                                                                            npm;

                                                                        presensiOUTMahasiswaToFTIRequestModel.pertemuan =
                                                                            pertemuan;

                                                                        // presensiOUTMahasiswaToFTIRequestModel.tglout = jam +
                                                                        //     ' ' +
                                                                        //     tanggalnow;

                                                                        presensiOUTMahasiswaToFTIRequestModel.status =
                                                                            'H';
                                                                      }
                                                                    });

                                                                    // setState(
                                                                    //     () {
                                                                    //   isApiCallProcess =
                                                                    //       false;
                                                                    // });

                                                                    print(PresensiOUTMahasiswaToKSIRequestModel()
                                                                        .toJson());

                                                                    if (fakultas ==
                                                                        'Bisnis dan Ekonomika') {
                                                                      print(PresensiOUTMahasiswaToFBERequestModel()
                                                                          .toJson());
                                                                    } else if (fakultas ==
                                                                        'Hukum') {
                                                                      print(PresensiOUTMahasiswaToFHRequestModel()
                                                                          .toJson());
                                                                    } else if (fakultas ==
                                                                        'Teknobiologi') {
                                                                      print(PresensiOUTMahasiswaToFTBRequestModel()
                                                                          .toJson());
                                                                    } else if (fakultas ==
                                                                        'Ilmu Sosial dan Politik') {
                                                                      print(PresensiOUTMahasiswaToFISIPRequestModel()
                                                                          .toJson());
                                                                    } else if (fakultas ==
                                                                        'Teknik') {
                                                                      print(PresensiOUTMahasiswaToFTRequestModel()
                                                                          .toJson());
                                                                    } else if (fakultas ==
                                                                        'Teknologi Industri') {
                                                                      print(PresensiOUTMahasiswaToFTIRequestModel()
                                                                          .toJson());
                                                                    }

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

                                                                    if (fakultas ==
                                                                        'Bisnis dan Ekonomika') {
                                                                      await apiService
                                                                          .putUpdatePresensiMhsToFBE(
                                                                              presensiOUTMahasiswaToFBERequestModel);
                                                                    } else if (fakultas ==
                                                                        'Hukum') {
                                                                      await apiService
                                                                          .putUpdatePresensiMhsToFH(
                                                                              presensiOUTMahasiswaToFHRequestModel);
                                                                    } else if (fakultas ==
                                                                        'Teknobiologi') {
                                                                      await apiService
                                                                          .putUpdatePresensiMhsToFTB(
                                                                              presensiOUTMahasiswaToFTBRequestModel);
                                                                    } else if (fakultas ==
                                                                        'Ilmu Sosial dan Politik') {
                                                                      await apiService
                                                                          .putUpdatePresensiMhsToFISIP(
                                                                              presensiOUTMahasiswaToFISIPRequestModel);
                                                                    } else if (fakultas ==
                                                                        'Teknik') {
                                                                      await apiService
                                                                          .putUpdatePresensiMhsToFT(
                                                                              presensiOUTMahasiswaToFTRequestModel);
                                                                    } else if (fakultas ==
                                                                        'Teknologi Industri') {
                                                                      await apiService
                                                                          .putUpdatePresensiMhsToFTI(
                                                                              presensiOUTMahasiswaToFTIRequestModel);
                                                                    }

                                                                    await apiService
                                                                        .putUpdatePresensiMhsToKSI(
                                                                            presensiOUTMahasiswaToKSIRequestModel)
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
                                                                          '/mahasiswa/dashboard');

                                                                      await Fluttertoast.showToast(
                                                                          msg:
                                                                              'Berhasil presensi keluar dari kelas',
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
                                                                        .arrow_downward_rounded,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 25,
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
                                                    ]),
                                              ),
                                            ),
                                          ],
                                        ));
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: MaterialButton(
                                              color: Colors.blue,
                                              shape: StadiumBorder(),
                                              padding: EdgeInsets.only(
                                                  left: 50,
                                                  right: 50,
                                                  top: 25,
                                                  bottom: 25),
                                              onPressed: () => {
                                                Get.offAllNamed(
                                                    '/mahasiswa/dashboard')
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(Icons.arrow_back_rounded,
                                                      color: Colors.white),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    'Kembali',
                                                    style: TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
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
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        'Jarak Anda : ${beacon.accuracy} m',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'OpenSans',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .blue[500]),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        'Jarak Minimal : ${jarakmin.toStringAsFixed(2)} m',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'OpenSans',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .blue[500]),
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
}
