class ResponseModel {
  /// ID связанного запроса
  final String requestId;

  /// Статус сообщение
  final int statusCode;

  /// Заголовки ответа
  final Map<String, String> headers;

  /// Тело ответа
  final String body;

  /// Размер ответа в байтах
  final int size;

  /// Время получения ответа
  final Duration responseTime;

  /// Было ли кешировано
  final bool isCached;

  /// Ошибка (если есть)
  final String? error;

  ResponseModel({
    required this.requestId,
    required this.statusCode,
    required this.headers,
    required this.body,
    required this.size,
    required this.responseTime,
    this.isCached = false,
    this.error,
  });
}
