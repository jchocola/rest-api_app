import 'dart:convert';

import 'package:objectbox/objectbox.dart';

//@Entity()
class ResponseModel {
  //@Id()
  final int id;

  /// ID связанного запроса
  final String requestId;

  /// Статус сообщение
  final int statusCode;

  /// Заголовки ответа (сохраняются как JSON String)
  final String headersJson;

  /// Тело ответа
  final dynamic body;

  /// Размер ответа в байтах
  final int size;

  /// Время получения ответа
  final int responseTimeMs; // Duration в миллисекундах

  /// Было ли кешировано
  final bool isCached;

  /// Ошибка (если есть)
  final String? error;

  ResponseModel({
    required this.id,
    required this.requestId,
    required this.statusCode,
    required this.headersJson,
    required this.body,
    required this.size,
    required this.responseTimeMs,
    this.isCached = false,
    this.error,
  });

  /// Getter для получения headers из JSON
  Map<String, String> get headers {
    try {
      return Map<String, String>.from(jsonDecode(headersJson) as Map);
    } catch (e) {
      return {};
    }
  }

  /// Getter для получения responseTime из миллисекунд
  Duration get responseTime => Duration(milliseconds: responseTimeMs);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'requestId': requestId,
      'statusCode': statusCode,
      'headersJson': headersJson,
      'body': body,
      'size': size,
      'responseTimeMs': responseTimeMs,
      'isCached': isCached,
      'error': error,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      id: map['id']?.toInt() ?? 0,
      requestId: map['requestId'] ?? '',
      statusCode: map['statusCode']?.toInt() ?? 0,
      headersJson: map['headersJson'] ?? '',
      body: map['body'] ?? null,
      size: map['size']?.toInt() ?? 0,
      responseTimeMs: map['responseTimeMs']?.toInt() ?? 0,
      isCached: map['isCached'] ?? false,
      error: map['error'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source));
}
