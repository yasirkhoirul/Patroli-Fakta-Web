import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:patroli_fakta/domain/entities/berita_entities.dart';
import 'package:patroli_fakta/domain/usecases/get_all_berita.dart';
import 'package:url_launcher/url_launcher.dart';

class BeritaListNotifier extends ChangeNotifier {
  List<BeritaEntities> _listberita = [];
  List<BeritaEntities> get listberita => _listberita;
  String _message = "";
  String get message => _message;

  BeritaListNotifier({required this.getallberita});

  final GetAllBerita getallberita;

  Future fetchdatalistberita() async {
    try {
      Logger().d("fetch data diajalankan");
      final data = await getallberita.execute();
      Logger().d("data nya adalah ${data.length}");
      if (data.isNotEmpty) {
        _listberita = data;
        _message = "Data Berhasil Didapatkan";
        Logger().d(message);
      } else {
        _listberita = [];
        _message = "Tidak ada berita terbaru";
      }
    } catch (e) {
      _message = e.toString();
      Logger().d(message);
    } finally {
      notifyListeners();
    }
  }

  Future goInstagram() async{
    final uri = Uri.parse("https://instagram.com/patrolifakta");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Tidak dapat membuka $uri');
    }
  }
  Future gotwitter() async{
    final uri = Uri.parse("https://twitter.com/patrolifakta");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Tidak dapat membuka $uri');
    }
  }
}
