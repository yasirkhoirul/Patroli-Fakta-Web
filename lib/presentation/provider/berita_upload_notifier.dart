import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:patroli_fakta/domain/entities/berita_entities.dart';
import 'package:patroli_fakta/domain/usecases/upload_berita.dart';
import 'package:patroli_fakta/presentation/provider/status_provider.dart';

class BeritaUploadNotifier extends ChangeNotifier{
  final UploadBerita upberita;
  StatusProvider status = Isidle();
  BeritaUploadNotifier(this.upberita);

  setidle(){
    status = Isidle();
    notifyListeners();
  }
  uploadberita(String judul,String deskripsi)async{
    if(judul.isEmpty || deskripsi.isEmpty){
      status = Iserror("Judul atau deskripsi tidak boleh kososng");
      notifyListeners();
      return;
    }
    status = StatusIsloading();
    notifyListeners();
    try {
      Logger().d("masuk notifier dikirim ke usecase $judul");
      await upberita.execute(BeritaEntities(0, judul, deskripsi, ""));
      status = Issuksesmessage(message: "berhasil");
    } catch (e) {
      status = Iserror(e.toString());
    }finally{
      notifyListeners();
    }

  }
}