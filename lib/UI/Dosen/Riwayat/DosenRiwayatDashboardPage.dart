import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

// import 'package:intl/intl.dart';
import 'package:presensiblebeacon/API/APIService.dart';
import 'package:presensiblebeacon/MODEL/Dosen/RiwayatDosenModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DosenRiwayatDashboardPage extends StatefulWidget {
  DosenRiwayatDashboardPage({Key key}) : super(key: key);

  @override
  _DosenRiwayatDashboardPageState createState() =>
      _DosenRiwayatDashboardPageState();
}

class _DosenRiwayatDashboardPageState extends State<DosenRiwayatDashboardPage> {
  // String _timeString;
  // String _dateString;

  String npp = "";

  // DateTime timeNow = DateTime.now();

  RiwayatDosenRequestModel riwayatDosenRequestModel;

  RiwayatDosenResponseModel riwayatDosenResponseModel;

  List<Data> riwayatDosenListSearch = List<Data>();
  @override
  void initState() {
    super.initState();

    riwayatDosenRequestModel = RiwayatDosenRequestModel();
    riwayatDosenResponseModel = RiwayatDosenResponseModel();

    // _timeString = _formatTime(DateTime.now());
    // _dateString = _formatDate(DateTime.now());

    // Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    // Timer.periodic(Duration(hours: 1), (Timer t) => _getDate());

    Timer.periodic(Duration(seconds: 2), (Timer t) {
      getDataRiwayatDosen();
      Future.delayed(Duration(seconds: 5), () {
        t.cancel();
      });
    });
  }

  getDataDosen() async {
    SharedPreferences loginDosen = await SharedPreferences.getInstance();
    setState(() {
      npp = loginDosen.getString('npp');
    });
  }

  getDataRiwayatDosen() async {
    // setState(() {
    riwayatDosenRequestModel.npp = npp;

    print(riwayatDosenRequestModel.toJson());
    APIService apiService = new APIService();
    apiService.postRiwayatDosen(riwayatDosenRequestModel).then((value) async {
      riwayatDosenResponseModel = value;

      riwayatDosenListSearch = value.data;
    });
    // });
    return riwayatDosenListSearch;
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
    getDataDosen();
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
                getDataRiwayatDosen(),
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
          'Riwayat Presensi',
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
                      riwayatDosenListSearch =
                          riwayatDosenResponseModel.data.where((matkul) {
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
          riwayatDosenResponseModel.data == null
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
              : riwayatDosenResponseModel.data.isEmpty
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
                            itemCount: riwayatDosenListSearch.length,
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
                                              '${riwayatDosenListSearch[index].hari1}, ${riwayatDosenListSearch[index].tglmasuk}',
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
                                                            '${riwayatDosenListSearch[index].namamk} ${riwayatDosenListSearch[index].kelas}',
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
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: new Text(
                                            'Pertemuan ke - ${riwayatDosenListSearch[index].pertemuan}',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14,
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.bold,
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
                                              child: new Text(
                                                'Hadir : ${riwayatDosenListSearch[index].hadir ?? '-'}',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 14,
                                                  fontFamily: 'OpenSans',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: new Text(
                                                'Alpa : ${riwayatDosenListSearch[index].tidakhadir ?? '-'}',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 14,
                                                  fontFamily: 'OpenSans',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: new Text(
                                                'Izin : ${riwayatDosenListSearch[index].izin ?? '-'}',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 14,
                                                  fontFamily: 'OpenSans',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
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
                                            // Row(
                                            //   children: [
                                            //     Padding(
                                            //       padding:
                                            //           const EdgeInsets.all(4.0),
                                            //       child: Text(
                                            //         'Ruang : ${riwayatDosenListSearch[index].ruang}',
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
                                            //         'SKS : ${riwayatDosenListSearch[index].sks}',
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
                                            //         'Sesi : ${riwayatDosenListSearch[index].sesi1}',
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
                                            //         'Jam Kelas :  ${riwayatDosenListSearch[index].jammasuk} - ${riwayatDosenListSearch[index].jamkeluar}',
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
                                                'Keterangan : ${riwayatDosenListSearch[index].keterangan ?? "-"}',
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
                                                'Materi : ${riwayatDosenListSearch[index].materi ?? "-"}',
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
                                                'Jam Masuk : ${riwayatDosenListSearch[index].jammasukdosen ?? "-"}',
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
                                                'Jam Keluar : ${riwayatDosenListSearch[index].jamkeluardosen ?? "-"}',
                                                style: TextStyle(
                                                    fontFamily: 'OpenSans',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ),

                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.all(4.0),
                                            //   child: MaterialButton(
                                            //     padding: EdgeInsets.all(8),
                                            //     child: Padding(
                                            //       padding: const EdgeInsets
                                            //               .symmetric(
                                            //           vertical: 8,
                                            //           horizontal: 26),
                                            //       child: Scrollbar(
                                            //         child:
                                            //             SingleChildScrollView(
                                            //           scrollDirection:
                                            //               Axis.horizontal,
                                            //           child: Row(
                                            //             mainAxisAlignment:
                                            //                 MainAxisAlignment
                                            //                     .center,
                                            //             children: <Widget>[
                                            //               Icon(
                                            //                 Icons
                                            //                     .people_alt_rounded,
                                            //                 color: Colors.white,
                                            //               ),
                                            //               SizedBox(
                                            //                 width: 20,
                                            //               ),
                                            //               Text(
                                            //                 'Tampil Kehadiran Kelas',
                                            //                 style: const TextStyle(
                                            //                     fontWeight:
                                            //                         FontWeight
                                            //                             .bold,
                                            //                     fontFamily:
                                            //                         'OpenSans',
                                            //                     fontSize: 16,
                                            //                     color: Colors
                                            //                         .white),
                                            //               ),
                                            //             ],
                                            //           ),
                                            //         ),
                                            //       ),
                                            //     ),
                                            //     color: Colors.blue[500],
                                            //     shape: StadiumBorder(),
                                            //     onPressed: () async {
                                            //       SharedPreferences
                                            //           dataPresensiDosen =
                                            //           await SharedPreferences
                                            //               .getInstance();

                                            //       await dataPresensiDosen.setInt(
                                            //           'idkelas',
                                            //           riwayatDosenResponseModel
                                            //               .data[index].idkelas);

                                            //       await dataPresensiDosen.setInt(
                                            //           'pertemuan',
                                            //           riwayatDosenResponseModel
                                            //               .data[index]
                                            //               .pertemuan);

                                            //       Get.toNamed(
                                            //           '/dosen/dashboard/presensi/detail/tampilkehadiranpeserta');
                                            //     },
                                            //   ),
                                            // ),
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
                                              child: Scrollbar(
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons
                                                            .people_alt_rounded,
                                                        color: Colors.black,
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        'Anulir Presensi',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'OpenSans',
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            color: Colors.blue[200],
                                            shape: StadiumBorder(),
                                            onPressed: () async {
                                              SharedPreferences
                                                  dataPresensiDosen =
                                                  await SharedPreferences
                                                      .getInstance();

                                              await dataPresensiDosen.setInt(
                                                  'idkelas',
                                                  riwayatDosenListSearch[index]
                                                      .idkelas);

                                              await dataPresensiDosen.setInt(
                                                  'pertemuan',
                                                  riwayatDosenListSearch[index]
                                                      .pertemuan);

                                              Get.toNamed(
                                                  '/dosen/dashboard/riwayat/presensi/appbar');
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
