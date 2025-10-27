import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/web.dart';
import 'package:lottie/lottie.dart';
import 'package:patroli_fakta/data/data_source/staticdata/staticdata.dart';
import 'package:patroli_fakta/presentation/provider/berita_list_notifier.dart';
import 'package:patroli_fakta/presentation/widget/card_berita.dart';
import 'package:patroli_fakta/presentation/widget/fadein.dart';

import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  final Function() onclickstruktur;
  const Homescreen({super.key, required this.onclickstruktur});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final spasiempat = const SizedBox(height: 40);

  @override
  void initState() {
    super.initState();
    context.read<BeritaListNotifier>().fetchdatalistberita();
  }

  @override
  Widget build(BuildContext context) {
    final colortheme = Theme.of(context).colorScheme;
    return Scaffold(
      drawer: Builder(
        builder: (context) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                Text(
                  "Patroli Fakta",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 10),
                Divider(height: 1),
                SizedBox(height: 5),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  leading: FaIcon(FontAwesomeIcons.instagram, size: 32),
                  title: const Text("Instagram"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  leading: FaIcon(FontAwesomeIcons.twitter, size: 32),
                  title: const Text("Twitter"),
                ),
              ],
            ),
          );
        }
      ),
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
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  title: Text(
                    "Patroli Fakta",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),

                  actions: [
                    OutlinedButton(
                      onPressed: widget.onclickstruktur,
                      child: const Text("ke struktur"),
                    ),
                  ],
                  expandedHeight: 500,
                  flexibleSpace: const FlexibleSpaceBar(
                    centerTitle: true,
                    background: Image(
                      image: AssetImage(
                        "assets/images/background/background.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverList.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return ClipRect(
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    spasiempat,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Patroli Fakta",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayLarge!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                selectionColor: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                              ),
                                              const Text(
                                                "Masyarakat Anti Fitnah",
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Tentang Kami",
                                                style: TextStyle(
                                                  fontSize: 34,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                Homedata.deskripsitentangkami,
                                                textAlign: TextAlign.start,
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.bodyMedium,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    spasiempat,
                                    spasiempat,
                                    Divider(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (index == 1) {
                      return FadeInWidget(
                        child: Padding(
                          padding: EdgeInsets.all(40),
                          child: Card(
                            elevation: 20,
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "TENTANG WEBSITE KAMI",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.displayMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    Homedata.deskripsitentangwebsite,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (index == 2) {
                      return FadeInWidget(
                        child: Padding(
                          padding: EdgeInsets.all(50),
                          child: Center(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "LIHAT BERITA TERBARU KAMI \n SCROLL KE BAWAH",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                            ),
                                        textAlign: TextAlign.center,
                                      ),
                                      spasiempat,
                                      Lottie.asset(
                                        'assets/lottie/arrow_down.json',
                                        width: 200,
                                        height: 200,
                                        repeat: true,
                                        reverse: false,
                                        animate: true,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Lottie.asset(
                                    'assets/lottie/news.json',
                                    width: 500,
                                    height: 500,
                                    repeat: true,
                                    reverse: false,
                                    animate: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }else{
                      return Container();
                    }
                  },
                ),
                
                Consumer<BeritaListNotifier>(
                  builder: (context,value,child) {
                    Logger().d(value.listberita.length);
                    return SliverList.builder(
                      itemCount: value.listberita.length,
                      itemBuilder: (context, index) => ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 700,
                          maxWidth: 1200,
                          minHeight: 600,
                          minWidth: 200,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(50),
                          child: FadeInWidget(child: CardBerita(data: value.listberita[index],)),
                        ),
                      ),
                    );
                  }
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
