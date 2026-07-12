import 'package:flutter/material.dart';
import 'package:patroli_fakta/presentation/page/admin_screen.dart';
import 'package:patroli_fakta/presentation/page/detail_screen.dart';
import 'package:patroli_fakta/presentation/page/home_screen.dart';
import 'package:patroli_fakta/presentation/page/login_screen.dart';
import 'package:patroli_fakta/presentation/page/upload_screen.dart';
import 'package:patroli_fakta/presentation/page/verified_news_screen.dart';
import 'package:patroli_fakta/presentation/page/cek_fakta_screen.dart';
import 'package:patroli_fakta/presentation/widget/shared_drawer.dart';
import 'package:provider/provider.dart';
import 'package:patroli_fakta/presentation/provider/login_notifier.dart';

class Myrouterdelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> globalKey;

  bool isStrukturOrganisasi = false;
  bool isDetail = false;
  bool isadmin = false;
  bool isupload = false;
  bool isVerifiedNews = false;
  bool isCekFakta = false;
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
        onVerifiedNewsTap: () {
          isVerifiedNews = true;
          notifyListeners();
        },
        onCekFaktaTap: () {
          isCekFakta = true;
          notifyListeners();
        },
      ),
    ),
    if (idDetail != null && isDetail)
      MaterialPage(
        key: ValueKey("Detail/$idDetail"),
        child: DetailScreen(idDetail: idDetail!),
      ),
    if (isVerifiedNews == true)
      MaterialPage(
        key: ValueKey("verified_news"),
        child: VerifiedNewsScreen(
          isAdmin: true,
          onclickstruktur: () {
            isupload = true;
            notifyListeners();
          },
          itemgetclick: (id) {
            isDetail = true;
            idDetail = id;
            notifyListeners();
          },
        ),
      ),
    if (isCekFakta == true)
      MaterialPage(
        key: ValueKey("cek_fakta"),
        child: CekFaktaScreen(
          isAdmin: true,
          onclickstruktur: () {
            isupload = true;
            notifyListeners();
          },
          itemgetclick: (id) {
            isDetail = true;
            idDetail = id;
            notifyListeners();
          },
        ),
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
        onVerifiedNewsTap: () {
          isVerifiedNews = true;
          notifyListeners();
        },
        onCekFaktaTap: () {
          isCekFakta = true;
          notifyListeners();
        },
      ),
    ),
    if (isVerifiedNews == true)
      MaterialPage(
        key: ValueKey("verified_news"),
        child: VerifiedNewsScreen(
          isAdmin: false,
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
    if (isCekFakta == true)
      MaterialPage(
        key: ValueKey("cek_fakta"),
        child: CekFaktaScreen(
          isAdmin: false,
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
            // Reset semua state guest, langsung ke admin
            isadmin = true;
            isStrukturOrganisasi = false;
            isVerifiedNews = false;
            isCekFakta = false;
            isDetail = false;
            idDetail = null;
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
    return Scaffold(
      drawer: SharedDrawer(
        isAdmin: isadmin,
        onHomeTap: () {
          if (isadmin) {
            isupload = false;
            isDetail = false;
            idDetail = null;
          } else {
            isVerifiedNews = false;
            isCekFakta = false;
            isDetail = false;
            idDetail = null;
          }
          notifyListeners();
        },
        onVerifiedNewsTap: () {
          if (!isadmin) {
            isVerifiedNews = true;
            isCekFakta = false;
            isDetail = false;
            idDetail = null;
          }
          notifyListeners();
        },
        onCekFaktaTap: () {
          if (!isadmin) {
            isCekFakta = true;
            isVerifiedNews = false;
            isDetail = false;
            idDetail = null;
          }
          notifyListeners();
        },
        onLogoutTap: () {
          context.read<LoginNotifier>().logout();
          isadmin = false;
          isVerifiedNews = false;
          isCekFakta = false;
          isupload = false;
          isDetail = false;
          idDetail = null;
          notifyListeners();
        },
      ),
      body: Navigator(
        key: navigatorKey,
        pages: isadmin ? admins() : guest(),
        onDidRemovePage: (page) {
          if (isStrukturOrganisasi == true) {
            if (page.key == ValueKey("struktur_organisasi")) {
              isStrukturOrganisasi = false;
              notifyListeners();
            }
          }
          if (isVerifiedNews == true) {
            if (page.key == ValueKey("verified_news")) {
              isVerifiedNews = false;
              notifyListeners();
            }
          }
          if (isCekFakta == true) {
            if (page.key == ValueKey("cek_fakta")) {
              isCekFakta = false;
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
      ),
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => globalKey;

  @override
  Future<void> setNewRoutePath(configuration) {
    return Future.value(null);
  }
}







