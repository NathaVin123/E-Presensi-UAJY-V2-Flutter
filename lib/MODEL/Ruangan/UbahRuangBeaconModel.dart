class UbahRuangBeaconRequestModel {
  String ruang;
  String namadevice;

  UbahRuangBeaconRequestModel({this.ruang, this.namadevice});

  factory UbahRuangBeaconRequestModel.fromJson(Map<String, dynamic> json) =>
      UbahRuangBeaconRequestModel(
        ruang: json["RUANG"] as String,
        namadevice: json["NAMA_DEVICE"] as String,
      );

  Map<String, dynamic> toJson() => {
        "RUANG": ruang,
        "NAMA_DEVICE": namadevice,
      };
}
