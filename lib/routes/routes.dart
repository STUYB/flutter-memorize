import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memorize/ui/layout/skeleton.dart';
import 'package:memorize/ui/pages/event_page.dart';
import 'package:memorize/ui/pages/game_page.dart';
import 'package:memorize/ui/pages/login_page.dart';
import 'package:memorize/ui/pages/score_page.dart';
import 'package:memorize/widgets/authentication_handler.dart';
import 'package:memorize/widgets/dependency_provider.dart';

getRoutes() {
  return GoRouter(routes: [
    ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            body: SafeArea(
              child: DependencyProvider(
                child: AuthenticationHandler(
                  authenticated: Skeleton(child: child),
                  login: const LoginPage(),
                ),
              ),
            ),
          );
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const GamePage(),
          ),
          GoRoute(
            path: '/score',
            builder: (context, state) => const ScorePage(),
          ),
          GoRoute(
            path: '/event',
            builder: (context, state) => const EventPage(),
          )
        ])
  ]);
}
