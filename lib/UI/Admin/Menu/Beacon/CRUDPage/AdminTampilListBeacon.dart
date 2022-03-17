import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presensiblebeacon/API/APIService.dart';
import 'package:presensiblebeacon/MODEL/Beacon/ListBeaconModel.dart';

class AdminTampilListBeacon extends StatefulWidget {
  AdminTampilListBeacon({Key key}) : super(key: key);

  @override
  _AdminTampilListBeaconState createState() => _AdminTampilListBeaconState();
}

class _AdminTampilListBeaconState extends State<AdminTampilListBeacon> {
  ListBeaconResponseModel listBeaconResponseModel;

  List<Data> beaconListSearch = List<Data>();

  bool condition = false;

  @override
  void initState() {
    super.initState();

    listBeaconResponseModel = ListBeaconResponseModel();

    Timer.periodic(Duration(seconds: 2), (Timer t) {
      getListBeacon();
      Future.delayed(Duration(seconds: 5), () {
        t.cancel();
      });
    });
  }

  getListBeacon() async {
    setState(() {
      print(listBeaconResponseModel.toJson());

      APIService apiService = new APIService();

      apiService.getListBeacon().then((value) async {
        listBeaconResponseModel = value;

        beaconListSearch = value.data;
      });
    });

    return beaconListSearch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.blue[100],
        centerTitle: true,
        title: Text(
          'Tampil Beacon',
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue[200],
        label: Text('Segarkan',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold)),
        onPressed: () => {
          getListBeacon(),
          Fluttertoast.showToast(
              msg: 'Menyegarkan...',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 14.0)
        },
        icon: Icon(
          Icons.refresh_rounded,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      backgroundColor: Colors.grey[50],
      body: listBeaconResponseModel.data == null
          ? Container(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
              ),
            )
          : listBeaconResponseModel.data.isEmpty
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
                                'Beacon Kosong',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
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
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.search),
                              iconColor: Colors.black,
                              hintText: 'Cari Beacon',
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
                                beaconListSearch = listBeaconResponseModel.data
                                    .where((beacon) {
                                  var namabeacon =
                                      beacon.namadevice.toLowerCase();
                                  return namabeacon.contains(text);
                                }).toList();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Scrollbar(
                        child: ListView.builder(
                            itemCount: beaconListSearch.length,
                            itemBuilder: (context, index) {
                              // if (beaconListSearch[index].status == 1 ||
                              //     beaconListSearch[index].status == null) {
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
                                    title: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: new Text(
                                              beaconListSearch[index]
                                                  .namadevice,
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontFamily: 'OpenSans',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: new Text(
                                              'UUID : ${beaconListSearch[index].uuid}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.all(4.0),
                                          //   child: Scrollbar(
                                          //     child: SingleChildScrollView(
                                          //       scrollDirection:
                                          //           Axis.horizontal,
                                          //       child: new Text(
                                          //         beaconListSearch[index].uuid,
                                          //         style: TextStyle(
                                          //           fontSize: 15,
                                          //           fontFamily: 'OpenSans',
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: new Text(
                                                      'Jarak Minimal',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'OpenSans',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: new Text(
                                                      '${beaconListSearch[index].jarakmin} m',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'OpenSans',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: new Text(
                                                      'Major',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'OpenSans',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: new Text(
                                                      '${beaconListSearch[index].major}',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'OpenSans',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: new Text(
                                                      'Minor',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'OpenSans',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: new Text(
                                                      '${beaconListSearch[index].minor}',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: 'OpenSans',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                              // } else {
                              //   return SizedBox(
                              //     height: 0,
                              //   );
                              // }
                            }),
                      ),
                    )
                    // ),
                  ],
                ),
      //     )
      //   ],
      // ),
    );
  }
}
