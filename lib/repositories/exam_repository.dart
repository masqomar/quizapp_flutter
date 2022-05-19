import 'package:frontend/configs/app_helper.dart';
import 'package:frontend/configs/app_service.dart';
import 'package:frontend/models/exam_model.dart';
import 'package:frontend/models/history_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExamRepository {
  Future<List<PaketModel>> getPaket() async {
    try {
      final url = Uri.parse('${urlApi}paket/get-data');
      final token = await getToken();

      final response = await http.get(
        url,
        headers: {
          "Content-type": "application/json",
          'Authorization': 'Bearer $token'
        },
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        var objects = data['data'] as List;
        var dataAticle = objects.map((e) => PaketModel.fromJson(e)).toList();

        return dataAticle;
      } else {
        throw (data['message']);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<HistoryModel>> getHistory() async {
    try {
      final url = Uri.parse('${urlApi}hasil-latihan/get-data');
      final token = await getToken();

      final response = await http.get(
        url,
        headers: {
          "Content-type": "application/json",
          'Authorization': 'Bearer $token'
        },
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        var objects = data['data'] as List;
        var dataAticle = objects.map((e) => HistoryModel.fromJson(e)).toList();

        return dataAticle;
      } else {
        throw (data['message']);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ExamModel>> getSoal(int idPaket) async {
    try {
      final url = Uri.parse('${urlApi}soal/get-data/$idPaket');
      final token = await getToken();

      final response = await http.get(
        url,
        headers: {
          "Content-type": "application/json",
          'Authorization': 'Bearer $token'
        },
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        var objects = data['data'] as List;
        var dataAticle = objects.map((e) => ExamModel.fromJson(e)).toList();

        return dataAticle;
      } else {
        throw (data['message']);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Map<String, dynamic>> saveResult(
    int idPaket,
    int twk,
    int tiu,
    int tkp,
    DateTime start,
    DateTime end,
  ) async {
    try {
      final url = Uri.parse('${urlApi}soal/hasil-latihan/simpan');
      final token = await getToken();

      Map dataBody = {
        "id_paket": idPaket,
        "nilai_twk": twk,
        "nilai_tiu": tiu,
        "nilai_tkp": tkp,
        "start_waktu_mengerjakan": start.toIso8601String(),
        "end_waktu_mengerjakan": end.toIso8601String()
      };

      final response = await http.post(
        url,
        body: json.encode(dataBody),
        headers: {
          "Content-type": "application/json",
          'Authorization': 'Bearer $token'
        },
      );

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        return {'success': data['success'], 'message': data['message']};
      } else {
        throw (data['message']);
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
