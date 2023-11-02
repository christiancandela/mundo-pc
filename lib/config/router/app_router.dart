import 'package:dev_tesis/ui/pages/screen_home/home.dart';
import 'package:dev_tesis/ui/pages/screen_welcome/welcome.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const welcome(),
    ),
    GoRoute(
      path: '/inicio',
      builder: (context, state) => const Home(),
    ),
  ],
);
