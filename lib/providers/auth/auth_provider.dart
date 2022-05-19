import 'package:frontend/models/user_model.dart';
import 'package:frontend/providers/global_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../repositories/auth_repository.dart';

final authProvider =
    StateNotifierProvider<AuthProvider, Map<String, dynamic>>((ref) {
  final as = ref.read(authRepository);
  return AuthProvider(as);
});

class AuthProvider extends StateNotifier<Map<String, dynamic>> {
  AuthProvider(this._authRepository) : super({});

  final AuthRepository? _authRepository;

  Future<UserModel> getUser() async {
    try {
      UserModel result = await _authRepository!.getUser();

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      Map<String, dynamic> result =
          await _authRepository!.login(email, password);

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> register(UserModel user, String password) async {
    try {
      Map<String, dynamic> result =
          await _authRepository!.register(user, password);

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> update(UserModel user, String password) async {
    try {
      Map<String, dynamic> result =
          await _authRepository!.update(user, password);

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      Map<String, dynamic> result = await _authRepository!.logout();

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
