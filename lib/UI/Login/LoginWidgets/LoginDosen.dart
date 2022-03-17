import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presensiblebeacon/API/APIService.dart';
import 'package:presensiblebeacon/MODEL/Login/LoginDosenModel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:presensiblebeacon/UTILS/ProgressHUD.dart';

class LoginDosen extends StatefulWidget {
  const LoginDosen({Key key}) : super(key: key);

  @override
  _LoginDosenState createState() => _LoginDosenState();
}

class _LoginDosenState extends State<LoginDosen> {
  var _nppFieldController = TextEditingController();
  var _passwordFieldController = TextEditingController();

  final FocusNode _nppFieldFocus = FocusNode();
  final FocusNode _passwordFieldFocus = FocusNode();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool hidePassword = true;
  bool isApiCallProcess = false;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  LoginDosenRequestModel loginDosenRequestModel;

  @override
  void initState() {
    super.initState();
    loginDosenRequestModel = new LoginDosenRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: buildLoginDosen(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0,
    );
  }

  Widget buildLoginDosen(BuildContext context) {
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
                        child: GetPlatform.isAndroid != null
                            ? TextFormField(
                                controller: _nppFieldController,
                                focusNode: _nppFieldFocus,
                                onFieldSubmitted: (term) {
                                  _fieldFocusChange(context, _nppFieldFocus,
                                      _passwordFieldFocus);
                                },
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 18.0,
                                    color: Colors.black),
                                keyboardType: TextInputType.phone,
                                onSaved: (input) =>
                                    loginDosenRequestModel.npp = input,
                                validator: (input) => input.length < 1
                                    ? "NPP tidak boleh kosong"
                                    : null,
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.all(20.0),
                                  hintText: "NPP",
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  prefixIcon: Icon(
                                    Icons.person_rounded,
                                    color: Colors.black,
                                    size: 22.0,
                                  ),
                                ),
                              )
                            : TextFormField(
                                controller: _nppFieldController,
                                focusNode: _nppFieldFocus,
                                onFieldSubmitted: (term) {
                                  _fieldFocusChange(context, _nppFieldFocus,
                                      _passwordFieldFocus);
                                },
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 18.0,
                                    color: Colors.black),
                                keyboardType: TextInputType.text,
                                onSaved: (input) =>
                                    loginDosenRequestModel.npp = input,
                                validator: (input) => input.length < 1
                                    ? "NPP tidak boleh kosong"
                                    : null,
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.all(20.0),
                                  hintText: "NPP DOSEN",
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  prefixIcon: Icon(
                                    Icons.person_rounded,
                                    color: Colors.black,
                                    size: 22.0,
                                  ),
                                ),
                              )),
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
                            fontFamily: 'OpenSans',
                            fontSize: 18.0,
                            color: Colors.black),
                        keyboardType: TextInputType.text,
                        onSaved: (input) =>
                            loginDosenRequestModel.password = input,
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
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          try {
                            if (validateAndSave()) {
                              print(loginDosenRequestModel.toJson());

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
                                  .loginDosen(loginDosenRequestModel)
                                  .then((value) async {
                                if (value != null) {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });

                                  if (value?.data?.token?.isNotEmpty ?? false) {
                                    Get.offNamed('/dosen/dashboard');

                                    Fluttertoast.showToast(
                                        msg:
                                            'Selamat datang,\n${value.data.namadsn}',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 14.0);

                                    SharedPreferences loginDosen =
                                        await SharedPreferences.getInstance();
                                    await loginDosen.setString(
                                        'npp', value.data.npp);
                                    await loginDosen.setString(
                                        'namadsn', value.data.namadsn);
                                    await loginDosen.setString(
                                        'prodi', value.data.prodi);
                                    await loginDosen.setString(
                                        'fakultas', value.data.fakultas);

                                    SharedPreferences autoLogin =
                                        await SharedPreferences.getInstance();
                                    autoLogin?.setBool("isLoggedDosen", true);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            'Silahkan Masukan NPP/Password dengan benar',
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
                          } catch (error) {
                            Fluttertoast.showToast(
                                msg: 'Terjadi kesalahan, silahkan coba lagi',
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
