import 'package:api_client/presentation/home_page/home_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  
  initialLocation: '/home',

  routes: [
    GoRoute(path: '/home', builder: (context, state) => const HomePage()),
  ],
);
