import 'package:api_client/data/model/response_model.dart';

abstract class LocalStorageRepository {
  Future<void> insertData({required ResponseModel response});

  Future<void> updateData({required ResponseModel response});

  Future<void> deleteData({required ResponseModel response});

  Future<List<ResponseModel>> getAllResponse();
  
}
