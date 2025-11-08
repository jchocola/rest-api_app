import 'package:api_client/core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

///
/// LOGGER
///
final logger = Logger();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
