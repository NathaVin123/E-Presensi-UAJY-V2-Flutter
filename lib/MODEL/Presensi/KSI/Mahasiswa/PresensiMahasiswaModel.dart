class PresensiMahasiswaRequestModel {
  int idkelas;
  String npm;
  int pertemuan;
  // String tglin;
  // String tglout;
  // String status;

  PresensiMahasiswaRequestModel({
    this.idkelas,
    this.npm,
    this.pertemuan,
    // this.tglin,
    // this.tglout,
    // this.status
  });

  factory PresensiMahasiswaRequestModel.fromJson(Map<String, dynamic> json) =>
      PresensiMahasiswaRequestModel(
        idkelas: json["ID_KELAS"] == null ? null : json['ID_KELAS'] as int,
        npm: json["NPM"] == null ? null : json['NPM'] as String,
        pertemuan: json["PERTEMUAN"] == null ? null : json['PERTEMUAN'] as int,
        // tglin: json["TGLIN"] == null ? null : json['TGLIN'] as String,
        // tglout: json["TGLOUT"] == null ? null : json['TGLOUT'] as String,
        // status: json["STATUS"] == null ? null : json['STATUS'] as String
      );

  Map<String, dynamic> toJson() => {
        "ID_KELAS": idkelas?.toString() == null ? null : idkelas?.toString(),
        "NPM": npm,
        "PERTEMUAN":
            pertemuan?.toString() == null ? null : pertemuan?.toString(),
        // "TGLIN": tglin,
        // "TGLOUT": tglout,
        // "STATUS": status
      };
}

class PresensiMahasiswaFakultasRequestModel {
  String idkelas;
  String npm;
  int pertemuan;
  // String tglin;
  // String tglout;
  // String status;

  PresensiMahasiswaFakultasRequestModel({
    this.idkelas,
    this.npm,
    this.pertemuan,
    // this.tglin,
    // this.tglout,
    // this.status
  });

  factory PresensiMahasiswaFakultasRequestModel.fromJson(
          Map<String, dynamic> json) =>
      PresensiMahasiswaFakultasRequestModel(
        idkelas: json["ID_KELAS"] == null ? null : json['ID_KELAS'] as String,
        npm: json["NPM"] == null ? null : json['NPM'] as String,
        pertemuan: json["PERTEMUAN"] == null ? null : json['PERTEMUAN'] as int,
        // tglin: json["TGLIN"] == null ? null : json['TGLIN'] as String,
        // tglout: json["TGLOUT"] == null ? null : json['TGLOUT'] as String,
        // status: json["STATUS"] == null ? null : json['STATUS'] as String
      );

  Map<String, dynamic> toJson() => {
        "ID_KELAS": idkelas,
        "NPM": npm,
        "PERTEMUAN":
            pertemuan?.toString() == null ? null : pertemuan?.toString(),
        // "TGLIN": tglin,
        // "TGLOUT": tglout,
        // "STATUS": status
      };
}
