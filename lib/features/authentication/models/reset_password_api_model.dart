import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_api_model.freezed.dart';
part 'reset_password_api_model.g.dart';

@freezed
abstract class ResetPasswordRequestModel with _$ResetPasswordRequestModel {
  const factory ResetPasswordRequestModel({
    required String login,
    @JsonKey(name: 'new_password') required String password,
    @JsonKey(name: 'verification_code') required String verificationCode,
  }) = _ResetPasswordRequestModel;

  factory ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) => _$ResetPasswordRequestModelFromJson(json);
}

@freezed
abstract class ResetPasswordResponseModel with _$ResetPasswordResponseModel {
  const factory ResetPasswordResponseModel({required String message}) = _ResetPasswordResponseModel;

  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) => _$ResetPasswordResponseModelFromJson(json);
}
