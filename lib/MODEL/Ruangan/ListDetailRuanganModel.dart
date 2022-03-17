import 'dart:convert';

ListDetailRuanganResponseModel responseModelFromJson(String str) =>
    ListDetailRuanganResponseModel.fromJson(json.decode(str));

String responseModelToJson(ListDetailRuanganResponseModel data) =>
    json.encode(data.toJson());

class ListDetailRuanganResponseModel {
  final String error;
  List<Data> data;

  ListDetailRuanganResponseModel({this.error, this.data});

  String toString() =>
      'ListDetailRuanganResponseModel{error: $error, data: $data}';

  factory ListDetailRuanganResponseModel.fromJson(Map<String, dynamic> json) {
    var list = json["data"] as List;
    print(list.runtimeType);
    List<Data> dataList = list.map((i) => Data.fromJson(i)).toList();

    return ListDetailRuanganResponseModel(error: json["error"], data: dataList);
  }

  Map<String, dynamic> toJson() => {"error": error, "data": data};
}

class Data {
  final String ruang;
  final String fakultas;
  final String prodi;
  final String uuid;
  final String namadevice;
  final double jarak;

  Data({
    this.ruang,
    this.fakultas,
    this.prodi,
    this.uuid,
    this.namadevice,
    this.jarak,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ruang: json["RUANG"],
        fakultas: json["FAKULTAS"],
        prodi: json["PRODI"],
        uuid: json["PROXIMITY_UUID"],
        namadevice: json["NAMA_DEVICE"],
        jarak: ((json["JARAK_MIN_DEC"] as num) ?? 0.0).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "RUANG": ruang,
        "FAKULTAS": fakultas,
        "PRODI": prodi,
        "PROXIMITY_UUID": uuid,
        "NAMA_DEVICE": namadevice,
        "JARAK_MIN_DEC": jarak,
      };
}
