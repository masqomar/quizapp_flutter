import 'package:frontend/models/exam_model.dart';

class HistoryModel {
  int? id;
  int? idUser;
  int? idPaket;
  int? nilaiTwk;
  int? nilaiTiu;
  int? nilaiTkp;
  String? startWaktuMengerjakan;
  String? endWaktuMengerjakan;
  String? createdAt;
  String? updatedAt;
  PaketModel? getPaket;

  HistoryModel(
      {this.id,
      this.idUser,
      this.idPaket,
      this.nilaiTwk,
      this.nilaiTiu,
      this.nilaiTkp,
      this.startWaktuMengerjakan,
      this.endWaktuMengerjakan,
      this.createdAt,
      this.updatedAt,
      this.getPaket});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    idPaket = json['id_paket'];

    nilaiTwk = json['nilai_twk'];
    nilaiTiu = json['nilai_tiu'];
    nilaiTkp = json['nilai_tkp'];
    startWaktuMengerjakan = json['start_waktu_mengerjakan'];
    endWaktuMengerjakan = json['end_waktu_mengerjakan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    getPaket = json['get_paket'] != null
        ? PaketModel.fromJson(json['get_paket'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_user'] = idUser;
    data['id_paket'] = idPaket;

    data['nilai_twk'] = nilaiTwk;
    data['nilai_tiu'] = nilaiTiu;
    data['nilai_tkp'] = nilaiTkp;
    data['start_waktu_mengerjakan'] = startWaktuMengerjakan;
    data['end_waktu_mengerjakan'] = endWaktuMengerjakan;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (getPaket != null) {
      data['get_paket'] = getPaket!.toJson();
    }
    return data;
  }
}
