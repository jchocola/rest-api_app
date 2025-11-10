import 'package:api_client/data/model/key_model.dart';

abstract class SecureStorageRepository {
  // INIT PLUGINS
  Future<void> init();

  // CREATE VALUE
  Future<void> createKey({required KeyModel newKey});

  // GET ALL KEYS
  Future<List<KeyModel>> getAllKeys();

  // DELETE KEY
  Future<void> deleteKey({required KeyModel key});

  // DELETE ALL KEYS
  Future<void> deleteAllKeys();

}
