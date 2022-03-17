class PresensiINMahasiswaToKSIRequestModel {
  int idkelas;
  String npm;
  int pertemuan;
  // String tglin;

  PresensiINMahasiswaToKSIRequestModel({
    this.idkelas,
    this.npm,
    this.pertemuan,
    // this.tglin
  });

  factory PresensiINMahasiswaToKSIRequestModel.fromJson(
          Map<String, dynamic> json) =>
      PresensiINMahasiswaToKSIRequestModel(
        idkelas: json["ID_KELAS"] == null ? null : json['ID_KELAS'] as int,
        npm: json["NPM"] == null ? null : json['NPM'] as String,
        pertemuan: json["PERTEMUAN"] == null ? null : json['PERTEMUAN'] as int,
        // tglin: json["TGLIN"] == null ? null : json['TGLIN'] as String,
      );

  Map<String, dynamic> toJson() => {
        "ID_KELAS": idkelas?.toString() == null ? null : idkelas?.toString(),
        "NPM": npm,
        "PERTEMUAN":
            pertemuan?.toString() == null ? null : pertemuan?.toString(),
        // "TGLIN": tglin,
      };
}
