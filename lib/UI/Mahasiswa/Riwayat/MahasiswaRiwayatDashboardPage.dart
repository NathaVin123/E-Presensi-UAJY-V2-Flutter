import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:intl/intl.dart';
import 'package:presensiblebeacon/API/APIService.dart';
import 'package:presensiblebeacon/MODEL/Mahasiswa/RiwayatMahasiswaModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MahasiswaRiwayatDashboardPage extends StatefulWidget {
  MahasiswaRiwayatDashboardPage({Key key}) : super(key: key);

  @override
  _MahasiswaRiwayatDashboardPageState createState() =>
      _MahasiswaRiwayatDashboardPageState();
}

class _MahasiswaRiwayatDashboardPageState
    extends State<MahasiswaRiwayatDashboardPage> {
  // String _timeString;
  // String _dateString;

  String npm = "";

  // DateTime timeNow = DateTime.now();

  RiwayatMahasiswaRequestModel riwayatMahasiswaRequestModel;

  RiwayatMahasiswaResponseModel riwayatMahasiswaResponseModel;

  // ignore: deprecated_member_use
  List<Data> riwayatMahasiswaListSearch = List<Data>();
  @override
  void initState() {
    super.initState();

    riwayatMahasiswaRequestModel = RiwayatMahasiswaRequestModel();
    riwayatMahasiswaResponseModel = RiwayatMahasiswaResponseModel();

    // _timeString = _formatTime(DateTime.now());
    // _dateString = _formatDate(DateTime.now());

    // Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    // Timer.periodic(Duration(hours: 1), (Timer t) => _getDate());

    Timer.periodic(Duration(seconds: 2), (Timer t) {
      // getDataMahasiswa();
      getDataRiwayatMahasiswa();
      Future.delayed(Duration(seconds: 5), () {
        t.cancel();
      });
    });
  }

  getDataMahasiswa() async {
    SharedPreferences loginDosen = await SharedPreferences.getInstance();
    setState(() {
      npm = loginDosen.getString('npm');
    });
  }

  getDataRiwayatMahasiswa() async {
    // setState(() {
    riwayatMahasiswaRequestModel.npm = npm;

    print(riwayatMahasiswaRequestModel.toJson());
    APIService apiService = new APIService();
    apiService
        .postRiwayatMahasiswa(riwayatMahasiswaRequestModel)
        .then((value) async {
      riwayatMahasiswaResponseModel = value;

      riwayatMahasiswaListSearch = value.data;
    });

    return riwayatMahasiswaListSearch;
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
    // getDataRiwayatMahasiswa();
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
                getDataRiwayatMahasiswa(),
                Fluttertoast.showToast(
                    msg: 'Menyegarkan...',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 14.0)
              }),
      backgroundColor: Colors.grey[200],
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
          'Riwayat Presensi',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
          ),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey[500],
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.75,
                    spreadRadius: 0.25)
              ], color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    iconColor: Colors.black,
                    hintText: 'Cari Mata Kuliah',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  style: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 16.0,
                      color: Colors.black),
                  onChanged: (text) {
                    text = text.toLowerCase();
                    setState(() {
                      riwayatMahasiswaListSearch =
                          riwayatMahasiswaResponseModel.data.where((matkul) {
                        var namamk = matkul.namamk.toLowerCase();
                        return namamk.contains(text);
                      }).toList();
                    });
                  },
                ),
              ),
            ),
          ),
          // Center(
          //   child: Column(
          //     children: <Widget>[
          //       Center(
          //         child: Text(
          //           _dateString,
          //           style: TextStyle(
          //               fontSize: 16,
          //               fontFamily: 'OpenSans',
          //               color: Colors.white),
          //         ),
          //       ),
          //       Center(
          //         child: Text(
          //           _timeString,
          //           style: TextStyle(
          //               fontSize: 25,
          //               fontFamily: 'OpenSans',
          //               color: Colors.white),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          riwayatMahasiswaResponseModel.data == null
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
              : riwayatMahasiswaResponseModel.data.isEmpty
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
                                    'Riwayat presensi anda kosong',
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
                            itemCount: riwayatMahasiswaListSearch?.length,
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
                                              '${riwayatMahasiswaListSearch[index].hari1}, ${riwayatMahasiswaListSearch[index].tglmasuk}',
                                              style: TextStyle(
                                                color: Colors.blue[500],
                                                fontSize: 16,
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Scrollbar(
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
                                                            '${riwayatMahasiswaListSearch[index].namamk} ${riwayatMahasiswaListSearch[index].kelas}',
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
                                        new Text(
                                          'Pertemuan ke - ${riwayatMahasiswaListSearch[index].pertemuan}',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        if (riwayatMahasiswaResponseModel
                                                .data[index].status ==
                                            'H')
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: new Text(
                                              // 'Status : ${riwayatMahasiswaListSearch[index].status ?? "-"}',
                                              'Hadir',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                              ),
                                            ),
                                          )
                                        else if (riwayatMahasiswaResponseModel
                                                .data[index].status ==
                                            'A')
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: new Text(
                                              // 'Status : ${riwayatMahasiswaListSearch[index].status ?? "-"}',
                                              'Alpa',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                              ),
                                            ),
                                          )
                                        else if (riwayatMahasiswaResponseModel
                                                .data[index].status ==
                                            'I')
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: new Text(
                                              // 'Status : ${riwayatMahasiswaListSearch[index].status ?? "-"}',
                                              'Izin',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          )
                                        else
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: new Text(
                                              // 'Status : ${riwayatMahasiswaListSearch[index].status ?? "-"}',
                                              '-',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
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
                                            // Scrollbar(
                                            //   child: SingleChildScrollView(
                                            //     scrollDirection:
                                            //         Axis.horizontal,
                                            //     child: Row(
                                            //       children: [
                                            //         Padding(
                                            //           padding:
                                            //               const EdgeInsets.all(
                                            //                   4.0),
                                            //           child: Text(
                                            //             'Dosen Pengampu : ${riwayatMahasiswaListSearch[index].namadosen1}',
                                            //             style: TextStyle(
                                            //                 fontFamily:
                                            //                     'OpenSans',
                                            //                 fontWeight:
                                            //                     FontWeight.bold,
                                            //                 fontSize: 14),
                                            //           ),
                                            //         ),
                                            //       ],
                                            //     ),
                                            //   ),
                                            // ),
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.all(4.0),
                                            //   child: Text(
                                            //     'Ruang ${riwayatMahasiswaListSearch[index].ruang}',
                                            //     style: TextStyle(
                                            //         fontFamily: 'OpenSans',
                                            //         fontWeight: FontWeight.bold,
                                            //         fontSize: 14),
                                            //   ),
                                            // ),
                                            // Row(
                                            //   children: [
                                            //     Padding(
                                            //       padding:
                                            //           const EdgeInsets.all(4.0),
                                            //       child: Text(
                                            //         'SKS : ${riwayatMahasiswaListSearch[index].sks}',
                                            //         style: TextStyle(
                                            //             fontFamily: 'OpenSans',
                                            //             fontWeight:
                                            //                 FontWeight.bold,
                                            //             fontSize: 14),
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                            // Row(
                                            //   children: [
                                            //     Padding(
                                            //       padding:
                                            //           const EdgeInsets.all(4.0),
                                            //       child: Text(
                                            //         'Sesi : ${riwayatMahasiswaListSearch[index].sesi1}',
                                            //         style: TextStyle(
                                            //             fontFamily: 'OpenSans',
                                            //             fontWeight:
                                            //                 FontWeight.bold,
                                            //             fontSize: 14),
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                'Jam Masuk : ${riwayatMahasiswaListSearch[index].jammasukdosen ?? "-"}',
                                                style: TextStyle(
                                                    fontFamily: 'OpenSans',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                'Jam Keluar : ${riwayatMahasiswaListSearch[index].jamkeluardosen ?? "-"}',
                                                style: TextStyle(
                                                    fontFamily: 'OpenSans',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ],
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
