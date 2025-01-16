import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  Message({
    required this.id,
    required this.offerId,
    required this.senderId,
    required this.text,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  final String id;
  final String offerId;
  final String senderId;
  final String text;
  final DateTime timestamp;

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
