import 'dart:convert';

import 'package:objectbox/objectbox.dart';

@Entity()
class ResponseModel {

  @Id()
  int id = 0;

  /// ID связанного запроса
  final String requestId;

  /// Статус сообщение
  final int statusCode;

  /// Заголовки ответа (сохраняются как JSON String)
  final String headersJson;

  /// Тело ответа
  final String body;

  /// Размер ответа в байтах
  final int size;

  /// Время получения ответа
  final int responseTimeMs; // Duration в миллисекундах

  /// Было ли кешировано
  final bool isCached;

  /// Ошибка (если есть)
  final String? error;

  ResponseModel({
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
}
