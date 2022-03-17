import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:presensiblebeacon/API/APIService.dart';
import 'package:presensiblebeacon/MODEL/Login/LoginAdminModel.dart';
import 'package:presensiblebeacon/UTILS/ProgressHUD.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAdmin extends StatefulWidget {
  const LoginAdmin({Key key}) : super(key: key);

  @override
  _LoginAdminState createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  var _nppAdminFieldController = TextEditingController();
  var _passwordAdminFieldController = TextEditingController();

  final FocusNode _nppAdminFieldFocus = FocusNode();
  final FocusNode _passwordAdminFieldFocus = FocusNode();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool hidePassword = true;
  bool isApiCallProcess = false;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  LoginAdminRequestModel loginAdminRequestModel;

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged;
    loginAdminRequestModel = new LoginAdminRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    Connectivity().checkConnectivity();
    return ProgressHUD(
      child: buildLoginAdmin(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0,
    );
  }

  Widget buildLoginAdmin(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          // centerTitle: true,
          // title: Text(
          //   'ADMIN',
          //   style: TextStyle(
          //       fontWeight: FontWeight.bold, fontFamily: 'OpenSans'),
          // ),
          actions: <Widget>[
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
          backgroundColor: Colors.grey[50],
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(color: Colors.grey[50]),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue[800],
                      radius: 75,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.app_settings_alt_rounded,
                          size: MediaQuery.of(context).size.height > 800
                              ? 100.0
                              : MediaQuery.of(context).size.height > 400
                                  ? 100
                                  : MediaQuery.of(context).size.height > 200
                                      ? 75
                                      : 0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Image(
                  //     height: MediaQuery.of(context).size.height > 800
                  //         ? 200.0
                  //         : 150,
                  //     fit: BoxFit.fill,
                  //     image: const AssetImage(
                  //         'assets/png/SplashPage_LogoAtmaJaya.png')),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[500],
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text('ADMIN',
                              style: const TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      key: scaffoldKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.2),
                                      offset: Offset(0, 10),
                                      blurRadius: 20)
                                ],
                              ),
                              child: Form(
                                key: globalFormKey,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 0,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: GetPlatform.isAndroid != null
                                            ? TextFormField(
                                                controller:
                                                    _nppAdminFieldController,
                                                focusNode: _nppAdminFieldFocus,
                                                onFieldSubmitted: (term) {
                                                  _fieldFocusChange(
                                                      context,
                                                      _nppAdminFieldFocus,
                                                      _passwordAdminFieldFocus);
                                                },
                                                textInputAction:
                                                    TextInputAction.next,
                                                style: const TextStyle(
                                                    fontFamily: 'OpenSans',
                                                    fontSize: 18.0,
                                                    color: Colors.black),
                                                keyboardType:
                                                    TextInputType.phone,
                                                onSaved: (input) =>
                                                    loginAdminRequestModel.npp =
                                                        input,
                                                validator: (input) => input
                                                            .length <
                                                        1
                                                    ? "NPP tidak boleh kosong"
                                                    : null,
                                                decoration: new InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(20.0),
                                                  hintText: "NPP",
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey)),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                  prefixIcon: Icon(
                                                    Icons.person_rounded,
                                                    color: Colors.black,
                                                    size: 22.0,
                                                  ),
                                                ),
                                              )
                                            : TextFormField(
                                                controller:
                                                    _nppAdminFieldController,
                                                focusNode: _nppAdminFieldFocus,
                                                onFieldSubmitted: (term) {
                                                  _fieldFocusChange(
                                                      context,
                                                      _nppAdminFieldFocus,
                                                      _passwordAdminFieldFocus);
                                                },
                                                textInputAction:
                                                    TextInputAction.next,
                                                style: const TextStyle(
                                                    fontFamily: 'OpenSans',
                                                    fontSize: 18.0,
                                                    color: Colors.black),
                                                keyboardType:
                                                    TextInputType.text,
                                                onSaved: (input) =>
                                                    loginAdminRequestModel.npp =
                                                        input,
                                                validator: (input) => input
                                                            .length <
                                                        1
                                                    ? "NPP tidak boleh kosong"
                                                    : null,
                                                decoration: new InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(20.0),
                                                  hintText: "NPP KARYAWAN",
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey)),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                  prefixIcon: Icon(
                                                    Icons.person_rounded,
                                                    color: Colors.black,
                                                    size: 22.0,
                                                  ),
                                                ),
                                              )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: TextFormField(
                                        controller:
                                            _passwordAdminFieldController,
                                        focusNode: _passwordAdminFieldFocus,
                                        textInputAction: TextInputAction.done,
                                        onFieldSubmitted: (value) {
                                          _passwordAdminFieldFocus.unfocus();
                                        },
                                        style: const TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontSize: 18.0,
                                            color: Colors.black),
                                        keyboardType: TextInputType.text,
                                        onSaved: (input) =>
                                            loginAdminRequestModel.password =
                                                input,
                                        validator: (input) => input.length < 1
                                            ? "PASSWORD tidak boleh kosong"
                                            : null,
                                        obscureText: hidePassword,
                                        decoration: new InputDecoration(
                                          contentPadding: EdgeInsets.all(20.0),
                                          hintText: "Password",
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          prefixIcon: Icon(
                                            Icons.lock_rounded,
                                            color: Colors.black,
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                hidePassword = !hidePassword;
                                              });
                                            },
                                            color: Colors.black,
                                            icon: Icon(hidePassword
                                                ? Icons.visibility_off
                                                : Icons.visibility),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: MaterialButton(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.login_rounded,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Masuk",
                                                style: const TextStyle(
                                                    fontFamily: 'OpenSans',
                                                    fontSize: 18.0,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                        color: Colors.blue[500],
                                        shape: StadiumBorder(),
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          try {
                                            if (validateAndSave()) {
                                              print(loginAdminRequestModel
                                                  .toJson());

                                              setState(() {
                                                isApiCallProcess = true;
                                              });

                                              APIService apiService =
                                                  new APIService();
                                              Future.delayed(
                                                  Duration(seconds: 5),
                                                  () async {
                                                // setState(() {
                                                  isApiCallProcess = false;
                                                // });

                                                Fluttertoast.showToast(
                                                    msg:
                                                        'Silahkan coba kembali',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 14.0);
                                              });
                                              apiService
                                                  .loginAdmin(
                                                      loginAdminRequestModel)
                                                  .then((value) async {
                                                if (value != null) {
                                                  setState(() {
                                                    isApiCallProcess = false;
                                                  });

                                                  if (value?.data?.token
                                                          ?.isNotEmpty ??
                                                      false) {
                                                    Get.offAllNamed(
                                                        '/admin/dashboard');
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            'Selamat datang,\n${value.data.namaadm}',
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor:
                                                            Colors.green,
                                                        textColor: Colors.white,
                                                        fontSize: 14.0);

                                                    SharedPreferences
                                                        loginAdmin =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    await loginAdmin.setString(
                                                        'npp', value.data.npp);
                                                    await loginAdmin.setString(
                                                        'namaadm',
                                                        value.data.namaadm);

                                                    SharedPreferences
                                                        autoLogin =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    autoLogin?.setBool(
                                                        "isLoggedAdmin", true);
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            'Silahkan Masukan NPP/Password dengan benar',
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor:
                                                            Colors.red,
                                                        textColor: Colors.white,
                                                        fontSize: 14.0);
                                                  }
                                                }
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
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Center(
                                  child: Text(
                                'Silahkan login dengan akun simka.',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: 'OpenSans'),
                              )),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 350,
                  ),
                ],
              )),
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
