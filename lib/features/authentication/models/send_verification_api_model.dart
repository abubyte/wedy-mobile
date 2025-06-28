import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_verification_api_model.freezed.dart';
part 'send_verification_api_model.g.dart';

@freezed
abstract class SendVerificationRequestModel with _$SendVerificationRequestModel {
  const factory SendVerificationRequestModel({required String login}) = _SendVerificationRequestModel;

  factory SendVerificationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SendVerificationRequestModelFromJson(json);
}

@freezed
abstract class SendVerificationResponseModel with _$SendVerificationResponseModel {
  const factory SendVerificationResponseModel({required String message}) = _SendVerificationResponseModel;

  factory SendVerificationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SendVerificationResponseModelFromJson(json);
}
