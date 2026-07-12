import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:patroli_fakta/domain/entities/berita_entities.dart';
import 'package:patroli_fakta/domain/entities/berita_type.dart';
import 'package:patroli_fakta/domain/usecases/get_all_berita.dart';

class UnverifiedBeritaListNotifier extends ChangeNotifier {
  List<BeritaEntities> _listberita = [];
  List<BeritaEntities> get listberita => _listberita;
  String _message = "";
  String get message => _message;

  UnverifiedBeritaListNotifier({required this.getallberita});

  final GetAllBerita getallberita;

  Future fetchdatalistberita() async {
    try {
      Logger().d("fetch data unverified diajalankan");
      final data = await getallberita.execute(type: BeritaType.unverified);
      Logger().d("data unverified nya adalah ${data.length}");
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
}
