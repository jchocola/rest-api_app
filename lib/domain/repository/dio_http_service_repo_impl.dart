import 'package:api_client/data/model/request_model.dart';
import 'package:api_client/data/repository/http_service_repository.dart';
import 'package:api_client/main.dart';
import 'package:dio/dio.dart';

class DioHttpServiceRepoImpl implements HttpServiceRepository {
  final Dio dio = Dio();

  @override
  Future<void> makeDELETErequest({required RequestModel request}) {
    // TODO: implement makeDELETErequest
    throw UnimplementedError();
  }

  @override
  Future<Response> makeGETrequest({required RequestModel request}) async {
    try {
      final path = request.url;
      final queryParameters = request.queryParameters;
      final options = Options(headers: request.headers);

      final Response response = await dio.get(
        path,
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
  Future<void> makeHEADrequest({required RequestModel request}) {
    // TODO: implement makeHEADrequest
    throw UnimplementedError();
  }

  @override
  Future<void> makeOPTIONSrequest({required RequestModel request}) {
    // TODO: implement makeOPTIONSrequest
    throw UnimplementedError();
  }

  @override
  Future<void> makePATCHrequest({required RequestModel request}) {
    // TODO: implement makePATCHrequest
    throw UnimplementedError();
  }

  @override
  Future<void> makePOSTrequest({required RequestModel request}) async{
   // await dio.post(path)
    throw UnimplementedError();
  }

  @override
  Future<void> makePUTrequest({required RequestModel request}) {
    // TODO: implement makePUTrequest
    throw UnimplementedError();
  }
}
