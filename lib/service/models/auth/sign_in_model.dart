import 'package:json_annotation/json_annotation.dart';

part 'sign_in_model.g.dart';

@JsonSerializable()
class SignInModel {
  final String email;
  final String password;
  @JsonKey(name: 'csrfToken')
  final String csrfToken;

  const SignInModel({
    required this.email,
    required this.password,
    this.csrfToken = '',
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) => _$SignInModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignInModelToJson(this);

  @override
  String toString() {
    return 'SignInModel{email: $email, password: $password, csrfToken: $csrfToken}';
  }
}
