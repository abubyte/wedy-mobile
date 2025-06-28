import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wedy/features/authentication/models/login_api_model.dart';
import 'package:wedy/features/authentication/models/register_api_model.dart';
import 'package:wedy/features/authentication/models/verify_api_model.dart';

part 'authentication_event.freezed.dart';

@freezed
abstract class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.registerRequested(RegisterRequestModel request) = AuthenticationRegisterRequested;
  const factory AuthenticationEvent.verifyRequested(VerifyRequestModel request) = AuthenticationVerifyRequested;
  const factory AuthenticationEvent.loginRequested(LoginRequestModel request) = AuthenticationLoginRequested;
  const factory AuthenticationEvent.logoutRequested() = AuthenticationLogoutRequested;
  const factory AuthenticationEvent.checkStatus() = AuthenticationCheckStatus;
  const factory AuthenticationEvent.clearError() = AuthenticationClearError;
}
