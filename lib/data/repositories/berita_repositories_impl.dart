import 'package:logger/logger.dart';
import 'package:patroli_fakta/data/data_source/data_berita_remote_source.dart';
import 'package:patroli_fakta/data/model/berita_model.dart';
import 'package:patroli_fakta/domain/entities/berita_entities.dart';
import 'package:patroli_fakta/domain/repositories/berita_repositories.dart';

class BeritaRepositoriesImpl implements BeritaRepositories{
  final DataBeritaRemoteSource remoteDataSource;
  BeritaRepositoriesImpl(this.remoteDataSource);
  @override
  Future<List<BeritaEntities>> getAllBerita() async{
    Logger().d("repo data diajalankan");

    try {
      final data = await remoteDataSource.getListBerita();
      return data.map((e) => e.toEntities(),).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<BeritaEntities> getDetailBerita(id) async{
    try {
      final data = await remoteDataSource.getDetailBerita(id);
      return data.toEntities();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future removeBerita(id) async{
    try {
      await remoteDataSource.removeBerita(id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future updateBerita(BeritaEntities data) async{
    try {
      await remoteDataSource.update(BeritaModel.fromEntity(data));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future uploadBerita(BeritaEntities data) async{
    try {
      Logger().d("masuk repo data ${data.judul}");
      await remoteDataSource.uploadBerita(BeritaModel.fromEntity(data)); 
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}