import 'dart:convert';

ListDetailRuanganNamaDeviceResponseModel responseModelFromJson(String str) =>
    ListDetailRuanganNamaDeviceResponseModel.fromJson(json.decode(str));

String responseModelToJson(ListDetailRuanganNamaDeviceResponseModel data) =>
    json.encode(data.toJson());

class ListDetailRuanganNamaDeviceResponseModel {
  final String error;
  final Data data;

  ListDetailRuanganNamaDeviceResponseModel({this.error, this.data});

  factory ListDetailRuanganNamaDeviceResponseModel.fromJson(
          Map<String, dynamic> json) =>
      ListDetailRuanganNamaDeviceResponseModel(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "data": data == null ? null : data.toJson(),
      };
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  String namadevice;

  Data({this.namadevice});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(namadevice: json["NAMA_DEVICE"]);

  Map<String, dynamic> toJson() => {
        "NAMA_DEVICE": namadevice,
      };
}

class ListDetailRuanganNamaDeviceRequestModel {
  String ruang;

  ListDetailRuanganNamaDeviceRequestModel({this.ruang});

  factory ListDetailRuanganNamaDeviceRequestModel.fromJson(
          Map<String, dynamic> json) =>
      ListDetailRuanganNamaDeviceRequestModel(
        ruang: json["RUANG"] as String,
      );

  Map<String, dynamic> toJson() => {
        "RUANG": ruang,
      };
}
