import 'package:flutter/material.dart';
import '../data/model/auth/register_request.dart';
import '../data/model/auth/register_response.dart';
import '../data/db/auth_repository.dart';
import '../data/model/auth/login_request.dart';
import '../data/model/auth/login_response.dart';
import '../service/auth_service.dart';
import '../data/model/story/story.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  final AuthService authService;

  AuthProvider(this.authRepository, this.authService);

  bool isLoadingLogin = false;
  bool isLoadingLogout = false;
  bool isLoadingRegister = false;
  bool isLoggedIn = false;
  bool isLoadingFetch = false;

  String? _token;
  List<Story> _stories = [];

  String? get token => _token;
  List<Story> get stories => _stories;

  Future<bool> login(LoginRequest loginData) async {
    isLoadingLogin = true;
    notifyListeners();

    try {
      LoginResponse response = await authService.login(loginData);
      _token = response.loginResult.token;
      await authRepository.login(_token!);
    } catch (e) {
      _token = null;
    }

    isLoggedIn = await authRepository.isLoggedIn();

    isLoadingLogin = false;
    notifyListeners();

    return isLoggedIn;
  }

  Future<bool> logout() async {
    isLoadingLogout = true;
    notifyListeners();

    _token = null;
    await authRepository.logout();
    notifyListeners();

    isLoggedIn = await authRepository.isLoggedIn();

    isLoadingLogout = false;
    notifyListeners();

    return !isLoggedIn;
  }

  Future<bool> register(RegisterRequest registerData) async {
    isLoadingRegister = true;
    notifyListeners();

    try {
      RegisterResponse response = await authService.register(registerData);
      return !response.error;
    } catch (e) {
      return false;
    } finally {
      isLoadingRegister = false;
      notifyListeners();
    }
  }

  Future<void> loadToken() async {
    _token = await authRepository.getToken();
    notifyListeners();
  }
}
