class HapusBeaconRequestModel {
  String uuid;
  String status;

  HapusBeaconRequestModel({
    this.uuid,
    this.status
  });

  factory HapusBeaconRequestModel.fromJson(Map<String, dynamic> json) =>
      HapusBeaconRequestModel(
        uuid: json["UUID"] as String,
        status: json["STATUS"] as String,
      );

  Map<String, dynamic> toJson() => {
        "UUID": uuid,
        "STATUS": status,
      };
}
