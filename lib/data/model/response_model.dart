import 'dart:convert';

import 'package:api_client/core/enum/http_method.dart';
import 'package:api_client/data/model/parameter_model.dart';
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

  final String endpointUrl;

  final String cookies;

  final String parameters;

  final DateTime created;

  final HTTP_METHOD httpMethod;

  final int responseTime;

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
    required this.endpointUrl,
    required this.cookies,
    required this.parameters,
    required this.created,
    required this.httpMethod,
    required this.responseTime,
  });

  /// Getter для получения headers из JSON
  Map<String, String> get headers {
    try {
      return Map<String, String>.from(jsonDecode(headersJson) as Map);
    } catch (e) {
      return {};
    }
  }

 

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
      'endpointUrl': endpointUrl,
      'cookies': cookies,
      'parameters': parameters,
      'created': created.millisecondsSinceEpoch,
      'httpMethod': httpMethod.name,
      'responseTime': responseTime
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
      endpointUrl: map['endpointUrl'] ?? '',
      cookies: map['cookies'] ?? '',
      parameters: map['parameters'] ?? [],
      //created: DateTime.now()
      created: DateTime.fromMillisecondsSinceEpoch(
        map['created'] ?? DateTime.now(),
      ),

      httpMethod: httpMethodConvertFromString(
        value: map['httpMethod'] ?? 'GET',
      ),
      responseTime: map['responseTime'] ?? 0
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source));
}
