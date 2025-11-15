import 'dart:convert';

import 'package:api_client/core/enum/http_method.dart';

class RequestModel {
  final String id;

  /// Уникальный идентификатор запроса (для истории)
  final String name;

  /// Название запроса (для удобства пользователя)
  final String? description;
  final HTTP_METHOD httpMethod;

  /// HTTP метод
  final String url;

  /// URL endpoint
  final Map<String, dynamic> headers;

  /// Заголовки запроса
  final Map<String, dynamic> queryParameters;

  /// Параметры URL (query parameters)
  final String? body;

  /// Тело запроса (для POST, PUT, PATCH)
  final String? username;

  /// Basic Auth username
  final String? password;

  /// Basic Auth password
  final String? bearerToken;

  final String? bearerTokenPrefix;

  /// Bearer Token
  final String? oauthToken;

  final String? oauthTokenPrefix;

  /// OAuth 2.0 token
  final int timeout;

  /// Таймаут запроса в миллисекундах
  final bool followRedirects;

  /// Следить за перенаправлениями
  final int maxRedirects;

  /// Максимальное количество перенаправлений
  final DateTime createdAt;

  /// Время создания запроса
  final DateTime? updatedAt;

  /// Время последнего изменения
  final String? collectionId;

  /// ID коллекции/папки (для организации запросов)
  final List<String> tags;

  /// Теги для categorization

  RequestModel({
    required this.id,
    this.name = 'New request',
    this.description,
    required this.httpMethod,
    required this.url,
    this.headers = const {},
    this.queryParameters = const {},
    this.body,
    this.username,
    this.password,
    this.bearerToken,
    this.bearerTokenPrefix,
    this.oauthToken,
    this.oauthTokenPrefix,
    this.timeout = 30000,
    this.followRedirects = true,
    this.maxRedirects = 5,
    required this.createdAt,
    this.updatedAt,
    this.collectionId,
    this.tags = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'httpMethod': httpMethod.name,
      'url': url,
      'headers': headers,
      'queryParameters': queryParameters,
      'body': body,
      'username': username,
      'password': password,
      'bearerToken': bearerToken,
      'bearerTokenPrefix': bearerTokenPrefix,
      'oauthToken': oauthToken,
      'oauthTokenPrefix': oauthTokenPrefix,
      'timeout': timeout,
      'followRedirects': followRedirects,
      'maxRedirects': maxRedirects,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'collectionId': collectionId,
      'tags': tags,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'],
      httpMethod: httpMethodConvertFromString(value: map['httpMethod']),
      url: map['url'] ?? '',
      headers: Map<String, dynamic>.from(map['headers']),
      queryParameters: Map<String, dynamic>.from(map['queryParameters']),
      body: map['body'],
      username: map['username'],
      password: map['password'],
      bearerToken: map['bearerToken'],
      bearerTokenPrefix: map['bearerTokenPrefix'],
      oauthToken: map['oauthToken'],
      oauthTokenPrefix: map['oauthTokenPrefix'],
      timeout: map['timeout']?.toInt() ?? 0,
      followRedirects: map['followRedirects'] ?? false,
      maxRedirects: map['maxRedirects']?.toInt() ?? 0,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: map['updatedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt']) : null,
      collectionId: map['collectionId'],
      tags: List<String>.from(map['tags']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestModel.fromJson(String source) => RequestModel.fromMap(json.decode(source));
}
