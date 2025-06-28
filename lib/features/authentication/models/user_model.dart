import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    int? id,
    required String firstname,
    required String lastname,
    required String login,
    @JsonKey(name: 'is_verified') required bool isVerified,
    @JsonKey(name: 'tariff_id') required int tariffId,
    @JsonKey(name: 'tariff_expires_at') required DateTime tariffExpiresAt,
    @JsonKey(name: 'image_url') String? avatar,
    @JsonKey(name: 'last_login') DateTime? lastLogin,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
