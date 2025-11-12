import 'package:api_client/data/model/request_model.dart';
import 'package:dio/dio.dart';

abstract class HttpServiceRepository {
  Future<Response> makeGETrequest({required RequestModel request});

  Future<void> makePOSTrequest({required RequestModel request});

  Future<void> makePUTrequest({required RequestModel request});

  Future<void> makePATCHrequest({required RequestModel request});

  Future<void> makeDELETErequest({required RequestModel request});

  Future<void> makeOPTIONSrequest({required RequestModel request});

  Future<void> makeHEADrequest({required RequestModel request});
}
