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
  final Map<String, String> headers;

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

  /// Bearer Token
  final String? oauthToken;

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
    this.oauthToken,
    this.timeout = 30000,
    this.followRedirects = true,
    this.maxRedirects = 5,
    required this.createdAt,
    this.updatedAt,
    this.collectionId,
    this.tags = const [],
  });
}
