import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presensiblebeacon/API/APIService.dart';
import 'package:presensiblebeacon/MODEL/Login/LoginMahasiswaModel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:presensiblebeacon/UTILS/ProgressHUD.dart';

class LoginMahasiswa extends StatefulWidget {
  const LoginMahasiswa({Key key}) : super(key: key);

  @override
  _LoginMahasiswaState createState() => _LoginMahasiswaState();
}

class _LoginMahasiswaState extends State<LoginMahasiswa> {
  var _npmFieldController = TextEditingController();
  var _passwordFieldController = TextEditingController();

  final FocusNode _npmFieldFocus = FocusNode();
  final FocusNode _passwordFieldFocus = FocusNode();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool hidePassword = true;
  bool isApiCallProcess = false;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  LoginMahasiswaRequestModel loginMahasiswaRequestModel;

  @override
  void initState() {
    super.initState();
    loginMahasiswaRequestModel = new LoginMahasiswaRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: buildLoginMahasiswa(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0,
    );
  }

  Widget buildLoginMahasiswa(BuildContext context) {
    return Container(
      key: scaffoldKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.2),
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
                      child: TextFormField(
                        controller: _npmFieldController,
                        focusNode: _npmFieldFocus,
                        onFieldSubmitted: (term) {
                          _fieldFocusChange(
                              context, _npmFieldFocus, _passwordFieldFocus);
                        },
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 18.0,
                            color: Colors.black),
                        keyboardType: TextInputType.number,
                        onSaved: (input) =>
                            loginMahasiswaRequestModel.npm = input,
                        validator: (input) =>
                            input.length < 1 ? "NPM tidak boleh kosong" : null,
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(20.0),
                          hintText: "NPM",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          prefixIcon: Icon(
                            Icons.person_rounded,
                            color: Colors.black,
                            size: 22.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        controller: _passwordFieldController,
                        focusNode: _passwordFieldFocus,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) {
                          _passwordFieldFocus.unfocus();
                        },
                        style: const TextStyle(
                            fontFamily: 'Ope',
                            fontSize: 18.0,
                            color: Colors.black),
                        keyboardType: TextInputType.text,
                        onSaved: (input) =>
                            loginMahasiswaRequestModel.password = input,
                        validator: (input) => input.length < 1
                            ? "Password tidak boleh kosong"
                            : null,
                        obscureText: hidePassword,
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(20.0),
                          hintText: "Password",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: MaterialButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          // try {
                          if (validateAndSave()) {
                            print(loginMahasiswaRequestModel.toJson());

                            setState(() {
                              isApiCallProcess = true;
                            });

                            APIService apiService = new APIService();
                            Future.delayed(Duration(seconds: 5), () {
                              // setState(() {
                              isApiCallProcess = false;
                              // });

                              Fluttertoast.showToast(
                                  msg: 'Silahkan coba kembali',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 14.0);
                            });
                            apiService
                                .loginMahasiswa(loginMahasiswaRequestModel)
                                .then((value) async {
                              if (value != null) {
                                setState(() {
                                  isApiCallProcess = false;
                                });

                                if (value?.data?.token?.isNotEmpty ?? false) {
                                  Get.offNamed('/mahasiswa/dashboard');

                                  Fluttertoast.showToast(
                                      msg:
                                          'Selamat datang,\n${value.data.namamhs}',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 14.0);

                                  SharedPreferences loginMahasiswa =
                                      await SharedPreferences.getInstance();
                                  await loginMahasiswa.setString(
                                      'npm', value.data.npm);
                                  await loginMahasiswa.setString(
                                      'namamhs', value.data.namamhs);
                                  await loginMahasiswa.setString(
                                      'fakultas', value.data.fakultas);
                                  await loginMahasiswa.setString(
                                      'prodi', value.data.prodi);
                                  // await loginMahasiswa.setString(
                                  //     'pembimbingakademik',
                                  //     value.data.pembimbingakademik);

                                  SharedPreferences autoLogin =
                                      await SharedPreferences.getInstance();
                                  autoLogin?.setBool("isLoggedMahasiswa", true);

                                  print(isApiCallProcess);
                                } else {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg:
                                          'Silahkan Masukan NPM/Password dengan benar',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 14.0);
                                }
                              }
                            });
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
                'Silahkan login dengan akun siatma.',
                style: TextStyle(
                    fontSize: 16, color: Colors.black, fontFamily: 'OpenSans'),
              )),
            ),
          ],
        ),
      ),
      // ),
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
