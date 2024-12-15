import 'package:freezed_annotation/freezed_annotation.dart';

part 'no_role_user_model.freezed.dart';
part 'no_role_user_model.g.dart';

@freezed
class NoRoleUserModel with _$NoRoleUserModel {
  const factory NoRoleUserModel({
    required int id,
    required String email,
  }) = _NoRoleUserModel;

  factory NoRoleUserModel.fromJson(Map<String, dynamic> json) =>
      _$NoRoleUserModelFromJson(json);
}
