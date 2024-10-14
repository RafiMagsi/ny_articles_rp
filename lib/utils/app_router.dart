import 'package:go_router/go_router.dart';
import 'package:ny_articles_rp/views/home_view.dart';
import 'package:ny_articles_rp/views/products_view.dart';

// GoRouter configuration
final app_router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'home', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/',
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      name: 'products',
      path: '/products',
      builder: (context, state) => const ProductsView(),
    ),
  ],
);
