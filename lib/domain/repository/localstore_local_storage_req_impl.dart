// ignore_for_file: camel_case_types

import 'package:api_client/data/model/request_model.dart';
import 'package:api_client/data/model/response_model.dart';
import 'package:api_client/data/repository/local_storage_repository_req.dart';
import 'package:api_client/data/repository/local_storage_repository_res.dart';
import 'package:api_client/main.dart';
import 'package:localstore/localstore.dart';

class LocalstoreLocalStorageImpl_response implements LocalStorageRepositoryReq {
  final db = Localstore.instance.collection('Requests');

  @override
  Future<void> deleteData({required RequestModel request}) async {
    try {
      await db.doc(request.id.toString()).delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<RequestModel>> getAllResponse() async {
    try {
      final items = await db.get();

      logger.i(items?.entries.length);
      return items?.entries.map((e) {
            final raw = Map<String, dynamic>.from(e.value as Map);
            raw.putIfAbsent('id', () => int.tryParse(e.key) ?? 0);
            return RequestModel.fromMap(raw);
          }).toList() ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> insertData({required RequestModel request}) async {
    try {
      await db.doc(request.id.toString()).set(request.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateData({required RequestModel request}) {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}
