import 'package:flutter/material.dart';
import 'package:googdocc/screens/auth/login_page.dart';
import 'package:googdocc/screens/homepage/home_page.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(
    onUnknownRoute: (path) => const MaterialPage(
          child: LoginPage(),
        ),
    routes: {
      '/': (route) => const MaterialPage(
            child: LoginPage(),
          ),
    });

final loggedInRoute = RouteMap(
    onUnknownRoute: (path) => const MaterialPage(
          child: LoginPage(),
        ),
    routes: {
      '/': (route) => const MaterialPage(
            child: HomePage(),
          ),
    });
