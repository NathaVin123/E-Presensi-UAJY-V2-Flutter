class PresensiINOUTOUTDosenBukaPresensiRequestModel {
  int idkelas;
  int pertemuan;

  // String jamkeluar;
  String keterangan;
  String materi;

  PresensiINOUTOUTDosenBukaPresensiRequestModel(
      {this.idkelas,
      this.pertemuan,
      // this.jamkeluar,
      this.keterangan,
      this.materi});

  factory PresensiINOUTOUTDosenBukaPresensiRequestModel.fromJson(
          Map<String, dynamic> json) =>
      PresensiINOUTOUTDosenBukaPresensiRequestModel(
        idkelas: json["ID_KELAS"] == null ? null : json['ID_KELAS'] as int,
        pertemuan:
            json["PERTEMUAN_KE"] == null ? null : json['PERTEMUAN_KE'] as int,
        // jamkeluar:
        //     json["JAM_KELUAR"] == null ? null : json['JAM_KELUAR'] as String,
        keterangan:
            json["KETERANGAN"] == null ? null : json['KETERANGAN'] as String,
        materi: json["MATERI"] == null ? null : json['MATERI'] as String,
      );

  Map<String, dynamic> toJson() => {
        "ID_KELAS": idkelas?.toString() == null ? null : idkelas?.toString(),
        "PERTEMUAN_KE":
            pertemuan?.toString() == null ? null : pertemuan?.toString(),
        // "JAM_KELUAR": jamkeluar,
        "KETERANGAN": keterangan,
        "MATERI": materi,
      };
}
