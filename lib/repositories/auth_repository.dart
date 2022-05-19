import 'package:frontend/configs/app_helper.dart';
import 'package:frontend/configs/app_service.dart';
import 'package:frontend/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  Future<UserModel> getUser() async {
    try {
      final url = Uri.parse('${urlApi}user');
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
        var dataUser = UserModel.fromJson(data['data']);

        return dataUser;
      } else {
        throw (data['message']);
      }
    } catch (e) {
      throw catchErr(e);
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final url = Uri.parse('${urlApi}login');

      Map dataBody = {
        'email': email,
        'password': password,
      };

      final response = await http.post(
        url,
        body: json.encode(dataBody),
        headers: {
          "Content-type": "application/json",
        },
      );

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        saveSessionUser(data['token']);
        return {'success': data['success'], 'message': data['message']};
      } else {
        throw (data['message']);
      }
    } catch (e) {
      throw catchErr(e);
    }
  }

  Future<Map<String, dynamic>> register(UserModel user, String password) async {
    try {
      final url = Uri.parse('${urlApi}register');

      Map dataBody = {
        "userName": user.userName,
        "firstName": user.firstName,
        "lastName": user.lastName,
        "email": user.email,
        "password": password,
        "phone": user.phone
      };

      final response = await http.post(
        url,
        body: json.encode(dataBody),
        headers: {"Content-type": "application/json"},
      );

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        saveSessionUser(data['token']);
        return {'success': data['success'], 'message': data['message']};
      } else {
        throw (data['message']);
      }
    } catch (e) {
      throw catchErr(e);
    }
  }

  Future<Map<String, dynamic>> update(UserModel user, String password) async {
    try {
      final url = Uri.parse('${urlApi}update');
      final token = await getToken();

      Map dataBody = {
        "userName": user.userName,
        "firstName": user.firstName,
        "lastName": user.lastName,
        "email": user.email,
        "password": password,
        "phone": user.phone
      };

      final response = await http.post(
        url,
        body: json.encode(dataBody),
        headers: {
          "Content-type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        return {'success': data['success'], 'message': data['message']};
      } else {
        throw (data['message']);
      }
    } catch (e) {
      throw catchErr(e);
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      final url = Uri.parse('${urlApi}logout');
      final token = await getToken();

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        removeSessionUser();
        return {'success': data['success'], 'message': data['message']};
      } else {
        throw (data['message']);
      }
    } catch (e) {
      throw catchErr(e);
    }
  }

  Future<bool> saveSessionUser(String token) async {
    try {
      final sp = await SharedPreferences.getInstance();
      sp.setString(keyPref, token);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> readSessionUser() async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString(keyPref);

    return token;
  }

  Future<bool> removeSessionUser() async {
    try {
      final sp = await SharedPreferences.getInstance();
      final result = await sp.remove(keyPref);

      sp.clear();

      return result;
    } catch (e) {
      return false;
    }
  }

  getDeviceId() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final deviceId = sp.getString("pref_last_device_id");

    return deviceId;
  }
}
