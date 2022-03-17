import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:presensiblebeacon/UI/Login/LoginWidgets/LoginDosen.dart';
import 'package:presensiblebeacon/UI/Login/LoginWidgets/LoginMahasiswa.dart';
import 'package:presensiblebeacon/utils/bubble_indicator_painter.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  int showAdmin = 0;

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
        appBar: AppBar(
          // title: Text(
          //   'LOGIN',
          //   style: TextStyle(
          //       fontWeight: FontWeight.bold, fontFamily: 'WorkSansMedium'),
          // ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.grey[50],
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
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.grey[50]),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue[800],
                    radius: 75,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image(
                          height: MediaQuery.of(context).size.height > 800
                              ? 200.0
                              : MediaQuery.of(context).size.height > 400
                                  ? 150
                                  : MediaQuery.of(context).size.height > 200
                                      ? 75
                                      : 0,
                          fit: BoxFit.fill,
                          image: const AssetImage(
                              'assets/png/SplashPage_LogoAtmaJaya.png')),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: _buildMenuBar(context),
                ),
                Expanded(
                  flex: 2,
                  child: PageView(
                    controller: _pageController,
                    physics: const ClampingScrollPhysics(),
                    onPageChanged: (int i) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (i == 0) {
                        setState(() {
                          right = Colors.white;
                          left = Colors.black;
                          showAdmin = 0;
                        });
                      } else if (i == 1) {
                        setState(() {
                          right = Colors.black;
                          left = Colors.white;
                          showAdmin = 1;
                        });
                      }
                    },
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: const LoginMahasiswa(),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: const LoginDosen(),
                      ),
                    ],
                  ),
                ),
                showAdmin == 1
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blue[500],
                          ),
                          child: Center(
                            child: TextButton.icon(
                              label: Text('ADMIN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontFamily: 'OpenSans')),
                              onPressed: () => Get.toNamed('/login/admin'),
                              icon: Icon(
                                Icons.app_settings_alt_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 0,
                      ),
              ],
            ),
          ),
        ));
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.blue[500],
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).hintColor.withOpacity(0.2),
              offset: Offset(0, 10),
              blurRadius: 10)
        ],
      ),
      child: CustomPaint(
        painter: BubbleIndicatorPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: _onLoginMahasiswaButtonPress,
                child: Text(
                  'MAHASISWA',
                  style: TextStyle(
                      color: left, fontSize: 17.0, fontFamily: 'OpenSans'),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: _onLoginDosenButtonPress,
                child: Text(
                  'DOSEN',
                  style: TextStyle(
                      color: right, fontSize: 17.0, fontFamily: 'OpenSans'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onLoginMahasiswaButtonPress() {
    _pageController.animateToPage(0,
        duration: const Duration(milliseconds: 250), curve: Curves.decelerate);
  }

  void _onLoginDosenButtonPress() {
    _pageController?.animateToPage(1,
        duration: const Duration(milliseconds: 250), curve: Curves.decelerate);
  }
}
