class PresensiINDosenBukaPresensiRequestModel {
  int idkelas;
  int bukapresensi;
  int pertemuan;

  PresensiINDosenBukaPresensiRequestModel(
      {this.idkelas, this.bukapresensi, this.pertemuan});

  factory PresensiINDosenBukaPresensiRequestModel.fromJson(
          Map<String, dynamic> json) =>
      PresensiINDosenBukaPresensiRequestModel(
        idkelas: json["ID_KELAS"] == null ? null : json['ID_KELAS'] as int,
        bukapresensi: json["IS_BUKA_PRESENSI"] == null
            ? null
            : json['IS_BUKA_PRESENSI'] as int,
        pertemuan:
            json["PERTEMUAN_KE"] == null ? null : json['PERTEMUAN_KE'] as int,
      );

  Map<String, dynamic> toJson() => {
        "ID_KELAS": idkelas?.toString() == null ? null : idkelas?.toString(),
        "IS_BUKA_PRESENSI":
            bukapresensi?.toString() == null ? null : bukapresensi?.toString(),
        "PERTEMUAN_KE":
            pertemuan?.toString() == null ? null : pertemuan?.toString(),
      };
}
