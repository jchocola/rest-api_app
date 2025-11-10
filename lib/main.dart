import 'package:api_client/bloc/bloc_providers.dart';
import 'package:api_client/core/di/di.dart';
import 'package:api_client/core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

///
/// LOGGER
///
final logger = Logger();

void main() {

  // set dependencies
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: getProviders(context),
      child: ShadApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
