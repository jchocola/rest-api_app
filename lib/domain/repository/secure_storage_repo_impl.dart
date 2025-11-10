import 'package:api_client/data/model/key_model.dart';
import 'package:api_client/data/repository/secure_storage_repository.dart';
import 'package:api_client/main.dart';
import 'package:flutter_secure_storage_x/flutter_secure_storage_x.dart';

class SecureStorageRepoImpl implements SecureStorageRepository {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  Future<void> createKey({required KeyModel newKey}) async {
    try {
      await _secureStorage.write(key: newKey.name, value: newKey.value);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAllKeys() async {
    try {
      await _secureStorage.deleteAll();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteKey({required KeyModel key}) async {
    try {
      await _secureStorage.delete(key: key.name);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<KeyModel>> getAllKeys() async {
    final keys = await _secureStorage.readAll();
    logger.i('Loaded keys : ${keys.keys}');

    List<KeyModel> loadedKeys = [];

    for (var index = 0; index < keys.length; index++) {
      loadedKeys.add(
        KeyModel(
          name: keys.keys.elementAt(index),
          value: keys.values.elementAt(index),
        ),
      );
    }

    return loadedKeys;
  }

  @override
  Future<void> init() async {}
}
