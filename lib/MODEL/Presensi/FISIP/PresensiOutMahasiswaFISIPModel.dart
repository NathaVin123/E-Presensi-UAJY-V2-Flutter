class PresensiOUTMahasiswaFISIPRequestModel {
  String idkelas;

  int pertemuan;

  PresensiOUTMahasiswaFISIPRequestModel({this.idkelas, this.pertemuan});

  factory PresensiOUTMahasiswaFISIPRequestModel.fromJson(
          Map<String, dynamic> json) =>
      PresensiOUTMahasiswaFISIPRequestModel(
        idkelas: json["ID_KELAS"] == null ? null : json['ID_KELAS'] as String,
        pertemuan:
            json["PERTEMUAN_KE"] == null ? null : json['PERTEMUAN_KE'] as int,
      );

  Map<String, dynamic> toJson() => {
        "ID_KELAS": idkelas,
        "PERTEMUAN_KE":
            pertemuan?.toString() == null ? null : pertemuan?.toString(),
      };
}
