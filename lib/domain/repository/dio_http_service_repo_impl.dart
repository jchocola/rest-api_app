import 'package:api_client/data/model/request_model.dart';
import 'package:api_client/data/repository/http_service_repository.dart';
import 'package:api_client/main.dart';
import 'package:dio/dio.dart';

class DioHttpServiceRepoImpl implements HttpServiceRepository {
  final Dio dio = Dio();

  @override
  Future<void> makeDELETErequest() {
    // TODO: implement makeDELETErequest
    throw UnimplementedError();
  }

  @override
  Future<void> makeGETrequest({required RequestModel request}) async {
    try {
      final path = request.url;
      final queryParameters = request.queryParameters;
      final options = Options(headers: {});

      final Response response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );

      logger.i(response.data.toString());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> makeHEADrequest() {
    // TODO: implement makeHEADrequest
    throw UnimplementedError();
  }

  @override
  Future<void> makeOPTIONSrequest() {
    // TODO: implement makeOPTIONSrequest
    throw UnimplementedError();
  }

  @override
  Future<void> makePATCHrequest() {
    // TODO: implement makePATCHrequest
    throw UnimplementedError();
  }

  @override
  Future<void> makePOSTrequest() {
    // TODO: implement makePOSTrequest
    throw UnimplementedError();
  }

  @override
  Future<void> makePUTrequest() {
    // TODO: implement makePUTrequest
    throw UnimplementedError();
  }
}
