import 'package:flutter/material.dart';
import 'package:patroli_fakta/router/router_delegate.dart';
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
    final routerdelegate = context.read<Myrouterdelegate>();
    return MaterialApp(
      title: "Patroli Fakta",
      home: Router(
        routerDelegate: routerdelegate,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
