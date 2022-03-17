import 'dart:convert';

LoginMahasiswaResponseModel responseModelFromJson(String str) =>
    LoginMahasiswaResponseModel.fromJson(json.decode(str));

String responseModelToJson(LoginMahasiswaResponseModel data) =>
    json.encode(data.toJson());

class LoginMahasiswaResponseModel {
  final String error;
  final Data data;

  LoginMahasiswaResponseModel({this.error, this.data});

  factory LoginMahasiswaResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginMahasiswaResponseModel(
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
  Data(
      {this.npm,
      this.namamhs,
      this.password,
      this.kdstatusmhs,
      this.prodi,
      this.fakultas,
      this.token});

  final String npm;
  final String namamhs;
  final String password;
  final String kdstatusmhs;
  final String prodi;
  final String fakultas;

  final String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        npm: json["NPM"] == null ? null : json["NPM"],
        namamhs: json["NAMA_MHS"] == null ? null : json["NAMA_MHS"],
        password: json["PASSWORD"] == null ? null : json["PASSWORD"],
        kdstatusmhs:
            json["KD_STATUS_MHS"] == null ? null : json["KD_STATUS_MHS"],
        prodi: json["PRODI"] == null ? null : json["PRODI"],
        fakultas: json["FAKULTAS"] == null ? null : json["FAKULTAS"],
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toJson() => {
        "NPM": npm == null ? null : npm,
        "NAMA_MHS": namamhs == null ? null : namamhs,
        "PASSWORD": password == null ? null : password,
        "KD_STATUS_MHS": kdstatusmhs == null ? null : kdstatusmhs,
        "PRODI": prodi == null ? null : prodi,
        "FAKULTAS": fakultas == null ? null : fakultas,
        "token": token == null ? null : token
      };
}

LoginMahasiswaRequestModel requestModelFromJson(String str) =>
    LoginMahasiswaRequestModel.fromJson(json.decode(str));
String requestModelToJson(LoginMahasiswaRequestModel data) =>
    json.encode(data.toJson());

class LoginMahasiswaRequestModel {
  String npm;
  String password;

  LoginMahasiswaRequestModel({
    this.npm,
    this.password,
  });

  factory LoginMahasiswaRequestModel.fromJson(Map<String, dynamic> json) =>
      LoginMahasiswaRequestModel(
        npm: json["NPM"] == null ? null : json["NPM"],
        password: json["PASSWORD"] == null ? null : json["PASSWORD"],
      );

  Map<String, dynamic> toJson() => {
        "NPM": npm == null ? null : npm.trim(),
        "PASSWORD": password == null ? null : password.trim(),
      };
}
