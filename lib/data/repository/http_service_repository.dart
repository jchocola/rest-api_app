import 'package:api_client/data/model/request_model.dart';
import 'package:dio/dio.dart';

abstract class HttpServiceRepository {
  Future<Response> makeGETrequest({required RequestModel request});

  Future<Response> makePOSTrequest({required RequestModel request});

  Future<Response> makePUTrequest({required RequestModel request});

  Future<Response> makePATCHrequest({required RequestModel request});

  Future<Response> makeDELETErequest({required RequestModel request});

  Future<Response> makeOPTIONSrequest({required RequestModel request});

  Future<Response> makeHEADrequest({required RequestModel request});
}
