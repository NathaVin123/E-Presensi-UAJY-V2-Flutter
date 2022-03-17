import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:presensiblebeacon/API/APIService.dart';
import 'package:presensiblebeacon/MODEL/Ruangan/LepasRuangBeaconModel.dart';
import 'package:presensiblebeacon/MODEL/Ruangan/ListDetailRuanganModel.dart';
// import 'package:presensiblebeacon/MODEL/Ruangan/UbahRuangBeaconModel.dart';
import 'package:sk_alert_dialog/sk_alert_dialog.dart';

class AdminHapusRuanganPage extends StatefulWidget {
  @override
  _AdminHapusRuanganPageState createState() => _AdminHapusRuanganPageState();
}

class _AdminHapusRuanganPageState extends State<AdminHapusRuanganPage>
    with WidgetsBindingObserver {
  ListDetailRuanganResponseModel listDetailRuanganResponseModel;

  LepasRuangBeaconRequestModel lepasRuangBeaconRequestModel;

  List<Data> ruanganListSearch = List<Data>();

  bool isApiCallProcess = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    lepasRuangBeaconRequestModel = LepasRuangBeaconRequestModel();

    listDetailRuanganResponseModel = ListDetailRuanganResponseModel();

    Timer.periodic(Duration(seconds: 2), (Timer t) {
      getListRuangan();
      Future.delayed(Duration(seconds: 5), () {
        t.cancel();
      });
    });
  }

  void getListRuangan() async {
    setState(() {
      print(listDetailRuanganResponseModel.toJson());

      APIService apiService = new APIService();

      apiService.getListDetailRuangan().then((value) async {
        listDetailRuanganResponseModel = value;

        ruanganListSearch = listDetailRuanganResponseModel.data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue[100],
        centerTitle: true,
        title: Text(
          'Hapus Perangkat Ruangan',
          style: TextStyle(
              color: Colors.white,
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
      floatingActionButton: FloatingActionButton(
        // onPressed: () => {_streamRanging?.resume(), getDataRuangBeacon()},
        onPressed: () => {
          getListRuangan(),
          Fluttertoast.showToast(
              msg: 'Menyegarkan...',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 14.0)
        },

        child: Icon(Icons.refresh_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      backgroundColor: Color.fromRGBO(23, 75, 137, 1),
      body: listDetailRuanganResponseModel.data == null
          ? Container(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        color: Colors.white,
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
                            color: Colors.white),
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
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(25)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Cari Ruangan',
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
                      child: ListView.builder(
                          // itemCount: listDetailRuanganResponseModel.data?.length,
                          itemCount: ruanganListSearch.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 8, bottom: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
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
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(4.0),
                                        //   child: new Text(
                                        //     'Fakultas ${ruanganListSearch[index].fakultas}',
                                        //     style: TextStyle(
                                        //       fontSize: 16,
                                        //       fontFamily: 'OpenSans',
                                        //     ),
                                        //   ),
                                        // ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(4.0),
                                        //   child: new Text(
                                        //     'Prodi ${ruanganListSearch[index].prodi}',
                                        //     style: TextStyle(
                                        //       fontSize: 16,
                                        //       fontFamily: 'OpenSans',
                                        //     ),
                                        //   ),
                                        // ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: new Text(
                                                'Nama Device : ${ruanganListSearch[index].namadevice}',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'OpenSans',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: new Text(
                                                'Jarak : ${ruanganListSearch[index].jarak}',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'OpenSans',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),

                                        MaterialButton(
                                            color: Colors.red,
                                            shape: StadiumBorder(),
                                            padding: EdgeInsets.all(15),
                                            child: Text(
                                              "Hapus Perangkat",
                                              style: const TextStyle(
                                                  fontFamily: 'OpenSans',
                                                  fontSize: 14.0,
                                                  color: Colors.white),
                                            ),
                                            onPressed: () => {
                                                  SKAlertDialog.show(
                                                    context: context,
                                                    type: SKAlertType.buttons,
                                                    title: 'Hapus ?',
                                                    message:
                                                        'Apakah anda yakin\ningin menghapus perangkat\ndari ruangan ini ?',
                                                    okBtnText: 'Ya',
                                                    okBtnTxtColor: Colors.white,
                                                    okBtnColor: Colors.red,
                                                    cancelBtnText: 'Tidak',
                                                    cancelBtnTxtColor:
                                                        Colors.white,
                                                    cancelBtnColor: Colors.grey,
                                                    onOkBtnTap: (value) async {
                                                      print(
                                                          lepasRuangBeaconRequestModel
                                                              .toJson());

                                                      setState(() {
                                                        isApiCallProcess = true;

                                                        lepasRuangBeaconRequestModel
                                                                .ruang =
                                                            ruanganListSearch[
                                                                    index]
                                                                .ruang;
                                                      });

                                                      APIService apiService =
                                                          new APIService();

                                                      apiService
                                                          .putLepasRuangBeacon(
                                                              lepasRuangBeaconRequestModel)
                                                          .then((value) async {
                                                        if (value != null) {
                                                          setState(() {
                                                            isApiCallProcess =
                                                                false;
                                                          });
                                                        }
                                                        Get.back();

                                                        await Fluttertoast.showToast(
                                                            msg:
                                                                'Berhasil menghapus perangkat beacon dari ruangan',
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 14.0);
                                                      });
                                                    },
                                                    onCancelBtnTap: (value) {},
                                                  )
                                                }),
                                      ],
                                    ),
                                  ),
                                  // onTap: () async {
                                  //   // Get.toNamed('/admin/menu/ruangan/detail');

                                  //   SKAlertDialog.show(
                                  //     context: context,
                                  //     type: SKAlertType.buttons,
                                  //     title: 'Hapus ?',
                                  //     message:
                                  //         'Apakah anda yakin\ningin menghapus perangkat\ndari ruangan ini ?',
                                  //     okBtnText: 'Ya',
                                  //     okBtnTxtColor: Colors.white,
                                  //     okBtnColor: Colors.red,
                                  //     cancelBtnText: 'Tidak',
                                  //     cancelBtnTxtColor: Colors.white,
                                  //     cancelBtnColor: Colors.grey,
                                  //     onOkBtnTap: (value) async {
                                  //       print(lepasRuangBeaconRequestModel.toJson());

                                  //       setState(() {
                                  //         isApiCallProcess = true;

                                  //         lepasRuangBeaconRequestModel.ruang =
                                  //             ruanganListSearch[index].ruang;

                                  //         lepasRuangBeaconRequestModel.namadevice =
                                  //             "";
                                  //       });

                                  //       APIService apiService = new APIService();

                                  //       apiService
                                  //           .putLepasRuangBeacon(
                                  //               lepasRuangBeaconRequestModel)
                                  //           .then((value) async {
                                  //         if (value != null) {
                                  //           setState(() {
                                  //             isApiCallProcess = false;
                                  //           });
                                  //         }
                                  //         Get.back();

                                  //         await Fluttertoast.showToast(
                                  //             msg:
                                  //                 'Berhasil menghapus perangkat beacon dari ruangan',
                                  //             toastLength: Toast.LENGTH_SHORT,
                                  //             gravity: ToastGravity.BOTTOM,
                                  //             timeInSecForIosWeb: 1,
                                  //             backgroundColor: Colors.red,
                                  //             textColor: Colors.white,
                                  //             fontSize: 14.0);
                                  //       });
                                  //     },
                                  //     onCancelBtnTap: (value) {},
                                  //   );

                                  //   // SharedPreferences saveRuangan =
                                  //   //     await SharedPreferences.getInstance();

                                  //   // await saveRuangan.setString(
                                  //   //     'ruang', ruanganListSearch[index].ruang);
                                  //   // await saveRuangan.setString(
                                  //   //     'fakultas',
                                  //   //     listDetailRuanganResponseModel
                                  //   //         .data[index].fakultas);
                                  //   // await saveRuangan.setString(
                                  //   //     'prodi', ruanganListSearch[index].prodi);
                                  // },
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
      //     )
      //   ],
      // ),
    );
  }
}
