import 'package:api_client/bloc/home_bloc.dart';
import 'package:api_client/bloc/key_bloc.dart';
import 'package:api_client/core/di/di.dart';
import 'package:api_client/data/repository/secure_storage_repository.dart';
import 'package:api_client/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

getProviders(BuildContext context) {
  logger.i('Get Providers');

  return [
    BlocProvider(create: (context)=> HomeBloc()..add(HomeBlocEvent_Init())),

    BlocProvider(
      create: (context) =>
          KeyBloc(secureRepository: getIt<SecureStorageRepository>())..add(KeyBlocEvent_loadKeys()),
    ),
  ];
}
