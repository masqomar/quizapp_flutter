class ExamModel {
  int? sId;
  int? sIdPaket;
  int? sIdKategori;
  String? sPertanyaan;
  String? sStatusSoal;
  PaketModel? getPaket;
  GetKategori? getKategori;
  List<GetPilihanGanda>? getPilihanGanda;
  GetKunci? getKunci;
  bool isSelected = false;

  ExamModel({
    this.sId,
    this.sIdPaket,
    this.sIdKategori,
    this.sPertanyaan,
    this.sStatusSoal,
    this.getPaket,
    this.getKategori,
    this.getPilihanGanda,
    this.getKunci,
  });

  void selected(bool select) {
    isSelected = select;
  }

  ExamModel.fromJson(Map<String, dynamic> json) {
    sId = json['s_id'];
    sIdPaket = json['s_id_paket'];
    sIdKategori = json['s_id_kategori'];
    sPertanyaan = json['s_pertanyaan'];
    sStatusSoal = json['s_status_soal'];
    getPaket = json['get_paket'] != null
        ? PaketModel.fromJson(json['get_paket'])
        : null;
    getKategori = json['get_kategori'] != null
        ? GetKategori.fromJson(json['get_kategori'])
        : null;
    if (json['get_pilihan_ganda'] != null) {
      getPilihanGanda = <GetPilihanGanda>[];
      json['get_pilihan_ganda'].forEach((v) {
        getPilihanGanda!.add(GetPilihanGanda.fromJson(v));
      });
    }
    getKunci =
        json['get_kunci'] != null ? GetKunci.fromJson(json['get_kunci']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['s_id'] = sId;
    data['s_id_paket'] = sIdPaket;
    data['s_id_kategori'] = sIdKategori;
    data['s_pertanyaan'] = sPertanyaan;
    data['s_status_soal'] = sStatusSoal;
    if (getPaket != null) {
      data['get_paket'] = getPaket!.toJson();
    }
    if (getKategori != null) {
      data['get_kategori'] = getKategori!.toJson();
    }
    if (getPilihanGanda != null) {
      data['get_pilihan_ganda'] =
          getPilihanGanda!.map((v) => v.toJson()).toList();
    }
    if (getKunci != null) {
      data['get_kunci'] = getKunci!.toJson();
    }
    return data;
  }
}

class PaketModel {
  int? pkId;
  String? pkNama;
  String? pkTime;

  PaketModel({this.pkId, this.pkNama, this.pkTime});

  PaketModel.fromJson(Map<String, dynamic> json) {
    pkId = json['pk_id'];
    pkNama = json['pk_nama'];
    pkTime = json['pk_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pk_id'] = pkId;
    data['pk_nama'] = pkNama;
    data['pk_time'] = pkTime;
    return data;
  }
}

class GetKategori {
  int? ktId;
  String? ktNama;
  String? ktTipeSoal;
  String? ktNilaiBenar;
  int? ktNilaiSalah;
  int? ktNilaiKosong;
  int? ktPassingGrade;

  GetKategori(
      {this.ktId,
      this.ktNama,
      this.ktTipeSoal,
      this.ktNilaiBenar,
      this.ktNilaiSalah,
      this.ktNilaiKosong,
      this.ktPassingGrade});

  GetKategori.fromJson(Map<String, dynamic> json) {
    ktId = json['kt_id'];
    ktNama = json['kt_nama'];
    ktTipeSoal = json['kt_tipe_soal'];
    ktNilaiBenar = json['kt_nilai_benar'];
    ktNilaiSalah = json['kt_nilai_salah'];
    ktNilaiKosong = json['kt_nilai_kosong'];
    ktPassingGrade = json['kt_passing_grade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kt_id'] = ktId;
    data['kt_nama'] = ktNama;
    data['kt_tipe_soal'] = ktTipeSoal;
    data['kt_nilai_benar'] = ktNilaiBenar;
    data['kt_nilai_salah'] = ktNilaiSalah;
    data['kt_nilai_kosong'] = ktNilaiKosong;
    data['kt_passing_grade'] = ktPassingGrade;
    return data;
  }
}

class GetPilihanGanda {
  int? sjIdSoal;
  int? sjId;
  String? sjAbjad;
  String? sjJawaban;

  GetPilihanGanda({this.sjIdSoal, this.sjId, this.sjAbjad, this.sjJawaban});

  GetPilihanGanda.fromJson(Map<String, dynamic> json) {
    sjIdSoal = json['sj_id_soal'];
    sjId = json['sj_id'];
    sjAbjad = json['sj_abjad'];
    sjJawaban = json['sj_jawaban'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sj_id_soal'] = sjIdSoal;
    data['sj_id'] = sjId;
    data['sj_abjad'] = sjAbjad;
    data['sj_jawaban'] = sjJawaban;
    return data;
  }
}

class GetKunci {
  int? skjId;
  int? skjIdSoal;
  String? skjIdJawaban;
  String? skjPembahasan;

  GetKunci({this.skjId, this.skjIdSoal, this.skjIdJawaban, this.skjPembahasan});

  GetKunci.fromJson(Map<String, dynamic> json) {
    skjId = json['skj_id'];
    skjIdSoal = json['skj_id_soal'];
    skjIdJawaban = json['skj_id_jawaban'];
    skjPembahasan = json['skj_pembahasan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['skj_id'] = skjId;
    data['skj_id_soal'] = skjIdSoal;
    data['skj_id_jawaban'] = skjIdJawaban;
    data['skj_pembahasan'] = skjPembahasan;
    return data;
  }
}
