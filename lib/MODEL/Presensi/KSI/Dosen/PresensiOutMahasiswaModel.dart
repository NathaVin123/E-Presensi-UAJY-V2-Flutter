class PresensiOUTMahasiswaRequestModel {
  int idkelas;

  int pertemuan;

  PresensiOUTMahasiswaRequestModel({this.idkelas, this.pertemuan});

  factory PresensiOUTMahasiswaRequestModel.fromJson(
          Map<String, dynamic> json) =>
      PresensiOUTMahasiswaRequestModel(
        idkelas: json["ID_KELAS"] == null ? null : json['ID_KELAS'] as int,
        pertemuan:
            json["PERTEMUAN_KE"] == null ? null : json['PERTEMUAN_KE'] as int,
      );

  Map<String, dynamic> toJson() => {
        "ID_KELAS": idkelas?.toString() == null ? null : idkelas?.toString(),
        "PERTEMUAN_KE":
            pertemuan?.toString() == null ? null : pertemuan?.toString(),
      };
}
