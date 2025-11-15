import 'package:api_client/data/model/response_model.dart';
import 'package:api_client/data/repository/local_storage_repository.dart';
import 'package:api_client/main.dart';
import 'package:localstore/localstore.dart';

class LocalstoreLocalStorageImpl implements LocalStorageRepository {
  final db = Localstore.instance.collection('Responses');

  @override
  Future<void> deleteData({required ResponseModel response}) async {
    try {
      await db.doc(response.id.toString()).delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ResponseModel>> getAllResponse() async {
    try {
      final items = await db.get();

      logger.i(items?.entries.length);
      return items?.entries.map((e) {
            final raw = Map<String, dynamic>.from(e.value as Map);
            raw.putIfAbsent('id', () => int.tryParse(e.key) ?? 0);
            return ResponseModel.fromMap(raw);
          }).toList() ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> insertData({required ResponseModel response}) async {
    try {
      await db.doc(response.id.toString()).set(response.toMap());
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
