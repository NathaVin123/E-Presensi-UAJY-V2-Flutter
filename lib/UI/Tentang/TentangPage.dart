import 'package:flutter/material.dart';
import 'package:presensiblebeacon/Utils/extension_image.dart';

class TentangPage extends StatefulWidget {
  TentangPage({Key key}) : super(key: key);

  @override
  _TentangPageState createState() => _TentangPageState();
}

class _TentangPageState extends State<TentangPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          foregroundColor: Colors.black,
          elevation: 0,
          backgroundColor: Colors.grey[200],
          centerTitle: true,
          // title: Text(
          //   'Tentang Aplikasi',
          //   style: TextStyle(
          //       color: Colors.black,
          //       fontFamily: 'OpenSans',
          //       fontWeight: FontWeight.bold),
          // ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey[500],
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.75,
                    spreadRadius: 0.25)
              ], color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 14, right: 14, top: 14),
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(22),
                            child: CircleAvatar(
                                backgroundColor: Colors.blue[700],
                                radius: 50,
                                // child: const Text('NV'),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    'SplashPage_LogoAtmaJaya'.png,
                                  ),
                                ))),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Text('E-Presensi UAJY',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'OpenSans',
                                        fontSize: 22.0,
                                        color: Colors.black)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      'Aplikasi untuk mengisi data kehadiran perkuliahan new normal mahasiswa dan dosen dengan teknologi bluetooth low energy.',
                                      style: const TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontSize: 16,
                                          color: Colors.black)),
                                ),
                              ),
                              // Divider(
                              //   height: 20,
                              //   thickness: 1,
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Text('2022 KSI UAJY',
                                          style: const TextStyle(
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black)),
                                      // Text('2022',
                                      //     style: const TextStyle(
                                      //         fontFamily: 'OpenSans',
                                      //         fontWeight: FontWeight.bold,
                                      //         fontSize: 16,
                                      //         color: Colors.black)),
                                    ],
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Align(
                              //     alignment: Alignment.center,
                              //     child: Text('Version Beta',
                              //         style: const TextStyle(
                              //             fontFamily: 'OpenSans',
                              //             fontWeight: FontWeight.bold,
                              //             fontSize: 16,
                              //             color: Colors.black)),
                              //   ),
                              // ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
