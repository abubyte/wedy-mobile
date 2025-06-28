import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wedy/features/authentication/models/user_model.dart';

part 'authentication_state.freezed.dart';

@freezed
abstract class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState({
    @Default(false) bool isLoading,
    @Default(false) bool isVerified,
    @Default(false) bool isAuthenticated,
    UserModel? user,
    String? errorMessage,
    @Default(AuthenticationStatus.initial) AuthenticationStatus status,
  }) = _AuthenticationState;
}

enum AuthenticationStatus { initial, loading, authenticated, unauthenticated, error }
