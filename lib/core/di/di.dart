import 'package:api_client/data/repository/secure_storage_repository.dart';
import 'package:api_client/domain/repository/secure_storage_repo_impl.dart';
import 'package:api_client/main.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  // repositories
  getIt.registerLazySingleton<SecureStorageRepository>(
    () => SecureStorageRepoImpl(),
  ); // secure storage

  logger.i('Configured dependencies');
}
