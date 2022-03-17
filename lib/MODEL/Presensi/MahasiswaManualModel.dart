import 'dart:convert';

MahasiswaManualResponseModel responseModelFromJson(String str) =>
    MahasiswaManualResponseModel.fromJson(json.decode(str));

String responseModelToJson(MahasiswaManualResponseModel data) =>
    json.encode(data.toJson());

class MahasiswaManualResponseModel {
  final String error;
  List<Data> data;

  MahasiswaManualResponseModel({this.error, this.data});

  String toString() =>
      'MahasiswaManualResponseModel{error: $error, data: $data}';

  factory MahasiswaManualResponseModel.fromJson(Map<String, dynamic> json) {
    var list = json["data"] as List;
    print(list.runtimeType);
    List<Data> dataList = list.map((i) => Data.fromJson(i)).toList();

    return MahasiswaManualResponseModel(error: json["error"], data: dataList);
  }

  Map<String, dynamic> toJson() => {
        "error": error,
        "data": data,
      };
}

class Data {
  final String status;

  Data({this.status});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["STATUS"] as String,
      );

  Map<String, dynamic> toJson() => {
        "STATUS": status,
      };
}

class MahasiswaManualRequestModel {
  int idkelas;
  int pertemuan;
  String npm;

  MahasiswaManualRequestModel({this.idkelas, this.pertemuan, this.npm});

  factory MahasiswaManualRequestModel.fromJson(Map<String, dynamic> json) =>
      MahasiswaManualRequestModel(
        idkelas: json["ID_KELAS"] == null ? null : json['ID_KELAS'] as int,
        pertemuan:
            json["PERTEMUAN_KE"] == null ? null : json['PERTEMUAN_KE'] as int,
        npm: json["NPM"] == null ? null : json['NPM'] as String,
      );

  Map<String, dynamic> toJson() => {
        "ID_KELAS": idkelas?.toString() == null ? null : idkelas?.toString(),
        "PERTEMUAN_KE":
            pertemuan?.toString() == null ? null : pertemuan?.toString(),
        "NPM": npm?.toString() == null ? null : npm?.toString(),
      };
}
