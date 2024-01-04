import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  String? id;
  String? firstname;
  String? lastname;
  String? email;

  UserModel({required this.id, required this.email });

  List<Object?> get props => [id, email, firstname, lastname];

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
