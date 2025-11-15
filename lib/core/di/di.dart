import 'package:api_client/data/repository/http_service_repository.dart';
import 'package:api_client/data/repository/local_storage_repository.dart';
import 'package:api_client/data/repository/secure_storage_repository.dart';
import 'package:api_client/domain/repository/dio_http_service_repo_impl.dart';
import 'package:api_client/domain/repository/object_box_local_storage_impl.dart';
import 'package:api_client/domain/repository/secure_storage_repo_impl.dart';

import 'package:api_client/main.dart';
import 'package:api_client/objectbox.g.dart';
import 'package:get_it/get_it.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';

final getIt = GetIt.instance;

void configureDependencies() async {
  // repositories

  getIt.registerLazySingleton<HttpServiceRepository>(
    () => DioHttpServiceRepoImpl(), // http service for make request
  );

  getIt.registerLazySingleton<SecureStorageRepository>(
    () => SecureStorageRepoImpl(),
  ); // secure storage for save keys

  final objectBoxStore = await createStoreForResponse();

  getIt.registerLazySingleton<LocalStorageRepository>(
    () => ObjectBoxLocalStorageImpl(store: objectBoxStore),
  ); //local storage for save response

  logger.i('Configured dependencies');
}

Future<Store> createStoreForResponse() async {
  final docsDir = await getApplicationDocumentsDirectory();
  final store = await openStore(directory: docsDir.path + "obx-store");

  logger.i('Store inited');
  return store;
}
