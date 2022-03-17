import 'dart:convert';

ListBeaconResponseModel responseModelFromJson(String str) =>
    ListBeaconResponseModel.fromJson(json.decode(str));

String responseModelToJson(ListBeaconResponseModel data) =>
    json.encode(data.toJson());

class ListBeaconResponseModel {
  final String error;
  List<Data> data;

  ListBeaconResponseModel({this.error, this.data});

  String toString() =>
      'ListKelasMahasiswaResponseModel{error: $error, data: $data}';

  factory ListBeaconResponseModel.fromJson(Map<String, dynamic> json) {
    var list = json["data"] as List;
    print(list.runtimeType);
    List<Data> dataList = list.map((i) => Data.fromJson(i)).toList();

    return ListBeaconResponseModel(error: json["error"], data: dataList);
  }

  Map<String, dynamic> toJson() => {"error": error, "data": data};
}

class Data {
  final String uuid;
  final String namadevice;
  final double jarakmin;
  final int major;
  final int minor;
  // final int status;

  Data(
      {this.uuid,
      this.namadevice,
      this.jarakmin,
      // this.status,
      this.major,
      this.minor});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        uuid: json["PROXIMITY_UUID"] == null
            ? null
            : json['PROXIMITY_UUID'] as String,
        namadevice:
            json["NAMA_DEVICE"] == null ? null : json['NAMA_DEVICE'] as String,
        jarakmin: ((json["JARAK_MIN_DEC"] as num) ?? 0.0).toDouble(),
        // status: json["STATUS"] == null ? null : json['STATUS'] as int,
        major: json["MAJOR"] == null ? null : json['MAJOR'] as int,
        minor: json["MINOR"] == null ? null : json['MINOR'] as int,
      );

  Map<String, dynamic> toJson() => {
        "PROXIMITY_UUID": uuid,
        "NAMA_DEVICE": namadevice,
        "JARAK_MIN_DEC": jarakmin,
        // "STATUS": status,
        "MAJOR": major,
        "MINOR": minor,
      };
}
