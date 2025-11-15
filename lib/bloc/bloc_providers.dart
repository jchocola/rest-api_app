import 'package:api_client/bloc/home_bloc.dart';
import 'package:api_client/bloc/key_bloc.dart';
import 'package:api_client/bloc/request_bloc.dart';
import 'package:api_client/bloc/response_page_bloc.dart';
import 'package:api_client/bloc/history_bloc.dart';
import 'package:api_client/core/di/di.dart';
import 'package:api_client/data/repository/http_service_repository.dart';
import 'package:api_client/data/repository/local_storage_repository_res.dart';
import 'package:api_client/data/repository/secure_storage_repository.dart';

import 'package:api_client/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

getProviders(BuildContext context) {
  logger.i('Get Providers');

  return [
    BlocProvider(
      create: (context) => HistoryBloc(
        responsesLocalStorageRepo: getIt.get<LocalStorageRepositoryRes>(),
      )..add(HistoryBlocEvent_init()),
    ),

    BlocProvider(
      create: (context) => RequestBloc(
        httpServiceRepository: getIt.get<HttpServiceRepository>(),
      ),
    ),

    BlocProvider(
      create: (context) => ResponsePageBloc()..add(ResponsePageEvent_init()),
    ),

    BlocProvider(create: (context) => HomeBloc()..add(HomeBlocEvent_Init())),

    BlocProvider(
      create: (context) =>
          KeyBloc(secureRepository: getIt<SecureStorageRepository>())
            ..add(KeyBlocEvent_loadKeys()),
    ),
  ];
}
