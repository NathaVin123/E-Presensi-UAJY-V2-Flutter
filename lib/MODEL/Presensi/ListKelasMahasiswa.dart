class ListKelasMahasiswaResponseModel {
  final String error;
  List<Data> data;

  ListKelasMahasiswaResponseModel({this.error, this.data});

  String toString() =>
      'ListKelasMahasiswaResponseModel{error: $error, data: $data}';

  factory ListKelasMahasiswaResponseModel.fromJson(Map<String, dynamic> json) {
    var list = json["data"] as List;
    print(list.runtimeType);
    List<Data> dataList = list.map((i) => Data.fromJson(i)).toList();

    return ListKelasMahasiswaResponseModel(
        error: json["error"], data: dataList);
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
  final String nppdosen2;
  final String namadosen2;
  final String nppdosen3;
  final String namadosen3;
  final String nppdosen4;
  final String namadosen4;
  final String hari1;
  final String hari2;
  final String hari3;
  final String hari4;
  final String sesi1;
  final String sesi2;
  final String sesi3;
  final String sesi4;
  final int sks;
  final int pertemuan;
  final String ruang;
  final String uuid;
  final String namadevice;
  final double jarakmin;
  final int major;
  final int minor;
  final int kapasitas;
  final String tglmasuk;
  final String tglkeluar;
  final String jammasuk;
  final String jamkeluar;
  final int bukapresensi;
  final String tglin;
  final String tglout;
  final String status;

  Data(
      {this.idkelas,
      this.namamk,
      this.kelas,
      this.nppdosen1,
      this.namadosen1,
      this.nppdosen2,
      this.namadosen2,
      this.nppdosen3,
      this.namadosen3,
      this.nppdosen4,
      this.namadosen4,
      this.hari1,
      this.hari2,
      this.hari3,
      this.hari4,
      this.sesi1,
      this.sesi2,
      this.sesi3,
      this.sesi4,
      this.sks,
      this.pertemuan,
      this.ruang,
      this.uuid,
      this.namadevice,
      this.jarakmin,
      this.major,
      this.minor,
      this.kapasitas,
      this.tglmasuk,
      this.tglkeluar,
      this.jammasuk,
      this.jamkeluar,
      this.bukapresensi,
      this.tglin,
      this.tglout,
      this.status});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idkelas: json["ID_KELAS"] == null ? null : json['ID_KELAS'] as int,
        namamk: json["NAMA_MK"] == null ? null : json['NAMA_MK'] as String,
        kelas: json["KELAS"] == null ? null : json['KELAS'] as String,
        nppdosen1:
            json["NPP_DOSEN1"] == null ? null : json['NPP_DOSEN1'] as String,
        namadosen1:
            json["NAMA_DOSEN1"] == null ? null : json['NAMA_DOSEN1'] as String,
        nppdosen2:
            json["NPP_DOSEN2"] == null ? null : json['NPP_DOSEN2'] as String,
        namadosen2:
            json["NAMA_DOSEN2"] == null ? null : json['NAMA_DOSEN2'] as String,
        nppdosen3:
            json["NPP_DOSEN3"] == null ? null : json['NPP_DOSEN3'] as String,
        namadosen3:
            json["NAMA_DOSEN3"] == null ? null : json['NAMA_DOSEN3'] as String,
        nppdosen4:
            json["NPP_DOSEN4"] == null ? null : json['NPP_DOSEN4'] as String,
        namadosen4:
            json["NAMA_DOSEN4"] == null ? null : json['NAMA_DOSEN4'] as String,
        hari1: json["HARI1"] == null ? null : json['HARI1'] as String,
        hari2: json["HARI2"] == null ? null : json['HARI2'] as String,
        hari3: json["HARI3"] == null ? null : json['HARI3'] as String,
        hari4: json["HARI4"] == null ? null : json['HARI4'] as String,
        sesi1: json["SESI1"] == null ? null : json['SESI1'] as String,
        sesi2: json["SESI2"] == null ? null : json['SESI2'] as String,
        sesi3: json["SESI3"] == null ? null : json['SESI3'] as String,
        sesi4: json["SESI4"] == null ? null : json['SESI4'] as String,
        sks: json["SKS"] == null ? null : json['SKS'] as int,
        pertemuan:
            json["PERTEMUAN_KE"] == null ? null : json['PERTEMUAN_KE'] as int,
        ruang: json["RUANG"] == null ? null : json['RUANG'] as String,
        uuid: json["PROXIMITY_UUID"] == null
            ? null
            : json['PROXIMITY_UUID'] as String,
        namadevice:
            json["NAMA_DEVICE"] == null ? null : json['NAMA_DEVICE'] as String,
        jarakmin: ((json["JARAK_MIN_DEC"] as num) ?? 0.0).toDouble() == null
            ? null
            : ((json["JARAK_MIN_DEC"] as num) ?? 0.0).toDouble(),
        major: json["MAJOR"] == null ? null : json['MAJOR'] as int,
        minor: json["MINOR"] == null ? null : json['MINOR'] as int,
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
        bukapresensi: json["IS_BUKA_PRESENSI"] == null
            ? null
            : json['IS_BUKA_PRESENSI'] as int,
        tglin: json["TGL_IN"] == null ? null : json['TGL_IN'] as String,
        tglout: json["TGL_OUT"] == null ? null : json['TGL_OUT'] as String,
        status: json["status"] == null ? null : json['STATUS'] as String,
      );

  Map<String, dynamic> toJson() => {
        "ID_KELAS": idkelas,
        "NAMA_MK": namamk,
        "KELAS": kelas,
        "NPP_DOSEN1": nppdosen1,
        "NAMA_DOSEN1": namadosen1,
        "NPP_DOSEN2": nppdosen2,
        "NAMA_DOSEN2": namadosen2,
        "NPP_DOSEN3": nppdosen3,
        "NAMA_DOSEN3": namadosen3,
        "NPP_DOSEN4": nppdosen4,
        "NAMA_DOSEN4": namadosen4,
        "HARI1": hari1,
        "HARI2": hari2,
        "HARI3": hari3,
        "HARI4": hari4,
        "SESI1": sesi1,
        "SESI2": sesi2,
        "SESI3": sesi3,
        "SESI4": sesi4,
        "SKS": sks,
        "PERTEMUAN_KE": pertemuan,
        "RUANG": ruang,
        "PROXIMITY_UUID": uuid,
        "NAMA_DEVICE": namadevice,
        "JARAK_MIN_DEC": jarakmin,
        "MAJOR": major,
        "MINOR": minor,
        "KAPASITAS_KELAS": kapasitas,
        "TGL_MASUK_SEHARUSNYA": tglmasuk,
        "TGL_KELUAR_SEHARUSNYA": tglkeluar,
        "JAM_MASUK_SEHARUSNYA": jammasuk,
        "JAM_KELUAR_SEHARUSNYA": jamkeluar,
        "IS_BUKA_PRESENSI": bukapresensi,
        "TGL_IN": tglin,
        "TGL_OUT": tglout,
        "status": status,
      };
}

class ListKelasMahasiswaRequestModel {
  String npm;
  // String tglnow;

  ListKelasMahasiswaRequestModel({this.npm
      // , this.tglnow
      });

  factory ListKelasMahasiswaRequestModel.fromJson(Map<String, dynamic> json) =>
      ListKelasMahasiswaRequestModel(
        npm: json["NPM"] as String,
        // tglnow: json["TGLNOW"] as String,
      );

  Map<String, dynamic> toJson() => {
        "NPM": npm,
        // "TGLNOW": tglnow,
      };
}
