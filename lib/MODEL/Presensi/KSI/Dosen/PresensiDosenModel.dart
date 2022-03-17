class PresensiDosenRequestModel {
  int idkelas;
  int pertemuan;
  String keterangan;
  String materi;

  PresensiDosenRequestModel(
      {this.idkelas, this.pertemuan, this.keterangan, this.materi});

  factory PresensiDosenRequestModel.fromJson(Map<String, dynamic> json) =>
      PresensiDosenRequestModel(
        idkelas: json["ID_KELAS"] == null ? null : json['ID_KELAS'] as int,
        pertemuan:
            json["PERTEMUAN_KE"] == null ? null : json['PERTEMUAN_KE'] as int,
        keterangan:
            json["KETERANGAN"] == null ? null : json['KETERANGAN'] as String,
        materi: json["MATERI"] == null ? null : json['MATERI'] as String,
      );

  Map<String, dynamic> toJson() => {
        "ID_KELAS": idkelas?.toString() == null ? null : idkelas?.toString(),
        "PERTEMUAN_KE":
            pertemuan?.toString() == null ? null : pertemuan?.toString(),
        "KETERANGAN": keterangan,
        "MATERI": materi,
      };
}
