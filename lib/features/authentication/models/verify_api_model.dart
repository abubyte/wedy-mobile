import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_api_model.freezed.dart';
part 'verify_api_model.g.dart';

@freezed
abstract class VerifyRequestModel with _$VerifyRequestModel {
  const factory VerifyRequestModel({required String login, required String code}) = _VerifyRequestModel;

  factory VerifyRequestModel.fromJson(Map<String, dynamic> json) => _$VerifyRequestModelFromJson(json);
}

@freezed
abstract class VerifyResponseModel with _$VerifyResponseModel {
  const factory VerifyResponseModel({required String message}) = _VerifyResponseModel;

  factory VerifyResponseModel.fromJson(Map<String, dynamic> json) => _$VerifyResponseModelFromJson(json);
}
