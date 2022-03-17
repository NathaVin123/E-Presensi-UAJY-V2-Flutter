class PresensiINMahasiswaToFBERequestModel {
  String idkelas;
  String npm;
  int pertemuan;
  // String tglin;

  PresensiINMahasiswaToFBERequestModel({
    this.idkelas,
    this.npm,
    this.pertemuan,
    // this.tglin
  });

  factory PresensiINMahasiswaToFBERequestModel.fromJson(
          Map<String, dynamic> json) =>
      PresensiINMahasiswaToFBERequestModel(
        idkelas: json["ID_KELAS"] == null ? null : json['ID_KELAS'] as String,
        npm: json["NPM"] == null ? null : json['NPM'] as String,
        pertemuan: json["PERTEMUAN"] == null ? null : json['PERTEMUAN'] as int,
        // tglin: json["TGLIN"] == null ? null : json['TGLIN'] as String,
      );

  Map<String, dynamic> toJson() => {
        "ID_KELAS": idkelas,
        "NPM": npm,
        "PERTEMUAN":
            pertemuan?.toString() == null ? null : pertemuan?.toString(),
        // "TGLIN": tglin,
      };
}
