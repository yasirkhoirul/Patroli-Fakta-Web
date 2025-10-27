import 'package:flutter/material.dart';
import 'package:patroli_fakta/domain/usecases/remove_berita.dart';
import 'package:patroli_fakta/presentation/provider/status_provider.dart';

class RemoveberitaNotifier extends ChangeNotifier{
  RemoveBerita removeberita;
  RemoveberitaNotifier({required this.removeberita});
String? _id;
StatusProvider status = StatusIsloading();
  deleteberita(String detailid)async{
    _id = detailid;
    status = StatusIsloading();
    notifyListeners();
    try {
      if(_id == null){
        status = Iserror("Berita tidak ditemukan");
        return;
      }
      await removeberita.execute(_id!);
      status = Issuksesmessage(message: "delete berhasil");
    } catch (e) {
      status = Iserror(e.toString());
    }finally{
      notifyListeners();
    }
  }

  setidle(){
    status = Isidle();
    notifyListeners();
  }
}