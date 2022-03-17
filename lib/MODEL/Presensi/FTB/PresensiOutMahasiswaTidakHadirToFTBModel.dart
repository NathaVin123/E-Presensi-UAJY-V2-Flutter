class PresensiOUTMahasiswaTidakHadirFTBRequestModel {
  int idkelas;

  String idkelasfakultas;

  int pertemuan;

  PresensiOUTMahasiswaTidakHadirFTBRequestModel(
      {this.idkelas, this.idkelasfakultas, this.pertemuan});

  factory PresensiOUTMahasiswaTidakHadirFTBRequestModel.fromJson(
          Map<String, dynamic> json) =>
      PresensiOUTMahasiswaTidakHadirFTBRequestModel(
        idkelas: json["ID_KELAS"] == null ? null : json['ID_KELAS'] as int,
        idkelasfakultas: json["ID_KELAS_FAKULTAS"] == null
            ? null
            : json['ID_KELAS_FAKULTAS'] as String,
        pertemuan:
            json["PERTEMUAN_KE"] == null ? null : json['PERTEMUAN_KE'] as int,
      );

  Map<String, dynamic> toJson() => {
        "ID_KELAS": idkelas?.toString() == null ? null : idkelas?.toString(),
        "ID_KELAS_FAKULTAS": idkelasfakultas,
        "PERTEMUAN_KE":
            pertemuan?.toString() == null ? null : pertemuan?.toString(),
      };
}
