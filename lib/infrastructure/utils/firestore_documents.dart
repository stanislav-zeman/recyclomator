import 'package:cloud_firestore/cloud_firestore.dart';

typedef DocumentDeserializer<T> = T Function(Map<String, dynamic> json);
typedef DocumentSerializer<T> = Map<String, dynamic> Function(T data);

T deserializeJsonDocument<T>(
  DocumentSnapshot<Map<String, dynamic>> document,
  DocumentDeserializer<T> deserializer,
) {
  final Map<String, dynamic> json = document.data()!..['id'] = document.id;
  return deserializer(json);
}

Map<String, dynamic> serializeJsonDocument<T>(
  T data,
  DocumentSerializer<T> serializer,
) {
  final Map<String, dynamic> json = serializer(data)..remove('id');
  return json;
}
