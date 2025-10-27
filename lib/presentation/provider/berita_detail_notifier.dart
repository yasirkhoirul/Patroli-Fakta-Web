import 'package:flutter/material.dart';
import 'package:patroli_fakta/domain/entities/berita_entities.dart';
import 'package:patroli_fakta/domain/usecases/get_detail_berita.dart';
import 'package:patroli_fakta/presentation/provider/status_provider.dart';

class BeritaDetailNotifier extends ChangeNotifier {
  String? _id;
  BeritaEntities? _data;
  BeritaEntities? get data => _data;
  StatusProvider status = StatusIsloading();
  BeritaDetailNotifier({required this.beritadata});
  GetDetailBerita beritadata;

  getDetail(String? detailid) async {
    _id = detailid;
    status = StatusIsloading();
    notifyListeners();
    try {
      if (_id == null) {
        status = Iserror("Berita tidak ditemukan");
      } else {
        final data = await beritadata.execute(_id!);
        status = IsuksesDetail(data);
        _data = data;
      }
    } catch (e) {
      status = Iserror(e.toString());
    } finally {
      notifyListeners();
    }
  }

  setidle() {
    status = Isidle();
    notifyListeners();
  }
}
