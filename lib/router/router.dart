import 'package:dep_finder/screen/deputat_widget.dart';
import 'package:dep_finder/screen/init_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const InitWidget();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'dep_info',
          builder: (BuildContext context, GoRouterState state) {
            return const DeputatWidget();
          },
        ),
      ],
    ),
  ],
);
