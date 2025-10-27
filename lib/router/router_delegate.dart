import 'package:flutter/material.dart';
import 'package:patroli_fakta/presentation/page/admin_screen.dart';
import 'package:patroli_fakta/presentation/page/detail_screen.dart';
import 'package:patroli_fakta/presentation/page/home_screen.dart';
import 'package:patroli_fakta/presentation/page/login_screen.dart';
import 'package:patroli_fakta/presentation/page/upload_screen.dart';

class Myrouterdelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> globalKey;

  bool isStrukturOrganisasi = false;
  bool isDetail = false;
  bool isadmin = false;
  bool isupload = false;
  String? idDetail;
  List<Page> admins() => [
    MaterialPage(
      key: ValueKey("admin"),
      child: AdminScreen(
        onclickstruktur: () {
          isupload = true;
          notifyListeners();
        },
        itemgetclick: (String id) {
          isDetail = true;
          idDetail = id;
          notifyListeners();
        },
      ),
    ),
    if (idDetail != null && isDetail)
      MaterialPage(
        key: ValueKey("Detail/$idDetail"),
        child: DetailScreen(idDetail: idDetail!),
      ),
    if (isupload) MaterialPage(key: ValueKey("upload"), child: UploadScreen()),
  ];
  List<Page> guest() => [
    MaterialPage(
      key: ValueKey("home"),
      child: Homescreen(
        onclickstruktur: () {
          isStrukturOrganisasi = true;
          notifyListeners();
        },
        itemgetclick: (id) {
          isDetail = true;
          idDetail = id;
          notifyListeners();
        },
      ),
    ),
    if (isStrukturOrganisasi == true)
      MaterialPage(
        key: ValueKey("struktur_organisasi"),
        child: LoginScreen(
          signintap: () {
            isadmin = true;
            notifyListeners();
          },
        ),
      ),
    if (idDetail != null && isDetail)
      MaterialPage(
        key: ValueKey("Detail/$idDetail"),
        child: DetailScreen(idDetail: idDetail!),
      ),
  ];
  Myrouterdelegate({required this.globalKey});
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: isadmin ? admins() : guest(),
      onDidRemovePage: (page) {
        if (isStrukturOrganisasi == true) {
          if (page.key == ValueKey("struktur_organisasi")) {
            isStrukturOrganisasi = false;
            notifyListeners();
          }
        }
        if (idDetail != null && isDetail) {
          idDetail = null;
          isDetail = false;
          notifyListeners();
        }
        if (isadmin && page.key == ValueKey("admin")) {
          isadmin = false;
          notifyListeners();
        }
        if (isupload) {
          isupload = false;
          notifyListeners();
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
