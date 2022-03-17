class TambahBeaconRequestModel {
  String uuid;
  String namadevice;
  String jarakmin;
  String major;
  String minor;

  TambahBeaconRequestModel(
      {this.uuid, this.namadevice, this.jarakmin, this.major, this.minor});

  factory TambahBeaconRequestModel.fromJson(Map<String, dynamic> json) =>
      TambahBeaconRequestModel(
        uuid: json["UUID"] as String,
        namadevice: json["NAMA_DEVICE"] as String,
        jarakmin: json["JARAK_MIN"] as String,
        major: json["MAJOR"] as String,
        minor: json["MINOR"] as String,
      );

  Map<String, dynamic> toJson() => {
        "UUID": uuid,
        "NAMA_DEVICE": namadevice,
        "JARAK_MIN": jarakmin,
        "MAJOR": major,
        "MINOR": minor,
      };
}
