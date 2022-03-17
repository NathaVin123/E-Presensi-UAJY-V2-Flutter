import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:presensiblebeacon/API/APIService.dart';
import 'package:presensiblebeacon/MODEL/Beacon/UbahBeaconModel.dart';
import 'package:presensiblebeacon/UTILS/ProgressHUD.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDetailUbahBeacon extends StatefulWidget {
  AdminDetailUbahBeacon({Key key}) : super(key: key);

  @override
  _AdminDetailUbahBeaconState createState() => _AdminDetailUbahBeaconState();
}

class _AdminDetailUbahBeaconState extends State<AdminDetailUbahBeacon> {
  // var _namaDeviceFieldController = new TextEditingController();
  // var _jarakMinFieldController = new TextEditingController();

  final FocusNode _namaDeviceFieldFocus = FocusNode();
  final FocusNode _jarakMinFieldFocus = FocusNode();
  final FocusNode _majorFieldFocus = FocusNode();
  final FocusNode _minorFieldFocus = FocusNode();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isApiCallProcess = false;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  UbahBeaconRequestModel ubahBeaconRequestModel;

  String uuid = "";
  String namadevice = "";
  double jarakmin = 0;
  int major = 0;
  int minor = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      getDataUbahBeacon();
      Future.delayed(Duration(seconds: 2), () {
        t.cancel();
      });
    });

    ubahBeaconRequestModel = new UbahBeaconRequestModel();
  }

  getDataUbahBeacon() async {
    SharedPreferences ubahBeacon = await SharedPreferences.getInstance();
    setState(() {
      uuid = ubahBeacon.getString('uuid');
      namadevice = ubahBeacon.getString('namadevice');
      jarakmin = ubahBeacon.getDouble('jarakmin');
      major = ubahBeacon.getInt('major');
      minor = ubahBeacon.getInt('minor');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: buildUbahBeacon(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0,
    );
  }

  Widget buildUbahBeacon(BuildContext context) {
    // getDataUbahBeacon();
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          foregroundColor: Colors.black,
          elevation: 0,
          backgroundColor: Colors.blue[100],
          centerTitle: true,
          title: Text(
            'Ubah Spesifikasi Beacon',
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey[500],
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.75,
                    spreadRadius: 0.25)
              ], color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Form(
                      key: globalFormKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'UUID',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: TextFormField(
                              controller: TextEditingController(text: uuid),
                              enabled: false,
                              style: const TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 16.0,
                                  color: Colors.grey),
                              decoration: new InputDecoration(hintText: uuid),
                              onSaved: (input) =>
                                  ubahBeaconRequestModel.uuid = input,
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Nama Perangkat',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: TextFormField(
                              controller:
                                  TextEditingController(text: namadevice),
                              // controller: _namaDeviceFieldController,
                              focusNode: _namaDeviceFieldFocus,
                              onFieldSubmitted: (term) {
                                _fieldFocusChange(context,
                                    _namaDeviceFieldFocus, _jarakMinFieldFocus);
                              },
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 16.0,
                                  color: Colors.black),
                              keyboardType: TextInputType.text,
                              onSaved: (input) =>
                                  ubahBeaconRequestModel.namadevice = input,
                              validator: (input) => input.length < 1
                                  ? "Tidak boleh kosong"
                                  : null,
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Jarak Minimal',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: TextFormField(
                              controller: TextEditingController(
                                  text: jarakmin.toString()),
                              // controller: _jarakMinFieldController,
                              focusNode: _jarakMinFieldFocus,
                              onFieldSubmitted: (term) {
                                _fieldFocusChange(context, _jarakMinFieldFocus,
                                    _majorFieldFocus);
                              },
                              textInputAction: TextInputAction.done,
                              style: const TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 16.0,
                                  color: Colors.black),
                              keyboardType: TextInputType.number,
                              onSaved: (input) =>
                                  ubahBeaconRequestModel.jarakmin = input,
                              validator: (input) => input.length < 1
                                  ? "Tidak boleh kosong"
                                  : null,
                              decoration:
                                  new InputDecoration(hintText: "Meter"),
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Major',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: TextFormField(
                                    controller: TextEditingController(
                                        text: major.toString()),
                                    // controller: _jarakMinFieldController,
                                    focusNode: _majorFieldFocus,
                                    onFieldSubmitted: (term) {
                                      _fieldFocusChange(context,
                                          _majorFieldFocus, _minorFieldFocus);
                                    },
                                    textInputAction: TextInputAction.done,
                                    style: const TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontSize: 16.0,
                                        color: Colors.black),
                                    keyboardType: TextInputType.number,
                                    onSaved: (input) =>
                                        ubahBeaconRequestModel.major = input,
                                    validator: (input) => input.length < 1
                                        ? "Tidak boleh kosong"
                                        : null,
                                    decoration: new InputDecoration(
                                        hintText: "0 - 65535"))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Minor',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: TextFormField(
                                    controller: TextEditingController(
                                        text: minor.toString()),
                                    // controller: _jarakMinFieldController,
                                    focusNode: _minorFieldFocus,
                                    onFieldSubmitted: (value) {
                                      _jarakMinFieldFocus.unfocus();
                                    },
                                    textInputAction: TextInputAction.done,
                                    style: const TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontSize: 16.0,
                                        color: Colors.black),
                                    keyboardType: TextInputType.number,
                                    onSaved: (input) =>
                                        ubahBeaconRequestModel.minor = input,
                                    validator: (input) => input.length < 1
                                        ? "Tidak boleh kosong"
                                        : null,
                                    decoration: new InputDecoration(
                                        hintText: "0 - 65535"))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          MaterialButton(
                              color: Colors.blue[500],
                              shape: StadiumBorder(),
                              padding: EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Ubah",
                                    style: const TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                try {
                                  if (validateAndSave()) {
                                    print(ubahBeaconRequestModel.toJson());

                                    setState(() {
                                      isApiCallProcess = true;
                                    });

                                    Future.delayed(Duration(seconds: 10),
                                        () async {
                                      //setState(() {
                                      isApiCallProcess = false;
                                      //});

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

                                    apiService
                                        .putUbahBeacon(ubahBeaconRequestModel)
                                        .then((value) async {
                                      if (value != null) {
                                        setState(() {
                                          isApiCallProcess = false;
                                        });
                                      }

                                      Get.offNamed('/admin/menu/beacon/ubah');
                                      Get.back();

                                      await Fluttertoast.showToast(
                                          msg: 'Berhasil Mengubah Beacon',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 14.0);
                                    });
                                  }
                                } catch (error) {
                                  Fluttertoast.showToast(
                                      msg:
                                          'Terjadi kesalahan, silahkan coba lagi',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 14.0);
                                }
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
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
