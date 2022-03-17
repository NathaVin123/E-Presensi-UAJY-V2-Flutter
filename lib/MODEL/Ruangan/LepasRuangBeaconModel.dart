class LepasRuangBeaconRequestModel {
  String ruang;
  // String namadevice;

  LepasRuangBeaconRequestModel({this.ruang});

  factory LepasRuangBeaconRequestModel.fromJson(Map<String, dynamic> json) =>
      LepasRuangBeaconRequestModel(
        ruang: json["RUANG"] as String,
        // namadevice: json["NAMA_DEVICE"] as String,
      );

  Map<String, dynamic> toJson() => {
        "RUANG": ruang,
        // "NAMA_DEVICE": namadevice,
      };
}
