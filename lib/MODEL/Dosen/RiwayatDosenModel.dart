class RiwayatDosenResponseModel {
  final String error;
  List<Data> data;

  RiwayatDosenResponseModel({this.error, this.data});

  String toString() => 'RiwayatDosenResponseModel{error: $error, data: $data}';

  factory RiwayatDosenResponseModel.fromJson(Map<String, dynamic> json) {
    var list = json["data"] as List;
    print(list.runtimeType);
    List<Data> dataList = list.map((i) => Data.fromJson(i)).toList();

    return RiwayatDosenResponseModel(error: json["error"], data: dataList);
  }
  Map<String, dynamic> toJson() => {
        "error": error,
        "data": data,
      };
}

class Data {
  final int idkelas;
  final String namamk;
  final String kelas;
  final String nppdosen1;
  final String namadosen1;

  final String hari1;

  final String sesi1;

  final int sks;
  final int pertemuan;
  final String materi;
  final String keterangan;
  final String jammasukdosen;
  final String jamkeluardosen;
  final String ruang;
  final int kapasitas;
  final String tglmasuk;
  final String tglkeluar;
  final String jammasuk;
  final String jamkeluar;
  final int hadir;
  final int tidakhadir;
  final int izin;
  final int bukapresensi;

  Data({
    this.idkelas,
    this.namamk,
    this.kelas,
    this.nppdosen1,
    this.namadosen1,
    this.hari1,
    this.sesi1,
    this.sks,
    this.pertemuan,
    this.materi,
    this.keterangan,
    this.jammasukdosen,
    this.jamkeluardosen,
    this.ruang,
    this.kapasitas,
    this.tglmasuk,
    this.tglkeluar,
    this.jammasuk,
    this.jamkeluar,
    this.hadir,
    this.tidakhadir,
    this.izin,
    this.bukapresensi,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idkelas: json["ID_KELAS"] == null ? null : json['ID_KELAS'] as int,
        namamk: json["NAMA_MK"] == null ? null : json['NAMA_MK'] as String,
        kelas: json["KELAS"] == null ? null : json['KELAS'] as String,
        nppdosen1:
            json["NPP_DOSEN1"] == null ? null : json['NPP_DOSEN1'] as String,
        namadosen1:
            json["NAMA_DOSEN1"] == null ? null : json['NAMA_DOSEN1'] as String,
        hari1: json["HARI1"] == null ? null : json['HARI1'] as String,
        sesi1: json["SESI1"] == null ? null : json['SESI1'] as String,
        sks: json["SKS"] == null ? null : json['SKS'] as int,
        pertemuan:
            json["PERTEMUAN_KE"] == null ? null : json['PERTEMUAN_KE'] as int,
        materi: json["MATERI"] == null ? null : json['MATERI'] as String,
        keterangan:
            json["KETERANGAN"] == null ? null : json['KETERANGAN'] as String,
        jammasukdosen:
            json["JAM_MASUK"] == null ? null : json['JAM_MASUK'] as String,
        jamkeluardosen:
            json["JAM_KELUAR"] == null ? null : json['JAM_KELUAR'] as String,
        ruang: json["RUANG"] == null ? null : json['RUANG'] as String,
        kapasitas: json["KAPASITAS_KELAS"] == null
            ? null
            : json['KAPASITAS_KELAS'] as int,
        tglmasuk: json["TGL_MASUK_SEHARUSNYA"] == null
            ? null
            : json['TGL_MASUK_SEHARUSNYA'] as String,
        tglkeluar: json["TGL_KELUAR_SEHARUSNYA"] == null
            ? null
            : json['TGL_KELUAR_SEHARUSNYA'] as String,
        jammasuk: json["JAM_MASUK_SEHARUSNYA"] == null
            ? null
            : json['JAM_MASUK_SEHARUSNYA'] as String,
        jamkeluar: json["JAM_KELUAR_SEHARUSNYA"] == null
            ? null
            : json['JAM_KELUAR_SEHARUSNYA'] as String,
        hadir: json["Hadir"] == null ? null : json['Hadir'] as int,
        tidakhadir:
            json["TidakHadir"] == null ? null : json['TidakHadir'] as int,
        izin: json["Izin"] == null ? null : json['Izin'] as int,
        bukapresensi: json["IS_BUKA_PRESENSI"] == null
            ? null
            : json['IS_BUKA_PRESENSI'] as int,
      );

  Map<String, dynamic> toJson() => {
        "ID_KELAS": idkelas,
        "NAMA_MK": namamk,
        "KELAS": kelas,
        "NPP_DOSEN1": nppdosen1,
        "NAMA_DOSEN1": namadosen1,
        "HARI1": hari1,
        "SESI1": sesi1,
        "SKS": sks,
        "PERTEMUAN_KE": pertemuan,
        "MATERI": materi,
        "KETERANGAN": keterangan,
        "JAM_MASUK": jammasuk,
        "JAM_KELUAR": jamkeluar,
        "RUANG": ruang,
        "KAPASITAS_KELAS": kapasitas,
        "TGL_MASUK_SEHARUSNYA": tglmasuk,
        "TGL_KELUAR_SEHARUSNYA": tglkeluar,
        "JAM_MASUK_SEHARUSNYA": jammasuk,
        "JAM_KELUAR_SEHARUSNYA": jamkeluar,
        "Hadir": hadir,
        "TidakHadir": tidakhadir,
        "Izin": izin,
        "IS_BUKA_PRESENSI": bukapresensi,
      };
}

class RiwayatDosenRequestModel {
  String npp;
  // String tglnow;
  // String semester;

  RiwayatDosenRequestModel({
    this.npp,
    // this.tglnow
    // this.semester
  });

  factory RiwayatDosenRequestModel.fromJson(Map<String, dynamic> json) =>
      RiwayatDosenRequestModel(
        npp: json["NPP"] as String,
        // tglnow: json["TGLNOW"] as String,
        // semester: json["SEMESTER"] as String,
      );

  Map<String, dynamic> toJson() => {
        "NPP": npp,
        // "TGLNOW": tglnow,
        // "SEMESTER": semester,
      };
}
