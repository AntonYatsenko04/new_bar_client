import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/src/enums/user_type.dart';

part 'sign_up_model.freezed.dart';
part 'sign_up_model.g.dart';

@freezed
class SignUpModel with _$SignUpModel {
  const factory SignUpModel({
    required String email,
    required String password,
    @JsonKey(name: 'role') required UserType userType,
  }) = _SignUpModel;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => _$SignUpModelFromJson(json);
}
