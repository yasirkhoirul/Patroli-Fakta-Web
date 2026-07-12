import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patroli_fakta/presentation/provider/berita_list_notifier.dart';
import 'package:provider/provider.dart';

class SharedDrawer extends StatelessWidget {
  final bool isAdmin;
  final VoidCallback? onHomeTap;
  final VoidCallback? onVerifiedNewsTap;
  final VoidCallback? onCekFaktaTap;
  final VoidCallback? onLogoutTap;

  const SharedDrawer({
    super.key,
    this.onHomeTap,
    this.onVerifiedNewsTap,
    this.onCekFaktaTap,
    this.onLogoutTap,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
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
              if (onHomeTap != null) onHomeTap!();
            },
            leading: Icon(Icons.home, size: 32),
            title: const Text("Beranda"),
          ),
          if (!isAdmin) ListTile(
            onTap: () {
              Navigator.pop(context);
              if (onVerifiedNewsTap != null) onVerifiedNewsTap!();
            },
            leading: Icon(Icons.verified, size: 32),
            title: const Text("Berita Terverifikasi"),
          ),
          if (!isAdmin) ListTile(
            onTap: () {
              Navigator.pop(context);
              if (onCekFaktaTap != null) onCekFaktaTap!();
            },
            leading: Icon(Icons.fact_check, size: 32),
            title: const Text("Cek Berita Fakta"),
          ),
          ListTile(
            onTap: () async {
              context.read<BeritaListNotifier>().goInstagram();
              Navigator.pop(context);
            },
            leading: FaIcon(FontAwesomeIcons.instagram, size: 32),
            title: const Text("Instagram"),
          ),
          ListTile(
            onTap: () {
              context.read<BeritaListNotifier>().gotwitter();
              Navigator.pop(context);
            },
            leading: FaIcon(FontAwesomeIcons.twitter, size: 32),
            title: const Text("Twitter"),
          ),
          if (isAdmin) ListTile(
            onTap: () {
              Navigator.pop(context);
              if (onLogoutTap != null) onLogoutTap!();
            },
            leading: Icon(Icons.logout, size: 32),
            title: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}





