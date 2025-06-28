import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wedy/core/constants/api_endpoints.dart';
import 'package:wedy/core/errors/api_exception.dart';
import 'package:wedy/features/authentication/models/login_api_model.dart';
import 'package:wedy/features/authentication/models/register_api_model.dart';
import 'package:wedy/features/authentication/models/reset_password_api_model.dart';
import 'package:wedy/features/authentication/models/user_model.dart';
import 'package:wedy/features/authentication/models/verify_api_model.dart';
import 'package:wedy/features/authentication/services/authentication_service.dart';
import 'package:wedy/shared/services/api_service.dart';

class AuthenticationServiceImpl implements AuthenticationService {
  final ApiService _apiService;
  final SharedPreferences _prefs;

  AuthenticationServiceImpl(this._apiService, this._prefs);

  @override
  Future<RegisterResponseModel> register(RegisterRequestModel request) async {
    try {
      final response = await _apiService.postFormDataRequest(
        ApiEndpoints.register,
        formData: FormData.fromMap(request.toJson()),
      );

      return RegisterResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      final msg = "User with this login already exists";

      if (e.response?.data['detail'] == msg) {
        return RegisterResponseModel(
          message: msg,
          exists: true,
          user: UserModel(
            firstname: '',
            lastname: '',
            login: '',
            isVerified: false,
            tariffId: 0,
            tariffExpiresAt: DateTime.now(),
          ),
        );
      }
      throw ApiException(e.message ?? "Hisob yaratib bo'lmadi");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VerifyResponseModel> verify(VerifyRequestModel request) async {
    try {
      final response = await _apiService.postFormDataRequest(
        ApiEndpoints.verify,
        formData: FormData.fromMap(request.toJson()),
      );

      return VerifyResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException(e.message ?? "Hisobni tasdiqlab bo'lmadi");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    try {
      final response = await _apiService.postFormDataRequest(
        ApiEndpoints.login,
        formData: FormData.fromMap(request.toJson()),
      );

      await _prefs.setBool("isLoggedIn", true);

      return LoginResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException(e.message ?? "Hisobga kirib bo'lmadi");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _prefs.remove("isLoggedIn");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(ResetPasswordRequestModel request) async {
    try {
      await _apiService.postFormDataRequest(ApiEndpoints.resetPassword, formData: FormData.fromMap(request.toJson()));
    } on DioException catch (e) {
      throw ApiException(e.message ?? "Password reset failed");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final response = await _apiService.getRequest("${ApiEndpoints.users}/me");

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException(e.message ?? "Password reset failed");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> storeToken(String token) async {
    await _prefs.setString('access_token', token);
  }

  @override
  Future<bool> isTokenExpired() async {
    final token = _prefs.getString("access_token");

    return token != null ? JwtDecoder.isExpired(token) : true;
  }

  @override
  String? getStoredToken() {
    return _prefs.getString('access_token');
  }

  @override
  Future<void> clearToken() async {
    await _prefs.remove('access_token');
  }
}
