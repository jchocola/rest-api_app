import 'package:api_client/data/model/request_model.dart';
import 'package:api_client/data/repository/http_service_repository.dart';
import 'package:api_client/main.dart';
import 'package:dio/dio.dart';

class DioHttpServiceRepoImpl implements HttpServiceRepository {
  final Dio dio = Dio();

  @override
  Future<Response> makeDELETErequest({required RequestModel request}) async {
    try {
      final path = request.url; // url
      final queryParameters = request.queryParameters; // query parameters
      final options = Options(headers: request.headers);

      final Response response = await dio.delete(
        path,
        data: request.body,
        queryParameters: queryParameters,
        options: options,
      );

      logger.i(response.data.toString());

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> makeGETrequest({required RequestModel request}) async {
    try {
      final path = request.url; // url
      final queryParameters = request.queryParameters; // query parameters
      final options = Options(headers: request.headers);

      final Response response = await dio.get(
        path,
        data: request.body,
        queryParameters: queryParameters,
        options: options,
      );

      logger.i(response.data.toString());

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> makeHEADrequest({required RequestModel request}) async {
    try {
      final path = request.url; // url
      final queryParameters = request.queryParameters; // query parameters
      final options = Options(headers: request.headers);

      final Response response = await dio.head(
        path,
        data: request.body,
        queryParameters: queryParameters,
        options: options,
      );

      logger.i(response.data.toString());

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> makeOPTIONSrequest({required RequestModel request}) async {
    try {
      final path = request.url; // url
      final queryParameters = request.queryParameters; // query parameters
      final options = Options(headers: request.headers);

      final Response response = await dio.head(
        path,
        data: request.body,
        queryParameters: queryParameters,
        options: options,
      );

      logger.i(response.data.toString());

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> makePATCHrequest({required RequestModel request}) async {
    try {
      final path = request.url; // url
      final queryParameters = request.queryParameters; // query parameters
      final options = Options(headers: request.headers);

      final Response response = await dio.patch(
        path,
        data: request.body,
        queryParameters: queryParameters,
        options: options,
      );

      logger.i(response.data.toString());

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> makePOSTrequest({required RequestModel request}) async {
    try {
      final path = request.url; // url
      final queryParameters = request.queryParameters; // query parameters
      final options = Options(headers: request.headers);

      final Response response = await dio.post(
        path,
        data: request.body,
        queryParameters: queryParameters,
        options: options,
      );

      logger.i(response.data.toString());

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> makePUTrequest({required RequestModel request}) async {
    try {
      final path = request.url; // url
      final queryParameters = request.queryParameters; // query parameters
      final options = Options(headers: request.headers);

      final Response response = await dio.put(
        path,
        data: request.body,
        queryParameters: queryParameters,
        options: options,
      );

      logger.i(response.data.toString());

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
