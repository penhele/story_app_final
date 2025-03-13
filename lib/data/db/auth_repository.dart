import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static const String stateKey = "state";
  static const String tokenKey = "token";

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return prefs.getBool(stateKey) ?? false;
  }

  Future<bool> login(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
    return prefs.setBool(stateKey, true);
  }

  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
    return prefs.setBool(stateKey, false);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return prefs.getString(tokenKey);
  }
}
