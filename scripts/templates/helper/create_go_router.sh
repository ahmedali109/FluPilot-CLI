#!/bin/bash

function create_go_router(){
 DEST_DIR="${FLUTTER_PROJECT_DIR}/lib/core/router"
 GO_ROUTER_FILE="$DEST_DIR/go_router.dart"
 WRAPPER_FILE="$DEST_DIR/wrapper.dart"
  # check if go_router dependency is in pubspec.yaml
  PUBSPEC_FILE="${FLUTTER_PROJECT_DIR}/pubspec.yaml"
  if ! grep -q "go_router:" "$PUBSPEC_FILE"; then
    echo "Adding go_router dependency to pubspec.yaml..."
    (cd "$FLUTTER_PROJECT_DIR" && flutter pub add go_router && flutter pub get)
    echo "✅ go_router dependency added to pubspec.yaml."
  else
    echo "go_router dependency already exists in pubspec.yaml."
  fi
  cat <<EOL > "$GO_ROUTER_FILE"
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'wrapper.dart';

class AppNavigation {
  AppNavigation._();

  static String home = "/home";
  static String subHome = "/home/subHome";

  // static String like = "/like";
  // static String subLike = "/like/subLike";

  // static String search = "/search";
  // static String subSearch = "/search/subSearch";

  // static String settings = "/settings";
  // static String subSetting = "/settings/subSetting";

  static String player = "/player";

  // Private navigators
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHome = GlobalKey<NavigatorState>();

  // static final _shellNavigatorLike = GlobalKey<NavigatorState>();
  // static final _shellNavigatorSearch = GlobalKey<NavigatorState>();
  // static final _shellNavigatorSettings = GlobalKey<NavigatorState>();

  // GoRouter configuration
  static final GoRouter router = GoRouter(
    initialLocation: home,
    debugLogDiagnostics: false,
    navigatorKey: _rootNavigatorKey,
    routes: [
      /// MainWrapper
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(navigationShell: navigationShell);
        },

        branches: <StatefulShellBranch>[
          /// Branch Home
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: <RouteBase>[
              GoRoute(
                path: AppNavigation.home,
                name: "Home",
                // builder: (BuildContext context, GoRouterState state) => const HomePage(),
                routes: [
                  GoRoute(
                    path: AppNavigation.subHome,
                    name: 'subHome',
                    // pageBuilder: (context, state) => CustomTransitionPage<void>(
                    //   key: state.pageKey,
                    //   child: const SubHomePage(),
                    //   transitionsBuilder:
                    //       (context, animation, secondaryAnimation, child) =>
                    //           FadeTransition(opacity: animation, child: child),
                    // ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      /// Player
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppNavigation.player,
        name: "Player",
        // builder: (context, state) => PlayerPage(key: state.pageKey),
      ),
    ],
  );
}
EOL

  cat <<EOL > "$WRAPPER_FILE"
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/google_navbar.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({required this.navigationShell, super.key});
  final StatefulNavigationShell navigationShell;

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int selectedIndex = 0;
  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(context.namedLocation('Player'));
        },
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(Icons.play_arrow),
      ),
      // Define your bottom navigation bar here
      bottomNavigationBar: GoogleNavBar(
        selectedIndex: selectedIndex,
        onTabChange: (index) {
          setState(() {
            selectedIndex = index;
          });
          _goBranch(index);
        },
      ),
    );
  }
}
EOL

  echo "📄 Created go_router.dart file successfully at $GO_ROUTER_FILE"
  echo "✅ Go router template generated successfully."
  echo "📄 Created wrapper.dart file successfully at $WRAPPER_FILE"
  echo "✅ Wrapper template generated successfully."
}

export -f create_go_router
