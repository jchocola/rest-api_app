import 'package:api_client/data/model/request_model.dart';

abstract class HttpServiceRepository {
  Future<void> makeGETrequest({required RequestModel request});

  Future<void> makePOSTrequest();

  Future<void> makePUTrequest();

  Future<void> makePATCHrequest();

  Future<void> makeDELETErequest();

  Future<void> makeOPTIONSrequest();

  Future<void> makeHEADrequest();
}
