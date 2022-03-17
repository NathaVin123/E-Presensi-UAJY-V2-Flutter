import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presensiblebeacon/Utils/extension_image.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 2000), () => navigateUser());
  }

  void navigateUser() async {
    SharedPreferences autoLogin = await SharedPreferences.getInstance();

    var statusMahasiswa = autoLogin.getBool('isLoggedMahasiswa') ?? false;
    var statusDosen = autoLogin.getBool('isLoggedDosen') ?? false;
    var statusAdmin = autoLogin.getBool('isLoggedAdmin') ?? false;

    print(statusMahasiswa);
    print(statusDosen);
    print(statusAdmin);

    if (statusMahasiswa) {
      return Get.offNamed('/mahasiswa/dashboard');
    } else if (statusDosen) {
      return Get.offNamed('/dosen/dashboard');
    } else if (statusAdmin) {
      return Get.offNamed('/admin/dashboard');
    } else {
      // return Get.offNamed('/bluetooth');
      return Get.offNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      // backgroundColor: Color.fromRGBO(49, 119, 212, 100),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Container(
          //   decoration: BoxDecoration(color: Color.fromRGBO(23, 75, 137, 1)),
          // ),
          Container(
              decoration: BoxDecoration(color: Colors.grey[50]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Image.asset(
                    'Logo_Splash_UAJY'.png,
                    height: 175,
                    fit: BoxFit.fill,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
