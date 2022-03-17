import 'dart:convert';

TampilPesertaKelasResponseModel responseModelFromJson(String str) =>
    TampilPesertaKelasResponseModel.fromJson(json.decode(str));

String responseModelToJson(TampilPesertaKelasResponseModel data) =>
    json.encode(data.toJson());

class TampilPesertaKelasResponseModel {
  final String error;
  List<Data> data;

  TampilPesertaKelasResponseModel({this.error, this.data});

  String toString() =>
      'TampilPesertaKelasResponseModel{error: $error, data: $data}';

  factory TampilPesertaKelasResponseModel.fromJson(Map<String, dynamic> json) {
    var list = json["data"] as List;
    print(list.runtimeType);
    List<Data> dataList = list.map((i) => Data.fromJson(i)).toList();

    return TampilPesertaKelasResponseModel(
        error: json["error"], data: dataList);
  }

  Map<String, dynamic> toJson() => {
        "error": error,
        "data": data,
      };
}

class Data {
  final String npm;
  final String namamhs;

  Data({this.npm, this.namamhs});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        npm: json["NPM"] as String,
        namamhs: json["NAMA_MHS"] as String,
      );

  Map<String, dynamic> toJson() => {
        "NPM": npm,
        "NAMA_MHS": namamhs,
      };
}

class TampilPesertaKelasRequestModel {
  int idkelas;

  TampilPesertaKelasRequestModel({this.idkelas});

  factory TampilPesertaKelasRequestModel.fromJson(Map<String, dynamic> json) =>
      TampilPesertaKelasRequestModel(
        idkelas: json["ID_KELAS"] == null ? null : json['ID_KELAS'] as int,
      );

  Map<String, dynamic> toJson() => {
        "ID_KELAS": idkelas?.toString() == null ? null : idkelas?.toString(),
      };
}
