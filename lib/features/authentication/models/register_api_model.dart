import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wedy/features/authentication/models/user_model.dart';

part 'register_api_model.freezed.dart';
part 'register_api_model.g.dart';

@freezed
abstract class RegisterRequestModel with _$RegisterRequestModel {
  const factory RegisterRequestModel({
    required String firstname,
    required String lastname,
    required String login,
    required String password,
  }) = _RegisterRequestModel;

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) => _$RegisterRequestModelFromJson(json);
}

@freezed
abstract class RegisterResponseModel with _$RegisterResponseModel {
  const factory RegisterResponseModel({
    required String message,
    required UserModel user,
    @Default(false) bool? exists,
  }) = _RegisterResponseModel;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => _$RegisterResponseModelFromJson(json);
}
