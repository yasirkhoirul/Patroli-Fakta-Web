import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:patroli_fakta/domain/entities/berita_entities.dart';
import 'package:patroli_fakta/presentation/widget/frostbox.dart';

class CardBerita extends StatelessWidget {
  final bool isadmin;
  final bool isweb;
  final void Function(String id) itemgetclick;
  final void Function(String id) deleteclick;
  final BeritaEntities data;
  const CardBerita({
    super.key,
    required this.data,
    required this.itemgetclick,
    required this.isweb,
    required this.isadmin,
    required this.deleteclick,
  });
  @override
  Widget build(BuildContext context) {
    return Frostbox(
      height: 300,
      width: 200,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: isweb
            ? DesignWeb(
                data: data,
                itemgetclick: itemgetclick,
                isadmin: isadmin,
                isdelete: isadmin
                    ? (id) {
                        deleteclick(id);
                      }
                    : (id) {},
              )
            : DesignMobile(
                data: data,
                itemgetclick: itemgetclick,
                isadmin: isadmin,
                isdelete: isadmin
                    ? (id) {
                        Logger().d("delete diklik");
                        deleteclick(id);
                      }
                    : (id) {},
              ),
      ),
    );
  }
}

class DesignWeb extends StatelessWidget {
  const DesignWeb({
    super.key,
    required this.data,
    required this.itemgetclick,
    required this.isadmin,
    required this.isdelete,
  });

  final Function(String id) isdelete;
  final bool isadmin;
  final BeritaEntities data;
  final void Function(String id) itemgetclick;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(12),
              child: Hero(
                tag: data.id.toString(),
                child: Image.asset(
                  "assets/images/background/background.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 8,
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          data.judul,
                          style: Theme.of(context).textTheme.displayMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Text(
                          formatTanggalIndonesia(data.createdAt),
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 10,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      isadmin
                          ? Flexible(
                              child: IconButton(
                                onPressed: () {
                                  isdelete(data.id.toString());
                                },
                                icon: Icon(Icons.close),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Text(
                    data.deskripsi,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 10,
                    overflow: TextOverflow.fade,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Logger().d("data id dari card ${data.id}");
                    itemgetclick(data.id.toString());
                  },
                  child: const Text("Selengkapnya"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DesignMobile extends StatelessWidget {
  const DesignMobile({
    super.key,
    required this.data,
    required this.itemgetclick,
    required this.isadmin,
    required this.isdelete,
  });
  final Function(String id) isdelete;
  final bool isadmin;
  final BeritaEntities data;
  final void Function(String id) itemgetclick;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(12),
              child: Hero(
                tag: data.id.toString(),
                child: Image.asset(
                  "assets/images/background/background.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 5,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 9,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          data.judul,
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Text(
                          formatTanggalIndonesia(data.createdAt),
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 10,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Text(
                    data.deskripsi,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 10,
                    overflow: TextOverflow.fade,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Logger().d("data id dari card ${data.id}");
                          itemgetclick(data.id.toString());
                        },
                        child: const Text("Selengkapnya"),
                      ),
                    ),
                    isadmin
                        ? Expanded(
                          child: TextButton(
                              onPressed: () {
                                isdelete(data.id.toString());
                              },
                              child: Text(
                                "Hapus",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            ),
                        )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

String formatTanggalIndonesia(String timestamp) {
  try {
    Logger().d(timestamp);
    DateTime dateTimeUtc = DateTime.parse(timestamp);

    DateTime dateTimeLokal = dateTimeUtc.toLocal();
    return DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(dateTimeLokal);
  } catch (e) {
    // Jika format timestamp salah
    return 'Tanggal tidak valid';
  }
}
