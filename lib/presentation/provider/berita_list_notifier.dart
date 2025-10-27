import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:patroli_fakta/domain/entities/berita_entities.dart';
import 'package:patroli_fakta/domain/usecases/get_all_berita.dart';

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
      Logger().d("data nya lis berita adalah ${listberita}");
        _message = "Data Berhasil Didapatkan";
        Logger().d(message);
      }
    } catch (e) {
      _message = e.toString();
        Logger().d(message);
    }finally{
      notifyListeners();
    }
  }
}
