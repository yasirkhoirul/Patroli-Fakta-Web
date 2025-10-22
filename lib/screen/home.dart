import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patroli_fakta/data/homedata.dart';
import 'package:patroli_fakta/widget/card_berita.dart';
import 'package:patroli_fakta/widget/fadein.dart';
import 'package:patroli_fakta/widget/frostbox.dart';

class Homescreen extends StatelessWidget {
  final spasiempat = const SizedBox(height: 40);
  final Function() onclickstruktur;
  const Homescreen({super.key, required this.onclickstruktur});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
      ),
      body: SafeArea(
        child: CustomScrollView(
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
                  onPressed: onclickstruktur,
                  child: const Text("ke struktur"),
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
              child: FadeInWidget(
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      spasiempat,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Patroli Fakta",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                  selectionColor: Theme.of(
                                    context,
                                  ).colorScheme.primary,
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
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SliverList.builder(
              itemCount: 10,
              itemBuilder: (context, index) => ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 700,
                  maxWidth: 1200,
                  minHeight: 600,
                  minWidth: 200,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: FadeInWidget(child: CardBerita()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
