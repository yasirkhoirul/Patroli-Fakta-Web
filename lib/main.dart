import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:patroli_fakta/router/router_delegate.dart';
import 'package:patroli_fakta/theme/theme.dart';
import 'package:patroli_fakta/theme/util.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              Myrouterdelegate(globalKey: GlobalKey<NavigatorState>()),
        ),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");
    final routerdelegate = context.read<Myrouterdelegate>();
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
        },
      ),
      title: "Patroli Fakta",
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: Router(
        routerDelegate: routerdelegate,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
