import 'package:flutter/material.dart';
import 'package:patroli_fakta/screen/home.dart';
import 'package:patroli_fakta/screen/struktur_organisasi.dart';

class Myrouterdelegate extends RouterDelegate with ChangeNotifier, PopNavigatorRouterDelegateMixin{
  final GlobalKey<NavigatorState> globalKey;

  bool isStrukturOrganisasi = false;
  
  Myrouterdelegate({required this.globalKey});
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey("home"),
          child: Homescreen(
            onclickstruktur: (){
              isStrukturOrganisasi = true;
              notifyListeners();
            },
          )
        ),
        if(isStrukturOrganisasi == true)
        MaterialPage(
          key: ValueKey("struktur_organisasi"),
          child: StrukturOrganisasi()
        )
      ],
      onDidRemovePage: (page) {
        if(isStrukturOrganisasi == true){
          if(page.key == ValueKey("struktur_organisasi")){
            isStrukturOrganisasi = false;
            notifyListeners();
          }
        }
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => globalKey;

  @override
  Future<void> setNewRoutePath(configuration) {
    throw UnimplementedError();
  }
}