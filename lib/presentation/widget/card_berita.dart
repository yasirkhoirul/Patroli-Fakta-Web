import 'package:flutter/material.dart';
import 'package:patroli_fakta/domain/entities/berita_entities.dart';
import 'package:patroli_fakta/presentation/widget/frostbox.dart';

class CardBerita extends StatelessWidget {
  final BeritaEntities data;
  const CardBerita({super.key,required this.data});
  @override
  Widget build(BuildContext context) {
    return Frostbox(
      height: 300,
      width: 200,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(12),
                  child: Image.asset(
                    "assets/images/background/background.jpg",
                    fit: BoxFit.cover,
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
                    Text(
                      data.judul,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Text(
                      data.deskripsi,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 10,
                      overflow: TextOverflow.fade,
                    ),
                    TextButton(onPressed: (){}, child: const Text("Selengkapnya"))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
