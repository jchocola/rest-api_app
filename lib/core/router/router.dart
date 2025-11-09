import 'package:api_client/presentation/faq_page/faq_page.dart';
import 'package:api_client/presentation/home_page/home_page.dart';
import 'package:api_client/presentation/key_page/key_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  
  initialLocation: '/home',

  routes: [
    GoRoute(path: '/home', builder: (context, state) => const HomePage()),

    GoRoute(path: '/keys', builder: (context,state)=> const KeyPage()),

    GoRoute(path: '/faq' , builder: (context,state)=> const FAQPage())
  ],
);
