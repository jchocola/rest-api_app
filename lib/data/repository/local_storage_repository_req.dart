import 'package:api_client/data/model/request_model.dart';


abstract class LocalStorageRepositoryReq {
  Future<void> insertData({required RequestModel request});

  Future<void> updateData({required RequestModel request});

  Future<void> deleteData({required RequestModel request});

  Future<List<RequestModel>> getAllResponse();
}
