import 'dart:convert';

LoginAdminResponseModel responseModelFromJson(String str) =>
    LoginAdminResponseModel.fromJson(json.decode(str));

String responseModelToJson(LoginAdminResponseModel data) =>
    json.encode(data.toJson());

class LoginAdminResponseModel {
  final String error;
  final Data data;

  LoginAdminResponseModel({this.error, this.data});

  factory LoginAdminResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginAdminResponseModel(
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
  Data({this.npp, this.namaadm, this.token});

  final String npp;
  final String namaadm;
  // final String password;
  final String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        npp: json["NPP"] == null ? null : json["NPP"],
        namaadm: json["NAMA_LENGKAP_GELAR"] == null
            ? null
            : json["NAMA_LENGKAP_GELAR"],
        // password: json["PASSWORD"] == null ? null : json["PASSWORD"],
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toJson() => {
        "NPP": npp == null ? null : npp,
        "NAMA_LENGKAP_GELAR": namaadm == null ? null : namaadm,
        // "PASSWORD": password == null ? null : password,
        "token": token == null ? null : token
      };
}

LoginAdminRequestModel requestModelFromJson(String str) =>
    LoginAdminRequestModel.fromJson(json.decode(str));
String requestModelToJson(LoginAdminRequestModel data) =>
    json.encode(data.toJson());

class LoginAdminRequestModel {
  String npp;
  String password;

  LoginAdminRequestModel({
    this.npp,
    this.password,
  });

  factory LoginAdminRequestModel.fromJson(Map<String, dynamic> json) =>
      LoginAdminRequestModel(
        npp: json["NPP"] == null ? null : json["NPP"],
        password: json["PASSWORD"] == null ? null : json["PASSWORD"],
      );

  Map<String, dynamic> toJson() => {
        "NPP": npp == null ? null : npp.trim(),
        "PASSWORD": password == null ? null : password.trim(),
      };
}
