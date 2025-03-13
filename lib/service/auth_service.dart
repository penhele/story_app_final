import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/model/auth/login_response.dart';
import '../data/model/auth/login_request.dart';
import '../data/model/auth/register_request.dart';
import '../data/model/auth/register_response.dart';

class AuthService {
  static const String baseUrl = "https://story-api.dicoding.dev/v1";

  Future<LoginResponse> login(LoginRequest loginData) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(loginData.toJson()),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login user: ${response.body}');
    }
  }

  Future<RegisterResponse> register(RegisterRequest registerData) async {
    final response = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(registerData.toJson()),
    );

    if (response.statusCode == 201) {
      return RegisterResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to register user: ${response.body}');
    }
  }
}
