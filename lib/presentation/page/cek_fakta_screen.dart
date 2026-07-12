import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:patroli_fakta/presentation/provider/unverified_berita_list_notifier.dart';
import 'package:patroli_fakta/presentation/provider/removeberita_notifier.dart';
import 'package:patroli_fakta/presentation/provider/status_provider.dart';
import 'package:patroli_fakta/presentation/widget/dialogmanager.dart';
import 'package:patroli_fakta/presentation/widget/card_berita.dart';
import 'package:patroli_fakta/presentation/widget/fadein.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:patroli_fakta/data/data_source/staticdata/staticdata.dart';
import 'dart:ui';

class CekFaktaScreen extends StatefulWidget {
  final bool isAdmin;
  final Function(String id) itemgetclick;
  final Function() onclickstruktur;
  const CekFaktaScreen({
    super.key,
    this.isAdmin = false,
    required this.onclickstruktur,
    required this.itemgetclick,
  });

  @override
  State<CekFaktaScreen> createState() => _CekFaktaScreenState();
}

class _CekFaktaScreenState extends State<CekFaktaScreen> {
  final spasiempat = const SizedBox(height: 40);

  late RemoveberitaNotifier beritanotifier;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UnverifiedBeritaListNotifier>().fetchdatalistberita();
      beritanotifier = context.read<RemoveberitaNotifier>();
      beritanotifier.addListener(_onstateschange);
    });
  }

  void _onstateschange() {
    final state = beritanotifier.status;
    switch (state) {
      case StatusIsloading():
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (!context.mounted) return;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const StatusDialogManagerAdmin(),
          );
        });
        break;
      case Issuksesmessage():
        context.read<UnverifiedBeritaListNotifier>().fetchdatalistberita();
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    beritanotifier.removeListener(_onstateschange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colortheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colortheme.outlineVariant, colortheme.onTertiary],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
            LayoutBuilder(
              builder: (context, constrain) {
                final width = constrain.biggest.width;
                if (width > 850) {
                  return WebDesign(
                    widget: widget,
                    spasiempat: spasiempat,
                    isWeb: true,
                  );
                } else {
                  return WebDesign(
                    widget: widget,
                    spasiempat: spasiempat,
                    isWeb: false,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class WebDesign extends StatefulWidget {
  final bool isWeb;
  const WebDesign({
    super.key,
    required this.widget,
    required this.spasiempat,
    required this.isWeb,
  });

  final CekFaktaScreen widget;
  final SizedBox spasiempat;

  @override
  State<WebDesign> createState() => _WebDesignState();
}

class _WebDesignState extends State<WebDesign> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          title: Text(
            "Cek Berita Fakta",
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          actions: [
            OutlinedButton(
              onPressed: widget.widget.onclickstruktur,
              child: const Text("Login"),
            ),
          ],
          expandedHeight: 500,
          flexibleSpace: const FlexibleSpaceBar(
            centerTitle: true,
            background: Image(
              image: AssetImage("assets/images/background/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ClipRect(
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Lottie.asset(
                    "assets/lottie/backgroundline.json",
                    repeat: true,
                    reverse: false,
                    fit: BoxFit.contain,
                    width: 500,
                    height: 400,
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(),
                ),
                FadeInWidget(
                  child: Padding(
                    padding: EdgeInsets.all(50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.spasiempat,
                        widget.isWeb
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: header(),
                              )
                            : ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 900),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: header(),
                                ),
                              ),
                        widget.spasiempat,
                        widget.spasiempat,
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Consumer<UnverifiedBeritaListNotifier>(
          builder: (context, value, child) {
            Logger().d(value.listberita.length);
            return value.listberita.isEmpty
                ? SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(child: Text("Tidak Ada Berita Terbaru")),
                    ),
                  )
                : SliverList.builder(
                    itemCount: value.listberita.length,
                    itemBuilder: (context, index) => ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 700,
                        maxWidth: 1200,
                        minHeight: 600,
                        minWidth: 200,
                      ),
                      child: Padding(
                        padding: widget.isWeb
                            ? const EdgeInsets.symmetric(
                                vertical: 50,
                                horizontal: 50,
                              )
                            : const EdgeInsets.symmetric(
                                vertical: 50,
                                horizontal: 10,
                              ),
                        child: FadeInWidget(
                          child: CardBerita(
                            isweb: widget.isWeb,
                            data: value.listberita[index],
                            itemgetclick: (id) {
                              widget.widget.itemgetclick(id);
                            },
                            isadmin: widget.widget.isAdmin,
                            deleteclick: (String id) { context.read<RemoveberitaNotifier>().deleteberita(id); },
                          ),
                        ),
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }

  List<Widget> header() => [
    Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cek Berita Fakta",
            style: Theme.of(
              context,
            ).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold),
            selectionColor: Theme.of(context).colorScheme.primary,
          ),
          const Text("Masyarakat Anti Fitnah"),
        ],
      ),
    ),
    Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tentang Kami",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 10),
          Text(
            Homedata.deskripsitentangkami,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    ),
  ];
}




