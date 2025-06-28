import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_api_model.freezed.dart';
part 'refresh_api_model.g.dart';

@freezed
abstract class RefreshRequestModel with _$RefreshRequestModel {
  const factory RefreshRequestModel({@JsonKey(name: 'refresh_token') required String refreshToken}) =
      _RefreshRequestModel;

  factory RefreshRequestModel.fromJson(Map<String, dynamic> json) => _$RefreshRequestModelFromJson(json);
}

@freezed
abstract class RefreshResponseModel with _$RefreshResponseModel {
  const factory RefreshResponseModel({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'token_type') required String tokenType,
  }) = _RefreshResponseModel;

  factory RefreshResponseModel.fromJson(Map<String, dynamic> json) => _$RefreshResponseModelFromJson(json);
}
