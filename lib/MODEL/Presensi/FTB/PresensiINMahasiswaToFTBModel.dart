class PresensiINMahasiswaToFTBRequestModel {
  String idkelas;
  String npm;
  int pertemuan;
  // String tglin;

  PresensiINMahasiswaToFTBRequestModel(
      {this.idkelas, this.npm, this.pertemuan, 
      // this.tglin
      });

  factory PresensiINMahasiswaToFTBRequestModel.fromJson(
          Map<String, dynamic> json) =>
      PresensiINMahasiswaToFTBRequestModel(
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
