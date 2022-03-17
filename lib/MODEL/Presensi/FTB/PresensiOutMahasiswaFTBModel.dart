class PresensiOUTMahasiswaFTBRequestModel {
  String idkelas;

  int pertemuan;

  PresensiOUTMahasiswaFTBRequestModel({this.idkelas, this.pertemuan});

  factory PresensiOUTMahasiswaFTBRequestModel.fromJson(
          Map<String, dynamic> json) =>
      PresensiOUTMahasiswaFTBRequestModel(
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
