class PresensiINOUTDosenBukaPresensiRequestModel {
  int idkelas;
  int pertemuan;
  // String jammasuk;

  PresensiINOUTDosenBukaPresensiRequestModel({
    this.idkelas,
    this.pertemuan,
    // this.jammasuk,
  });

  factory PresensiINOUTDosenBukaPresensiRequestModel.fromJson(
          Map<String, dynamic> json) =>
      PresensiINOUTDosenBukaPresensiRequestModel(
        idkelas: json["ID_KELAS"] == null ? null : json['ID_KELAS'] as int,
        pertemuan:
            json["PERTEMUAN_KE"] == null ? null : json['PERTEMUAN_KE'] as int,
        // jammasuk:
        //     json["JAM_MASUK"] == null ? null : json['JAM_MASUK'] as String,
      );

  Map<String, dynamic> toJson() => {
        "ID_KELAS": idkelas?.toString() == null ? null : idkelas?.toString(),
        "PERTEMUAN_KE":
            pertemuan?.toString() == null ? null : pertemuan?.toString(),
        // "JAM_MASUK": jammasuk,
      };
}
