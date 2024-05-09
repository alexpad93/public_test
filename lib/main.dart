// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.brown,
        primaryColor: Colors.brown.shade400,
        appBarTheme: AppBarTheme(
          color: Colors.brown.shade400,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.brown.shade400,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.brown.shade400,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
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
            final String letter = state.pathParameters['letter']!.toUpperCase();

            return SpeciesListScreen(letter: letter);
          },
        ),
        GoRoute(
          path: 'detail/:specieId',
          builder: (BuildContext context, GoRouterState state) {
            Map extra = {};
            String specieName = "No Name";
            late int specieId;

            if (state.extra != null) {
              extra = state.extra as Map;
              specieName = extra['specieName'];
            }

            try {
              specieId = int.parse(state.pathParameters['specieId']!);
            } catch (E) {
              specieId = -1;
            }

            return SpecieDetailScreen(
              specieName: specieName,
              specieId: specieId,
            );
          },
        ),
      ],
    ),
  ],
);
