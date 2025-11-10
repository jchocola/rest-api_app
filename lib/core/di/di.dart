import 'package:api_client/data/repository/local_storage_repository.dart';
import 'package:api_client/data/repository/secure_storage_repository.dart';
import 'package:api_client/domain/repository/secure_storage_repo_impl.dart';
import 'package:api_client/domain/repository/tostore_local_storage_impl.dart';
import 'package:api_client/main.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  // repositories
  getIt.registerLazySingleton<SecureStorageRepository>(
    () => SecureStorageRepoImpl(),
  ); // secure storage for save keys

  getIt.registerLazySingleton<LocalStorageRepository>(
    () => TostoreLocalStorageImpl(),
  ); //local storage for save response

  logger.i('Configured dependencies');
}
