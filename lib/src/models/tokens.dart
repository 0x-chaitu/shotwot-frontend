import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'tokens.g.dart';

@Entity()
class Token {
  @Id(assignable: true)
  late int id;

  String? accessToken;
  String? refreashToken;

  Token();
}

@JsonSerializable()
class Tokens {
  Map<String,String> tokens;

  Tokens({required this.tokens });

  List<Object?> get props => [tokens];

  factory Tokens.fromJson(Map<String, dynamic> json) => _$TokensFromJson(json);

  Map<String, dynamic> toJson() => _$TokensToJson(this);
}
