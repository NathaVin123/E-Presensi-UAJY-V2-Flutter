import 'dart:convert';

TampilKehadiranPesertaKelasResponseModel responseModelFromJson(String str) =>
    TampilKehadiranPesertaKelasResponseModel.fromJson(json.decode(str));

String responseModelToJson(TampilKehadiranPesertaKelasResponseModel data) =>
    json.encode(data.toJson());

class TampilKehadiranPesertaKelasResponseModel {
  final String error;
  List<Data> data;

  TampilKehadiranPesertaKelasResponseModel({this.error, this.data});

  String toString() =>
      'TampilKehadiranPesertaKelasResponseModel{error: $error, data: $data}';

  factory TampilKehadiranPesertaKelasResponseModel.fromJson(
      Map<String, dynamic> json) {
    var list = json["data"] as List;
    print(list.runtimeType);
    List<Data> dataList = list.map((i) => Data.fromJson(i)).toList();

    return TampilKehadiranPesertaKelasResponseModel(
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
  final String status;
  final String jammasuk;
  final String jamkeluar;

  Data({this.npm, this.namamhs, this.status, this.jammasuk, this.jamkeluar});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        npm: json["NPM"] as String,
        namamhs: json["NAMA_MHS"] as String,
        status: json["STATUS"] as String,
        jammasuk: json["JAM_MASUK"] as String,
        jamkeluar: json["JAM_KELUAR"] as String,
      );

  Map<String, dynamic> toJson() => {
        "NPM": npm,
        "NAMA_MHS": namamhs,
        "STATUS": status,
        "JAM_MASUK": jammasuk,
        "JAM_KELUAR": jamkeluar,
      };
}

class TampilKehadiranPesertaKelasRequestModel {
  int idkelas;
  int pertemuan;

  TampilKehadiranPesertaKelasRequestModel({this.idkelas, this.pertemuan});

  factory TampilKehadiranPesertaKelasRequestModel.fromJson(
          Map<String, dynamic> json) =>
      TampilKehadiranPesertaKelasRequestModel(
        idkelas: json["ID_KELAS"] == null ? null : json['ID_KELAS'] as int,
        pertemuan:
            json["PERTEMUAN_KE"] == null ? null : json['PERTEMUAN_KE'] as int,
      );

  Map<String, dynamic> toJson() => {
        "ID_KELAS": idkelas?.toString() == null ? null : idkelas?.toString(),
        "PERTEMUAN_KE":
            pertemuan?.toString() == null ? null : pertemuan?.toString(),
      };
}
