import 'dart:convert';

LoginDosenResponseModel responseModelFromJson(String str) =>
    LoginDosenResponseModel.fromJson(json.decode(str));

String responseModelToJson(LoginDosenResponseModel data) =>
    json.encode(data.toJson());

class LoginDosenResponseModel {
  final String error;
  final Data data;

  LoginDosenResponseModel({this.error, this.data});

  factory LoginDosenResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginDosenResponseModel(
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
      {this.npp,
      this.namadsn,
      this.password,
      this.kdstatusdsn,
      this.prodi,
      this.fakultas,
      this.token});

  final String npp;
  final String namadsn;
  final String password;
  final String kdstatusdsn;
  final String prodi;
  final String fakultas;
  final String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        npp: json["NPP"] == null ? null : json["NPP"],
        namadsn: json["NAMA_DOSEN_LENGKAP"] == null
            ? null
            : json["NAMA_DOSEN_LENGKAP"],
        password: json["PASSWORD"] == null ? null : json["PASSWORD"],
        kdstatusdsn:
            json["KD_STATUS_DOSEN"] == null ? null : json["KD_STATUS_DOSEN"],
        prodi: json["PRODI"] == null ? null : json["PRODI"],
        fakultas: json["FAKULTAS"] == null ? null : json["FAKULTAS"],
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toJson() => {
        "NPP": npp == null ? null : npp,
        "NAMA_DOSEN_LENGKAP": namadsn == null ? null : namadsn,
        "PASSWORD": password == null ? null : password,
        "KD_STATUS_DOSEN": kdstatusdsn == null ? null : kdstatusdsn,
        "PRODI": prodi == null ? null : prodi,
        "FAKULTAS": fakultas == null ? null : fakultas,
        "token": token == null ? null : token
      };
}

LoginDosenRequestModel requestModelFromJson(String str) =>
    LoginDosenRequestModel.fromJson(json.decode(str));
String requestModelToJson(LoginDosenRequestModel data) =>
    json.encode(data.toJson());

class LoginDosenRequestModel {
  String npp;
  String password;

  LoginDosenRequestModel({
    this.npp,
    this.password,
  });

  factory LoginDosenRequestModel.fromJson(Map<String, dynamic> json) =>
      LoginDosenRequestModel(
        npp: json["NPP"] == null ? null : json["NPP"],
        password: json["PASSWORD"] == null ? null : json["PASSWORD"],
      );

  Map<String, dynamic> toJson() => {
        "NPP": npp == null ? null : npp.trim(),
        "PASSWORD": password == null ? null : password.trim(),
      };
}
