import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:patroli_fakta/data/data_source/supabase/statickey.dart';
import 'package:patroli_fakta/locator.dart';
import 'package:patroli_fakta/presentation/provider/berita_list_notifier.dart';
import 'package:patroli_fakta/router/router_delegate.dart';
import 'package:patroli_fakta/theme/theme.dart';
import 'package:patroli_fakta/theme/util.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'locator.dart' as lc;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: Keysupabase.url, anonKey: Keysupabase.anonpublic);
  lc.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              Myrouterdelegate(globalKey: GlobalKey<NavigatorState>()),
        ),
        ChangeNotifierProvider(create: 
          (context) => getit.get<BeritaListNotifier>(),
        )
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
