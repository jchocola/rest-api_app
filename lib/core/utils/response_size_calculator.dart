import 'dart:convert';

import 'package:dio/dio.dart';

int calculateTotalResponseSize(Response response) {
  int totalSize = 0;
  
  // Размер тела ответа
  if (response.data != null) {
    if (response.data is String) {
      totalSize += (response.data as String).length;
    } else if (response.data is List<int>) {
      totalSize += (response.data as List<int>).length;
    } else if (response.data is Map || response.data is List) {
      totalSize += jsonEncode(response.data).length;
    }
  }
  
  // Размер заголовков (приблизительно)
  // for (final header in response.headers.map.entries) {
  //   totalSize += header.key.length;
  //   for (final value in header.value) {
  //     totalSize += value.length;
  //   }
  //   totalSize += 4; // ": " и "\r\n"
  // }
  
  // Размер статусной строки (приблизительно)
  //totalSize += "HTTP/1.1 ${response.statusCode} ${response.statusMessage}\r\n".length;
  
  return totalSize;
}