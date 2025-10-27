import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:patroli_fakta/presentation/provider/berita_detail_notifier.dart';
import 'package:patroli_fakta/presentation/provider/status_provider.dart';
import 'package:patroli_fakta/presentation/widget/frostbox.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final String idDetail;
  const DetailScreen({super.key, required this.idDetail});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Logger().d("id detailnya ada al ${widget.idDetail}");
      context.read<BeritaDetailNotifier>().getDetail(widget.idDetail);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Logger().d("data id dari detail ${widget.idDetail}");
    return Scaffold(
      body: SafeArea(
        child: Consumer<BeritaDetailNotifier>(
          builder: (context, value, child) {
            return switch (value.status) {
              StatusIsloading() => Center(child: CircularProgressIndicator()),
              Iserror(message: var message) => AlertDialog(
                title: Text("terjadi kesalahan tak terduga $message"),
                content: Icon(Icons.error),
              ),
              IsuksesDetail(data: var data) => CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text(
                      "Patroli Fakta",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    expandedHeight: 500,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.only(bottom: 20),
                      title: Frostbox(
                        height: 200,
                        width: 1080,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text(data.judul,style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: Theme.of(context).colorScheme.shadow
                          ),)),
                        ),
                      ),
                      centerTitle: true,
                      background: Hero(
                        tag: widget.idDetail,
                        child: Image(
                          image: AssetImage(
                            "assets/images/background/background.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Flexible(child: Text(data.deskripsi)),
                    ),
                  ),
                ],
              ),
              _ => Container()
            };
          },
        ),
      ),
    );
  }
}
