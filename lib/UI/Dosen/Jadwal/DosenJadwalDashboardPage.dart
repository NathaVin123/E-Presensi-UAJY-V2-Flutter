import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

// import 'package:intl/intl.dart';
import 'package:presensiblebeacon/API/APIService.dart';
import 'package:presensiblebeacon/MODEL/Dosen/JadwalDosenModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DosenJadwalDashboardPage extends StatefulWidget {
  DosenJadwalDashboardPage({Key key}) : super(key: key);

  @override
  _DosenJadwalDashboardPageState createState() =>
      _DosenJadwalDashboardPageState();
}

class _DosenJadwalDashboardPageState extends State<DosenJadwalDashboardPage> {
  // String _timeString;
  // String _dateString;

  String npp = "";

  DateTime timeNow = DateTime.now();

  JadwalDosenRequestModel jadwalDosenRequestModel;

  JadwalDosenResponseModel jadwalDosenResponseModel;

  // ignore: deprecated_member_use
  List<Data> jadwalDosenListSearch = List<Data>();
  @override
  void initState() {
    super.initState();

    jadwalDosenRequestModel = JadwalDosenRequestModel();
    jadwalDosenResponseModel = JadwalDosenResponseModel();

    // _timeString = _formatTime(DateTime.now());
    // _dateString = _formatDate(DateTime.now());

    // Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    // Timer.periodic(Duration(hours: 1), (Timer t) => _getDate());

    Timer.periodic(Duration(seconds: 2), (Timer t) {
      getDataJadwalDosen();
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

  getDataJadwalDosen() async {
    // setState(() {
    jadwalDosenRequestModel.npp = npp;

    print(jadwalDosenRequestModel.toJson());
    APIService apiService = new APIService();
    apiService.postJadwalDosen(jadwalDosenRequestModel).then((value) async {
      jadwalDosenResponseModel = value;

      jadwalDosenListSearch = value.data;
    });

    return jadwalDosenListSearch;
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
                getDataJadwalDosen(),
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
                      jadwalDosenListSearch =
                          jadwalDosenResponseModel.data.where((jadwal) {
                        var namamatkul = jadwal.namamk.toLowerCase();
                        return namamatkul.contains(text);
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
          jadwalDosenResponseModel.data == null
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
              : jadwalDosenResponseModel.data.isEmpty
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
                            itemCount: jadwalDosenListSearch.length,
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
                                              '${jadwalDosenListSearch[index].hari1}, ${jadwalDosenListSearch[index].tglmasuk}',
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
                                                            '${jadwalDosenListSearch[index].namamk} ${jadwalDosenListSearch[index].kelas}',
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
                                          child: Text(
                                            'Pertemuan ke - ${jadwalDosenListSearch[index].pertemuan}',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14,
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            'Jumlah mahasiswa : ${jadwalDosenListSearch[index].total}' ??
                                                '-',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14,
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        jadwalDosenListSearch[index]
                                                        .cekjammasuk ==
                                                    null ||
                                                jadwalDosenListSearch[index]
                                                    .cekjammasuk
                                                    .isEmpty
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: new Text(
                                                  'Belum Presensi',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 16,
                                                      fontFamily: 'OpenSans',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: new Text(
                                                  'Sudah Presensi',
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 16,
                                                      fontFamily: 'OpenSans',
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    'Sesi ${jadwalDosenListSearch[index].sesi1}',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'OpenSans',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    'Ruang ${jadwalDosenListSearch[index].ruang}',
                                                    style: TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    '${jadwalDosenListSearch[index].sks} SKS',
                                                    style: TextStyle(
                                                        color: Colors.black,
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
                                                '${jadwalDosenListSearch[index].jammasuk} - ${jadwalDosenListSearch[index].jamkeluar}',
                                                style: TextStyle(
                                                    fontFamily: 'OpenSans',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.all(4.0),
                                            //   child: Text(
                                            //     '${jadwalDosenListSearch.data[index].cekjammasuk ?? '-'}',
                                            //     style: TextStyle(
                                            //         fontFamily: 'OpenSans',
                                            //         fontWeight: FontWeight.bold,
                                            //         fontSize: 14),
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
                                                    'Presensi Manual',
                                                    style: const TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                  ),
                                                ],
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
                                                  jadwalDosenListSearch[index]
                                                      .idkelas);

                                              await dataPresensiDosen.setString(
                                                  'dosen',
                                                  jadwalDosenListSearch[index]
                                                      .namadosen1);

                                              await dataPresensiDosen.setString(
                                                  'npp',
                                                  jadwalDosenListSearch[index]
                                                      .nppdosen1);

                                              await dataPresensiDosen.setString(
                                                  'namamk',
                                                  jadwalDosenListSearch[index]
                                                      .namamk);

                                              await dataPresensiDosen.setString(
                                                  'kelas',
                                                  jadwalDosenListSearch[index]
                                                      .kelas);

                                              await dataPresensiDosen.setInt(
                                                  'pertemuan',
                                                  jadwalDosenListSearch[index]
                                                      .pertemuan);

                                              await dataPresensiDosen.setInt(
                                                  'sks',
                                                  jadwalDosenListSearch[index]
                                                      .sks);

                                              await dataPresensiDosen.setString(
                                                  'sesi',
                                                  jadwalDosenListSearch[index]
                                                      .sesi1);
                                              if (jadwalDosenListSearch[index]
                                                      .cekjammasuk !=
                                                  null) {
                                                await dataPresensiDosen
                                                    .setString(
                                                        'cekjammasuk',
                                                        jadwalDosenListSearch[
                                                                index]
                                                            .cekjammasuk);
                                              } else {
                                                await dataPresensiDosen
                                                    .setString(
                                                        'cekjammasuk', '-');
                                              }

                                              Get.toNamed(
                                                  '/dosen/dashboard/jadwal/presensi/appbar');
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
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
