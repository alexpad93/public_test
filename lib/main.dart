// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timeware_test/data/model/species_model.dart';
import 'package:timeware_test/views/species_detail_screen.dart';
import 'package:timeware_test/views/home_screen.dart';
import 'package:timeware_test/views/species_list_screen.dart';

void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'species/:letter',
          builder: (BuildContext context, GoRouterState state) {
            final Map extra = state.extra as Map;

            final String letter = extra['letter'];

            final List<SpeciesModel> speciesList = extra['speciesList'];

            return SpeciesListScreen(letter: letter, speciesList: speciesList);
          },
        ),
        GoRoute(
          path: 'detail/:name',
          builder: (BuildContext context, GoRouterState state) {
            final Map extra = state.extra as Map;

            final int specieId = extra['specieId'];

            return SpecieDetailScreen(
              specieId: specieId,
            );
          },
        ),
      ],
    ),
  ],
);
