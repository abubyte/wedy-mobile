import 'package:wedy/features/authentication/models/login_api_model.dart';
import 'package:wedy/features/authentication/models/register_api_model.dart';
import 'package:wedy/features/authentication/models/reset_password_api_model.dart';
import 'package:wedy/features/authentication/models/user_model.dart';
import 'package:wedy/features/authentication/models/verify_api_model.dart';

abstract class AuthenticationService {
  Future<RegisterResponseModel> register(RegisterRequestModel request);
  Future<VerifyResponseModel> verify(VerifyRequestModel request);
  Future<LoginResponseModel> login(LoginRequestModel request);
  Future<void> logout();
  Future<void> resetPassword(ResetPasswordRequestModel request);
  Future<UserModel?> getCurrentUser();
  Future<void> storeToken(String token);
  Future<bool> isTokenExpired();
  String? getStoredToken();
  Future<void> clearToken();
}
