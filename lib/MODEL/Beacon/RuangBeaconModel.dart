import 'dart:convert';

RuangBeaconResponseModel responseModelFromJson(String str) =>
    RuangBeaconResponseModel.fromJson(json.decode(str));

String responseModelToJson(RuangBeaconResponseModel data) =>
    json.encode(data.toJson());

class RuangBeaconResponseModel {
  final String error;
  List<Data> data;

  RuangBeaconResponseModel({this.error, this.data});

  factory RuangBeaconResponseModel.fromJson(Map<String, dynamic> json) =>
      RuangBeaconResponseModel(
        error: json["error"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        // data: json["data"]
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        // "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "data": data == null
      };
}

class Data {
  final String namamk;
  final String namadosen;
  final String hari;
  final String sesi;
  final String ruang;
  final String uuid;

  Data(
      {this.namamk,
      this.namadosen,
      this.hari,
      this.sesi,
      this.ruang,
      this.uuid});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        namamk: json["NAMA_MK"],
        namadosen: json["NAMA_DOSEN_LENGKAP"],
        hari: json["HARI"],
        sesi: json["SESI"],
        ruang: json["RUANG"],
        uuid: json["PROXIMITY_UUID"],
      );

  Map<String, dynamic> toJson() => {
        "NAMA_MK": namamk,
        "NAMA_DOSEN_LENGKAP": namadosen,
        "HARI": hari,
        "SESI": sesi,
        "RUANG": ruang,
        "PROXIMITY_UUID": uuid
      };
}
