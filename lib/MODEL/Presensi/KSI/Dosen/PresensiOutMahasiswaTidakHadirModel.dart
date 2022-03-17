class PresensiOUTMahasiswaTidakHadirRequestModel {
  int idkelas;

  int pertemuan;

  PresensiOUTMahasiswaTidakHadirRequestModel({this.idkelas, this.pertemuan});

  factory PresensiOUTMahasiswaTidakHadirRequestModel.fromJson(
          Map<String, dynamic> json) =>
      PresensiOUTMahasiswaTidakHadirRequestModel(
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
