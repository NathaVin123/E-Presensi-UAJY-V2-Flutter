import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presensiblebeacon/API/APIService.dart';
import 'package:presensiblebeacon/MODEL/Ruangan/ListDetailRuanganModel.dart';

class AdminTampilRuanganPage extends StatefulWidget {
  AdminTampilRuanganPage({Key key}) : super(key: key);

  @override
  _AdminTampilRuanganPageState createState() => _AdminTampilRuanganPageState();
}

class _AdminTampilRuanganPageState extends State<AdminTampilRuanganPage> {
  ListDetailRuanganResponseModel listDetailRuanganResponseModel;

  List<Data> ruanganListSearch = List<Data>();

  @override
  void initState() {
    super.initState();

    listDetailRuanganResponseModel = ListDetailRuanganResponseModel();

    Timer.periodic(Duration(seconds: 2), (Timer t) {
      getListDetailRuangan();
      Future.delayed(Duration(seconds: 5), () {
        t.cancel();
      });
    });
  }

  void getListDetailRuangan() async {
    setState(() {
      print(listDetailRuanganResponseModel.toJson());

      APIService apiService = new APIService();

      apiService.getListDetailRuangan().then((value) async {
        listDetailRuanganResponseModel = value;

        ruanganListSearch = value.data;
      });
    });
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
          'Tampil Ruangan',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'WorkSansMedium',
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
        label: Text('Segarkan',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                color: Colors.black)),
        backgroundColor: Colors.blue[200],
        icon: Icon(Icons.refresh_rounded, color: Colors.black),
        onPressed: () => {
          getListDetailRuangan(),
          Fluttertoast.showToast(
              msg: 'Menyegarkan...',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 14.0)
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      backgroundColor: Colors.grey[50],
      body: listDetailRuanganResponseModel.data == null
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
                            fontFamily: 'WorkSansMedium',
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : listDetailRuanganResponseModel.data.isEmpty
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
                                'Ruangan Kosong',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'WorkSansMedium',
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
                              hintText: 'Cari Ruangan',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            style: const TextStyle(
                                fontFamily: 'WorkSansSemiBold',
                                fontSize: 16.0,
                                color: Colors.black),
                            onChanged: (text) {
                              text = text.toLowerCase();
                              setState(() {
                                ruanganListSearch =
                                    listDetailRuanganResponseModel.data
                                        .where((ruang) {
                                  var namaRuang = ruang.ruang.toLowerCase();
                                  return namaRuang.contains(text);
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
                            itemCount: ruanganListSearch.length,
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
                                    title: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: new Text(
                                              'Ruang ${ruanganListSearch[index].ruang}',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'WorkSansMedium',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: new Text(
                                              'Fakultas ${ruanganListSearch[index].fakultas}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'WorkSansMedium',
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: new Text(
                                              'Prodi ${ruanganListSearch[index].prodi}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'WorkSansMedium',
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: new Text(
                                                  'Device : ${ruanganListSearch[index].namadevice}',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'WorkSansMedium',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: new Text(
                                                  'Jarak Minimal :  ${ruanganListSearch[index].jarak} m',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily:
                                                          'WorkSansMedium',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () async {},
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
    );
  }
}
