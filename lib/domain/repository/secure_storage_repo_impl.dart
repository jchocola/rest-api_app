import 'package:api_client/data/model/key_model.dart';
import 'package:api_client/data/repository/secure_storage_repository.dart';
import 'package:flutter_secure_storage_x/flutter_secure_storage_x.dart';

class SecureStorageRepoImpl implements SecureStorageRepository {
  late final FlutterSecureStorage _secureStorage;

  @override
  Future<void> createKey() {
    // TODO: implement createKey
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAllKeys() {
    // TODO: implement deleteAllKeys
    throw UnimplementedError();
  }

  @override
  Future<void> deleteKey() {
    // TODO: implement deleteKey
    throw UnimplementedError();
  }

  @override
  Future<List<KeyModel>> getAllKeys() async {
    return [];
  }

  @override
  Future<void> init() async {
    _secureStorage = FlutterSecureStorage();
  }

 
}
