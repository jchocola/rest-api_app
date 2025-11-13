import 'package:api_client/data/model/response_model.dart';
import 'package:api_client/data/repository/local_storage_repository.dart';
import 'package:api_client/main.dart';
import 'package:api_client/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';

class ObjectBoxLocalStorageImpl implements LocalStorageRepository {
  late final Store store;
  final Box responseBox;
  ObjectBoxLocalStorageImpl({required this.store})
    : responseBox = store.box<ResponseModel>();

  @override
  Future<void> deleteData({required ResponseModel response}) async {
    try {
       responseBox.remove(response.id);
      logger.i('Deleted response');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ResponseModel>> getAllResponse() async {
    try {
      logger.i(responseBox.count());
      final responses = responseBox.getAll() as List<ResponseModel>;
      return responses;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> insertData({required ResponseModel response}) async {
    try {
      responseBox.put(response);
      logger.i('Inserted new Data');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateData({required ResponseModel response}) {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}
