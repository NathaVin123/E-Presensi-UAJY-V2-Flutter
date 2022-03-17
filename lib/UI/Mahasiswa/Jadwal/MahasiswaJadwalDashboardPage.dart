import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

// import 'package:intl/intl.dart';
import 'package:presensiblebeacon/API/APIService.dart';
import 'package:presensiblebeacon/MODEL/Mahasiswa/JadwalMahasiswaModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MahasiswaJadwalDashboardPage extends StatefulWidget {
  MahasiswaJadwalDashboardPage({Key key}) : super(key: key);

  @override
  _MahasiswaJadwalDashboardPageState createState() =>
      _MahasiswaJadwalDashboardPageState();
}

class _MahasiswaJadwalDashboardPageState
    extends State<MahasiswaJadwalDashboardPage> {
  // String _timeString;
  // String _dateString;

  String npm = "";

  DateTime timeNow = DateTime.now();

  JadwalMahasiswaRequestModel jadwalMahasiswaRequestModel;

  JadwalMahasiswaResponseModel jadwalMahasiswaResponseModel;
  @override
  void initState() {
    super.initState();

    jadwalMahasiswaRequestModel = JadwalMahasiswaRequestModel();
    jadwalMahasiswaResponseModel = JadwalMahasiswaResponseModel();

    // _timeString = _formatTime(DateTime.now());
    // _dateString = _formatDate(DateTime.now());

    // Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    // Timer.periodic(Duration(hours: 1), (Timer t) => _getDate());

    Timer.periodic(Duration(seconds: 2), (Timer t) {
      // getDataMahasiswa();
      getDataJadwalMahasiswa();
      Future.delayed(Duration(seconds: 5), () {
        t.cancel();
      });
    });
  }

  getDataMahasiswa() async {
    SharedPreferences loginMahasiswa = await SharedPreferences.getInstance();
    setState(() {
      npm = loginMahasiswa.getString('npm');
    });
  }

  void getDataJadwalMahasiswa() async {
    // setState(() {
    jadwalMahasiswaRequestModel.npm = npm;

    print(jadwalMahasiswaRequestModel.toJson());
    APIService apiService = new APIService();
    apiService
        .postJadwalMahasiswa(jadwalMahasiswaRequestModel)
        .then((value) async {
      jadwalMahasiswaResponseModel = value;
    });
    // });
  }

  // void _getTime() {
  //   final DateTime now = DateTime.now();
  //   final String formattedTime = _formatTime(now);

  //   setState(() {
  //     _timeString = formattedTime;
  //   });
  // }

  // void _getDate() {
  //   final DateTime now = DateTime.now();
  //   final String formattedDate = _formatDate(now);

  //   setState(() {
  //     _dateString = formattedDate;
  //   });
  // }

  // String _formatDate(DateTime dateTime) {
  //   return DateFormat('d MMMM y').format(dateTime);
  // }

  // String _formatTime(DateTime dateTime) {
  //   return DateFormat('HH:mm:ss').format(dateTime);
  // }

  @override
  Widget build(BuildContext context) {
    getDataMahasiswa();
    // getDataJadwalMahasiswa();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          label: Text('Segarkan',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                  color: Colors.black)),
          backgroundColor: Colors.blue[200],
          icon: Icon(Icons.refresh_rounded, color: Colors.black),
          onPressed: () => {
                getDataJadwalMahasiswa(),
                Fluttertoast.showToast(
                    msg: 'Menyegarkan...',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 14.0)
              }),
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue[100],
        leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            }),
        centerTitle: true,
        title: Text(
          'Jadwal Kuliah',
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
      body: Column(
        children: <Widget>[
          // Center(
          //   child: Column(
          //     children: <Widget>[
          //       Column(
          //         children: <Widget>[
          //           Center(
          //             child: Text(
          //               _dateString,
          //               style: TextStyle(
          //                   fontSize: 16,
          //                   fontFamily: 'OpenSans',
          //                   color: Colors.white),
          //             ),
          //           ),
          //           Center(
          //             child: Text(
          //               _timeString,
          //               style: TextStyle(
          //                   fontSize: 25,
          //                   fontFamily: 'OpenSans',
          //                   color: Colors.white),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          // Center(
          //   child: Column(
          //     children: <Widget>[
          //       Column(
          //         children: <Widget>[
          //           Padding(
          //             padding: const EdgeInsets.all(10),
          //             child: Text(
          //               'Kuliah 1 Minggu Selanjutnya',
          //               style: TextStyle(
          //                   fontSize: 20,
          //                   fontFamily: 'OpenSans',
          //                   color: Colors.white,
          //                   fontWeight: FontWeight.bold),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          jadwalMahasiswaResponseModel.data == null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Mohon Tunggu..',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                )
              : jadwalMahasiswaResponseModel.data.isEmpty
                  ? Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'Jadwal kuliah anda kosong',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),

                              // Text(
                              //   'Silakan tekan tombol "Segarkan" jika bermasalah',
                              //   style: TextStyle(
                              //       fontSize: 14,
                              //       fontFamily: 'OpenSans',
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.white),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Scrollbar(
                        child: ListView.builder(
                            itemCount:
                                jadwalMahasiswaResponseModel.data?.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, top: 8, bottom: 8),
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
                                  child: new ListTile(
                                    title: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              '${jadwalMahasiswaResponseModel.data[index].hari1}, ${jadwalMahasiswaResponseModel.data[index].tglmasuk}' ??
                                                  '-',
                                              style: TextStyle(
                                                color: Colors.blue[500],
                                                fontSize: 16,
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Scrollbar(
                                            child: Center(
                                              child: Container(
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: new Text(
                                                              '${jadwalMahasiswaResponseModel.data[index].namamk} ${jadwalMahasiswaResponseModel.data[index].kelas}',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontFamily:
                                                                      'OpenSans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        new Text(
                                          'Pertemuan ke - ${jadwalMahasiswaResponseModel.data[index].pertemuan}',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.all(4.0),
                                            //   child: Container(
                                            //     decoration: BoxDecoration(
                                            //         color: Colors.red,
                                            //         borderRadius:
                                            //             BorderRadius.circular(
                                            //                 25)),
                                            //     child: Padding(
                                            //       padding:
                                            //           const EdgeInsets.all(4.0),
                                            //       child: Text(
                                            //         jadwalMahasiswaResponseModel
                                            //             .data[index].hari1,
                                            //         style: TextStyle(
                                            //           color: Colors.grey[50],
                                            //           fontSize: 14,
                                            //           fontFamily: 'OpenSans',
                                            //           fontWeight:
                                            //               FontWeight.bold,
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        ExpansionTile(
                                          title: Text(
                                            'Detail',
                                            style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          children: [
                                            Scrollbar(
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        '${jadwalMahasiswaResponseModel.data[index].namadosen1}',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'OpenSans',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Text(
                                                      'Sesi ${jadwalMahasiswaResponseModel.data[index].sesi1}',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: 'OpenSans',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    'Ruang ${jadwalMahasiswaResponseModel.data[index].ruang}',
                                                    style: TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    '${jadwalMahasiswaResponseModel.data[index].sks} SKS',
                                                    style: TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                '${jadwalMahasiswaResponseModel.data[index].jammasuk} - ${jadwalMahasiswaResponseModel.data[index].jamkeluar}',
                                                style: TextStyle(
                                                    fontFamily: 'OpenSans',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: MaterialButton(
                                            padding: EdgeInsets.all(8),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 26),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.people_alt_rounded,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    'Tampil Peserta',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'OpenSans',
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            color: Colors.blue[300],
                                            shape: StadiumBorder(),
                                            onPressed: () async {
                                              SharedPreferences
                                                  dataPresensiDosen =
                                                  await SharedPreferences
                                                      .getInstance();

                                              await dataPresensiDosen.setInt(
                                                  'idkelas',
                                                  jadwalMahasiswaResponseModel
                                                      .data[index].idkelas);

                                              Get.toNamed(
                                                  '/mahasiswa/dashboard/presensi/detail/tampilpeserta');
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () async {
                                      // await Get.toNamed(
                                      //     '/mahasiswa/dashboard/jadwal/detail');
                                    },
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
        ],
      ),
    );
  }
}
