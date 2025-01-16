import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@immutable
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class User {
  const User({
    required this.id,
    required this.username,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final String id;
  final String username;
  final String email;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
